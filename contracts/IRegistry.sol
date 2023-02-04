// SPDX-License-Identifier: MIT
pragma solidity ^0.8.16;

interface iRegistry {
    event Switch(
        uint256 indexed timestamp,
        uint256 indexed meter_id,
        bool indexed state,
        address from
    );

    function _switch(uint256 meter_id, bool state) external;

    function stateOf(uint256 meter_id) external view returns (bool);
}
