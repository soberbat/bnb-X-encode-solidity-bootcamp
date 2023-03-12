// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.18;


contract DogCoin {
    uint256 public totalSupply;
    address owner;
    Payment[] payments;

    mapping(address => uint256) balances;
    mapping(address => Payment[]) public paymentOperations;

    event supplyChange(uint256 _totalSupply);
    event logTransfer(uint256 _amount, address _receiver);

    struct Payment {
        address _address;
        uint256 _amount;
    }


    constructor(){ 
        totalSupply = 2000000;
        owner = msg.sender;
        balances[msg.sender] = totalSupply;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "no owner");
        _;
    }

    function getSupply()  public view  returns(uint256) {
        return totalSupply;
    }

    function increaseTotalSupply() public onlyOwner {
        totalSupply += 1000;
        emit supplyChange(1000);
    }

    function getBalances(address _address) public view returns(uint256) {
        return balances[_address];
    }

    function getPayments(address _address) public view returns(Payment[] memory) {
        return paymentOperations[_address];
    }

    function transfer(uint256 _amount, address _receiver) public {
        balances[_receiver] = _amount;
        balances[msg.sender] -= totalSupply;
        emit logTransfer(_amount,_receiver);

        paymentOperations[msg.sender].push(Payment({_address: _receiver, _amount: _amount }));
    }

}