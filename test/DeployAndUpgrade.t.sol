// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;
import {Test} from "forge-std/Test.sol";
import {DeployBox} from "../script/DeployBox.s.sol";
import {UpgradeBox} from "../script/UpgradeBox.s.sol";
import {BoxV1} from "../src/BoxV1.sol";
import {BoxV2} from "../src/BoxV2.sol";

contract DeployAndUpgrade is Test{
    DeployBox public deployer;
    UpgradeBox public upgrader;
    address public OWNER = makeAddr("owner");
    address public proxy;
    function setUp() public{
      deployer = new DeployBox();
      upgrader = new UpgradeBox();
      proxy = deployer.run();
    }
    function testStartsAtBoxV1() external{
      vm.expectRevert();
      BoxV2(proxy).setValue(8);
    }
    function testUpgrade() public{
      BoxV2 box2 = new BoxV2();
      upgrader.upgradeBox(proxy,address(box2));
      uint256 expectedVersion = 2;
      assertEq(expectedVersion, BoxV2(proxy).getVersion());
      BoxV2(proxy).setValue(8);
      assertEq(8, BoxV2(proxy).getValue());
    }
}