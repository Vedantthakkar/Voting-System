pragma solidity ^0.6.1;

contract Exchange{
    address payable[] recipients;

    function sebdEther(address payable recipient) external{
        recipient.transfer(1 ether);

        address a; 
        a = recipient;
        a.transfer(100);
        msg.sender.transfer(100);
        recipient.send(1 ether);
    }
}