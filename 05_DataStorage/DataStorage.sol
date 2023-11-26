// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;

contract DataStorage{
    // [1, 2, 3] 
    // 结构体 
    // user struct {
    //     id：
    //     name:
    //     age:
    // }
    // uint 
    // storage memory calldata
    // storage： 合约里的状态变量默认都是storage，存储在链上。
    // memory： 函数里的参数和临时变量一般用memory，存储在内存中，不上链。
    // calldata： 和 memory 类似，存储在内存中，不上链。与memory的不同点在于calldata变量不能修改（immutable），一般用于函数的参数。

    function fCalldata(uint[] calldata _x) public pure returns(uint[] calldata){
        //参数为calldata数组，不能被修改
        // _x[0] = 0 //这样修改会报错
        // _X[0] = 1;
        return(_x);
    }



    uint[] x = [1,2,3]; // 状态变量：数组 x

    function fStorage() public{
        //声明一个storage的变量 xStorage，指向x。修改xStorage也会影响x
        uint[] storage xStorage = x;
        xStorage[0] = 100;
    }

}

contract Variables {
    uint public x = 1;
    uint public y;
    string public z;

    // external 合约外部可调用
    function foo() external{
        // 可以在函数里更改状态变量的值
        x = 5;
        y = 2;
        z = "0xAA";
    }

    // 局部变量。是仅在函数执行过程中有效的变量，函数退出后，变量无效。局部变量的数据存储在内存里，不上链，gas低。
    function bar() external pure returns(uint){
        uint xx = 1;
        uint yy = 3;
        uint zz = xx + yy;
        return(zz);
    }

    // 全局变量是全局范围工作的变量，都是solidity预留关键字。他们可以在函数内不声明直接使用：
    function global() external view returns(address, uint, bytes memory){
        address sender = msg.sender;
        uint blockNum = block.number;
        bytes memory data = msg.data;
        return(sender, blockNum, data);
    }

    // blockhash(uint blockNumber): (bytes32) 给定区块的哈希值 – 只适用于256最近区块, 不包含当前区块。
    // block.coinbase: (address payable) 当前区块矿工的地址
    // block.gaslimit: (uint) 当前区块的gaslimit
    // block.number: (uint) 当前区块的number
    // block.timestamp: (uint) 当前区块的时间戳，为unix纪元以来的秒
    // gasleft(): (uint256) 剩余 gas
    // msg.data: (bytes calldata) 完整call data
    // msg.sender: (address payable) 消息发送者 (当前 caller)
    // msg.sig: (bytes4) calldata的前四个字节 (function identifier)
    // msg.value: (uint) 当前交易发送的wei值

    // 以太单位与时间单位
    // wei: 1
    // gwei: 1e9 = 1000000000
    // ether: 1e18 = 1000000000000000000
    function weiUnit() external pure returns(uint) {
        assert(1 wei == 1e0);
        assert(1 wei == 1);
        return 1 wei;
    }

    function gweiUnit() external pure returns(uint) {
        assert(1 gwei == 1e9);
        assert(1 gwei == 1000000000);
        return 1 gwei;
    }

    function etherUnit() external pure returns(uint) {
        assert(1 ether == 1e18);
        assert(1 ether == 1000000000000000000);
        return 1 ether;
    }

    // seconds: 1
    // minutes: 60 seconds = 60
    // hours: 60 minutes = 3600
    // days: 24 hours = 86400
    // weeks: 7 days = 604800
    // 缺省值 seconds
    function secondsUnit() external pure returns(uint) {
        assert(1 seconds == 1);
        return 1 seconds;
    }

    function minutesUnit() external pure returns(uint) {
        assert(1 minutes == 60);
        assert(1 minutes == 60 seconds);
        return 1 minutes;
    }

    function hoursUnit() external pure returns(uint) {
        assert(1 hours == 3600);
        assert(1 hours == 60 minutes);
        return 1 hours;
    }

    function daysUnit() external pure returns(uint) {
        assert(1 days == 86400);
        assert(1 days == 24 hours);
        return 1 days;
    }

    function weeksUnit() external pure returns(uint) {
        assert(1 weeks == 604800);
        assert(1 weeks == 7 days);
        return 1 weeks;
    }


}
