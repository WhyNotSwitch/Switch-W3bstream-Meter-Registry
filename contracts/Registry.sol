// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/UUPSUpgradeable.sol";

import "./IRegistry.sol";

contract Registry is
    iRegistry,
    Initializable,
    AccessControlUpgradeable,
    UUPSUpgradeable
{
    // map device id -> state
    mapping(uint256 => bool) private _state;

    bytes32 public constant UPGRADER_ROLE = keccak256("UPGRADER_ROLE");
    bytes32 public constant W3BSTREAM_ROLE = keccak256("W3BSTREAM_ROLE");

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize() public initializer {
        __AccessControl_init();
        __UUPSUpgradeable_init();

        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(UPGRADER_ROLE, msg.sender);
    }

    function _authorizeUpgrade(address newImplementation)
        internal
        override
        onlyRole(UPGRADER_ROLE)
    {}

    function _switch(uint256 meter_id, bool state)
        external
        onlyRole(W3BSTREAM_ROLE)
    {
        emit Switch(block.timestamp, meter_id, state, msg.sender);
        _state[meter_id] = state;
    }

    function stateOf(uint256 meter_id) external view returns (bool) {
        return _state[meter_id];
    }
}
