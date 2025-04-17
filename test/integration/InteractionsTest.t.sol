// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test} from "forge-std/Test.sol";
import{FundMe} from "../../src/FundMe.sol";
import {DeployFundMe} from "../../script/DeployFundMe.s.sol";
import {console} from "forge-std/console.sol";
import {FundFundMe,WithdrawFundMe} from "../../script/interactions.s.sol";


contract FundMeTestIntegration is Test {
    uint256 public constant STARTING_USER_BALANCE = 10 ether;
    address USER = makeAddr("user");
    uint256 public constant SEND_VALUE = 0.1 ether;
    FundMe fundMe;




    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
        vm.deal(USER,STARTING_USER_BALANCE);
    }

    function testUserCanFundAndOwnerWithdraw() public {
        FundFundMe fundFundMe = new FundFundMe();
        fundFundMe.fundFundMe(address(fundMe));

        WithdrawFundMe withdrawFundMe = new WithdrawFundMe();
        withdrawFundMe.withdrawFundMe(address(fundMe));
       
        assertEq(address(fundMe).balance, 0);
    }

}