// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2} from "forge-std/Test.sol";
import {AllowList} from "../src/AllowList.sol";

contract AllowListTest is Test {
    AllowList public allowlist;

    function setUp() public {
        allowlist = new AllowList();
    }

    function testSetAllowList() public {
        allowlist.setAllowItem(0x17c57bD297175e5711Ee3Daf045252B588f3162F);
        assertEq(
            allowlist.verify(0x17c57bD297175e5711Ee3Daf045252B588f3162F),
            true
        );
    }

    function testRemoveAllowList() public {
        allowlist.removeAllowItem(0x17c57bD297175e5711Ee3Daf045252B588f3162F);
        assertEq(
            allowlist.verify(0x17c57bD297175e5711Ee3Daf045252B588f3162F),
            false
        );
    }
}
