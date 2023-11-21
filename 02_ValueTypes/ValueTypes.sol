// SPDX-License-Identifier: MIT
pragma solidity ^0.8.22;
contract ValueTypes{
    // 布尔值
    bool public _bool = true;
    // 布尔运算
    bool public _bool1 = !_bool; //取非
    bool public _bool2 = _bool && _bool1; //与
    bool public _bool3 = _bool || _bool1; //或
    bool public _bool4 = _bool == _bool1; //相等
    bool public _bool5 = _bool != _bool1; //不相等


    // 整数
    int public _int = -1;
    uint public _uint = 1;
    uint256 public _number = 20231121;
    // 整数运算
    uint256 public _number1 = _number + 1; // +，-，*，/
    uint256 public _number2 = 2**2; // 指数
    uint256 public _number3 = 7 % 2; // 取余数
    bool public _numberbool = _number2 > _number3; // 比大小


    // 地址
    address public _address = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address payable public _address1 = payable(_address); // payable address，可以转账、查余额
    // 地址类型的成员
    uint256 public balance = _address1.balance; // balance of address
    if (balance > 10) _address1.transfer(10); // 转账
    
    
    // 固定长度的字节数组
    bytes32 public _byte32 = "SimpleSolidity"; // bytes32: 0x53696d706c65536f6c6964697479000000000000000000000000000000000000
    bytes1 public _byte = _byte32[0]; // bytes1: 0x53


    // Enum
    // 将 uint 0， 1， 2 表示为 Buy, Hold, Sell
    enum ActionSet { Buy, Hold, Sell }
    // 创建 enum 变量 action
    ActionSet action = ActionSet.Buy;

    // enum可以和uint显式的转换
    function enumToUint() external view returns(uint){
        return uint(action);
    }
}
