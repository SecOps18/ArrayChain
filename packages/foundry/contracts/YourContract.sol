//SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import {console} from "forge-std/console.sol";

/**
 * @title YourContract - Lorem Ipsum Array Manipulation Contract
 * @author Vishal
 * @notice A smart contract that implements array manipulation functions
 * @dev Features include:
 * - Lorem Ipsum array storage and manipulation
 * - Array operations (get first/last n elements, get by index, reverse, change element)
 * - Payable functions for array operations
 * - Withdrawal functionality for the owner
 * All functions requiring payment have specific ETH requirements:
 * - getFirstN, getLastN, getAtIndex: 0.01 ETH
 * - changeElement: 0.03 ETH
 * - reverseArray: 0.05 ETH
 */
contract YourContract {
    // State Variables
    address public immutable OWNER;
    bytes32[] public loremIpsumArray;
    uint256 public currentNumber;
    
    // Events for tracking contract operations
    event ArrayOperation(string operation, address caller, uint256 value);
    event ElementChanged(uint256 index, bytes32 oldValue, bytes32 newValue);

    // Constructor: Initializes the contract with Lorem Ipsum array and currentNumber
    constructor(address _owner) {
        OWNER = _owner;
        currentNumber = 5;
        
        // Initialize Lorem Ipsum array with some sample text
        loremIpsumArray.push(bytes32("Lorem ipsum dolor sit amet"));
        loremIpsumArray.push(bytes32("consectetur adipiscing elit"));
        loremIpsumArray.push(bytes32("sed do eiusmod tempor"));
        loremIpsumArray.push(bytes32("incididunt ut labore"));
        loremIpsumArray.push(bytes32("et dolore magna aliqua"));
    }

    // Modifier: used to define a set of rules that must be met before or after a function is executed
    // Check the withdraw() function
    modifier isOwner() {
        // msg.sender: predefined variable that represents address of the account that called the current function
        require(msg.sender == OWNER, "Not the Owner");
        _;
    }

    /**
     * Helper function to convert a string to bytes32
     * @param source the string to convert
     * @return result the converted bytes32
     */
    function stringToBytes32(string memory source) public pure returns (bytes32 result) {
        bytes memory tempEmptyStringTest = bytes(source);
        if (tempEmptyStringTest.length == 0) {
            return 0x0;
        }

        assembly {
            result := mload(add(source, 32))
        }
    }

    /**
     * Function that allows the owner to withdraw all the Ether in the contract
     * The function can only be called by the owner of the contract as defined by the isOwner modifier
     */
    function withdraw() public isOwner {
        (bool success, ) = OWNER.call{value: address(this).balance}("");
        require(success, "Failed to send Ether");
    }

    /**
     * Get the first n elements from the array
     * @param n number of elements to return
     * @return result array of first n elements
     */
    function getFirstN(uint256 n) public payable returns (bytes32[] memory) {
        require(msg.value >= 0.01 ether, "Send at least 0.01 ETH");
        require(n <= loremIpsumArray.length, "n is larger than array length");
        
        bytes32[] memory result = new bytes32[](n);
        for (uint256 i = 0; i < n; i++) {
            result[i] = loremIpsumArray[i];
        }
        
        emit ArrayOperation("getFirstN", msg.sender, msg.value);
        return result;
    }

    /**
     * Get the last n elements from the array
     * @param n number of elements to return
     * @return result array of last n elements
     */
    function getLastN(uint256 n) public payable returns (bytes32[] memory) {
        require(msg.value >= 0.01 ether, "Send at least 0.01 ETH");
        require(n <= loremIpsumArray.length, "n is larger than array length");
        
        bytes32[] memory result = new bytes32[](n);
        uint256 startIndex = loremIpsumArray.length - n;
        for (uint256 i = 0; i < n; i++) {
            result[i] = loremIpsumArray[startIndex + i];
        }
        
        emit ArrayOperation("getLastN", msg.sender, msg.value);
        return result;
    }

    /**
     * Get element at specific index
     * @param index the index to get
     * @return element at the specified index
     */
    function getAtIndex(uint256 index) public payable returns (bytes32) {
        require(msg.value >= 0.01 ether, "Send at least 0.01 ETH");
        require(index < loremIpsumArray.length, "Index out of bounds");
        
        emit ArrayOperation("getAtIndex", msg.sender, msg.value);
        return loremIpsumArray[index];
    }

    /**
     * Reverse the array
     */
    function reverseArray() public payable {
        require(msg.value >= 0.05 ether, "Send at least 0.05 ETH");
        
        uint256 length = loremIpsumArray.length;
        for (uint256 i = 0; i < length / 2; i++) {
            bytes32 temp = loremIpsumArray[i];
            loremIpsumArray[i] = loremIpsumArray[length - 1 - i];
            loremIpsumArray[length - 1 - i] = temp;
        }
        
        emit ArrayOperation("reverseArray", msg.sender, msg.value);
    }

    /**
     * Change element at specific index
     * @param index the index to change
     * @param newValue the new string value to set
     */
    function changeElement(uint256 index, string memory newValue) public payable {
        require(msg.value >= 0.03 ether, "Send at least 0.03 ETH");
        require(index < loremIpsumArray.length, "Index out of bounds");
        require(bytes(newValue).length > 0, "Empty string not allowed");
        
        bytes32 oldValue = loremIpsumArray[index];
        loremIpsumArray[index] = stringToBytes32(newValue);
        
        emit ElementChanged(index, oldValue, loremIpsumArray[index]);
        emit ArrayOperation("changeElement", msg.sender, msg.value);
    }

    /**
     * Get the length of the array
     * @return length of the array
     */
    function getArrayLength() public view returns (uint256) {
        return loremIpsumArray.length;
    }

    /**
     * Function that allows the contract to receive ETH
     */
    receive() external payable {}
}
