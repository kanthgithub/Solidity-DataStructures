pragma solidity ^0.4.24;

contract Dequeue {
    mapping(uint256 => bytes) dequeue;
    uint256 first = 2**255;
    uint256 last = first - 1;

    function pushLeft(bytes data) public {
        first -= 1;
        dequeue[first] = data;
    }

    function pushRight(bytes data) public {
        last += 1;
        dequeue[last] = data;
    }

    function popLeft() public returns (bytes data) {
        require(last >= first);  // non-empty dequeue

        data = dequeue[first];

        delete dequeue[first];
        first += 1;
    }

    function popRight() public returns (bytes data) {
        require(last >= first);  // non-empty dequeue

        data = dequeue[last];

        delete dequeue[last];
        last -= 1;
    }
}