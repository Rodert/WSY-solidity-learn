// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

// function (<parameter types>) {internal|external} [pure|view|payable] [returns (<return types>)]

contract FunctionTypes{
    uint256 public number = 5;
    
    constructor() payable {}

    function add() external{
        number = number + 1;
    }

    // pure: 英/pjʊə(r) 纯。 函数既不能读取也不能写入链上的状态变量
    function addPure(uint256 _number) external pure returns(uint256 new_number){
        new_number = _number+1;
    }
    
    // view: 英/vjuː 。函数能读取但也不能写入状态变量。
    function addView() external view returns(uint256 new_number) {
        new_number = number + 1;
    }

    // internal: 内部函数
    function minus() internal {
        number = number - 1;
    }

    // 只能被合约之外函数调用，不能被合约内函数调用。
    function minusCall() external {
        minus();
    }

    // payable: 能给合约支付 eth 的函数。
    function minusPayable() external payable returns(uint256 balance) {
        minus();    
        balance = address(this).balance;
    }
}