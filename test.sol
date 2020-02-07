pragma solidity ^0.6.1;

contract testContract
{

    uint _avotes;
    uint _bvotes;
    uint _cvotes;

    mapping(address => uint) public accounts;

    constructor () public
    {
        _avotes = 0;
        _bvotes = 0;
        _cvotes = 0;
    }

    function getAvotes() public view returns(uint)
    {
        return _avotes;
    }

    function getBvotes() public view returns(uint)
    {
        return _bvotes;
    }

    function getCvotes() public view returns(uint)
    {
        return _cvotes;
    }

    function votedA() internal returns(bool)
    {
        _avotes++;
        return true;
    }

    function votedB() internal returns(bool)
    {
        _bvotes++;
        return true;
    }

    function votedC() internal returns(bool)
    {
        _cvotes++;
        return true;
    }
}