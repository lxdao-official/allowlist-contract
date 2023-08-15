// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.15;

import {Delegatable} from "lib/delegatable-sol/contracts/Delegatable.sol";
import {DelegatableCore} from "lib/delegatable-sol/contracts/DelegatableCore.sol";

import "lib/openzeppelin-contracts/contracts/access/Ownable.sol";

contract AllowList is Delegatable, Ownable {
    constructor() Delegatable("AllowList", "1") {}

    mapping(address => bool) public allowlist;

    event AllowItemAdded(address indexed addr);
    event AllowItemRemoved(address indexed addr);

    function setAllowItem(address addr) public onlyOwner {
        allowlist[addr] = true;
        emit AllowItemAdded(addr);
    }

    function removeAllowItem(address addr) public onlyOwner {
        allowlist[addr] = false;
        emit AllowItemRemoved(addr);
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
