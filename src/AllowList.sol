// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Delegatable} from "lib/delegatable-sol/contracts/Delegatable.sol";
import {DelegatableCore} from "lib/delegatable-sol/contracts/DelegatableCore.sol";

// import "lib/OpenZeppelin/openzeppelin-contracts/access/Ownable.sol";

contract AllowList is Delegatable {
    constructor() Delegatable("AllowList", "1") {}

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

    function _msgSender()
        internal
        view
        virtual
        override(DelegatableCore, Context)
        returns (address sender)
    {
        if (msg.sender == address(this)) {
            bytes memory array = msg.data;
            uint256 index = msg.data.length;
            assembly {
                sender := and(
                    mload(add(array, index)),
                    0xffffffffffffffffffffffffffffffffffffffff
                )
            }
        } else {
            sender = msg.sender;
        }
        return sender;
    }
}
