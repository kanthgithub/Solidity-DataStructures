pragma solidity ^0.4.24;

contract Stack {
    bytes[] stack;

    function push(bytes data) public {
        stack.push(data);
    }

    function pop() public returns (bytes data) {
        data = stack[stack.length - 1];

        stack.length -= 1;
    }
}