// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract AllowList {
    mapping(address => bool) allowlist;

    function setAllowItem(address addr) public {
        allowlist[addr] = true;
    }

    function removeAllowItem(address addr) public {
        allowlist[addr] = false;
    }

    function verify(address addr) public view returns (bool) {
        return allowlist[addr];
    }
}
