// SPDX-License-Identifier: UNLICENSED

// DO NOT MODIFY BELOW THIS
pragma solidity ^0.8.17;

import "hardhat/console.sol";

contract Splitwise {
// DO NOT MODIFY ABOVE THIS

// ADD YOUR CONTRACT CODE BELOW
    // debtor => creditor
    mapping(address => mapping (address => uint32)) private owe;

  // Returns the amount that the debtor owes the creditor.
    function lookup(address debtor, address creditor) public view returns (uint32 ret) {
        return owe[debtor][creditor];
    } 

    function addIOU(address creditor, uint32 amount, address[] memory path) external {
        require(amount > 0);


        if (path.length > 0) {
            uint32 min = amount;

                // find min
                for (uint i = 1; i < path.length; i++) {
                    address from = path[i-1];
                    address to = path[i];
                    uint32 amt = owe[from][to];

                    if (amt < min) {
                    min = amt;
                    }
                }

                for (uint i = 1; i < path.length; i++) {
                    address from = path[i-1];
                    address to = path[i];
                    owe[from][to] -= min;
                }

            amount -= min;
        }

        if (amount == 0) {
        return;
        }
        owe[msg.sender][creditor] += amount;
        
    }



}
