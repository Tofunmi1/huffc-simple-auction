//// SPDX-License-Identifier: MIT
pragma solidity ^0.8.6;

import {Test} from "../lib/forge-std/src/Test.sol";

interface ISimpleAuction {
    function bid() external payable;

    function withdraw() external returns (bool);

    function auctionEnd() external;

    function alternativeConstructor(
        uint256 biddingTime,
        address payable beneficiaryAddress
    ) external;

    function returnBeneficary() external returns (bool);

    function returnAuctionEndTime() external returns (address);

    function returnHighestBidder() external returns (address);

    function returnHighestBid() external returns (uint256);
}

interface Vm {
    function warp(uint256 x) external;

    function prank(address sender) external;

    function deal(address, uint256) external;
}

contract SimpleAutionHuffTest is Test {
    address internal huffAuctionAddr;
    address payable internal beneficiaryAddress;
    Vm VM = Vm(HEVM_ADDRESS);

    function setUp() public {
        address _huffAuctionAddr;
        address payable _beneficiaryAddress;
        //hardcoding the constructor aguements to the end
        bytes
            memory byteCode = hex"60003560E01c80631998aeef1461007d5780633ccfd60b146101055780632664e13d146101785780633932584714610069578063cdcbc59a146101de578063090dd2f6146101ea578063d442aa62146101f65780634b8674651461020257806312fa6feb1461020e575b600060055535600460005535602442016001555b60015442116100cc576000600354106100cc576000600354146100cc576000600354116100d2576000600354106100d257336002546003540160046000526000602001526040600020556100d2565b60006000fd5b6002543355600354345533347f647278fbea15328be1b007ec17fcfe9994a32acf8436adaed9859b1300757e2a60206000a35b33600460005260006020015260406000205460001061016257336000600460005260006020015260406000205563a52c101e60005233600460005260006020015260406000205460045260206000602460006000335af11561016d575b600160005260206000f35b600060005260206000f35b60015442106101d8576001600554146101d85760016005556002546003547f647278fbea15328be1b007ec17fcfe9994a32acf8436adaed9859b1300757e2a60206000a36312514bba60005260035460045260206000602460006000335af15b60006000fd5b60005460005260206000f35b60035460005260206000f35b60025460005260206000f35b60015460005260206000f35b6005546001146102235760055460001461022e575b600160005260206000f35b600060005260206000f3";

        bytes32 create2Salt = keccak256(abi.encode(123));

        assembly {
            _huffAuctionAddr := create2(
                0,
                add(byteCode, 0x20),
                mload(byteCode),
                create2Salt
            )
        }

        assembly {
            _beneficiaryAddress := create(0, 0, 0)
        }
        beneficiaryAddress = _beneficiaryAddress;
        huffAuctionAddr = _huffAuctionAddr;
    }

    function testBidNotRevert() public {
        ISimpleAuction(huffAuctionAddr).alternativeConstructor(
            2 minutes,
            beneficiaryAddress
        );
        address highestBidder = ISimpleAuction(huffAuctionAddr)
            .returnHighestBidder();

        uint256 highestBid = ISimpleAuction(huffAuctionAddr).returnHighestBid();
        VM.warp(1 minutes);
        ISimpleAuction(huffAuctionAddr).bid();
        assertEq(highestBidder, msg.sender);
    }
}
