/**
 *Submitted for verification at Etherscan.io on 2017-12-12
*/

// Copyright (C) 2015, 2016, 2017 Dapphub

// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.4.18;

contract WETH9 {
    string public name     = "Wrapped Ether"; // 名称
    string public symbol   = "WETH"; // 简称
    uint8  public decimals = 18; // 精度

    event  Approval(address indexed src, address indexed guy, uint wad);
    event  Transfer(address indexed src, address indexed dst, uint wad);
    event  Deposit(address indexed dst, uint wad);
    event  Withdrawal(address indexed src, uint wad);

    mapping (address => uint)                       public  balanceOf; // 地址-WETH金额映射，
    mapping (address => mapping (address => uint))  public  allowance; // 授权 map

    function() public payable { // 存款。payable 表示可以接受以太坊（Ether）的支付
        deposit();
    }
    function deposit() public payable { // 存款。转入 ETH，将增加当前用户的 WETH 数额
        balanceOf[msg.sender] += msg.value;
        Deposit(msg.sender, msg.value);
    }

    function withdraw(uint wad) public { // 取款。取回 ETH，转入的 WETH 就是要取回的 ETH
        require(balanceOf[msg.sender] >= wad); // 校验余额
        balanceOf[msg.sender] -= wad;
        msg.sender.transfer(wad); // 发起转账
        Withdrawal(msg.sender, wad); // 事件
    }

    function totalSupply() public view returns (uint) { // WETH 合约拥有的 ETH 总数
        return this.balance; // 当前地址的 balance 数额
    }

    function approve(address guy, uint wad) public returns (bool) { // 用户给 guy 地址授权 wad 数额
        allowance[msg.sender][guy] = wad;
        Approval(msg.sender, guy, wad);
        return true;
    }

    // WETH token 转移
    function transfer(address dst, uint wad) public returns (bool) {
        return transferFrom(msg.sender, dst, wad);
    }

    // 当用户拥有被授权的 token 时，可以直接调用 transferFrom 转移资产
    function transferFrom(address src, address dst, uint wad)
        public
        returns (bool)
    {
        require(balanceOf[src] >= wad);

        if (src != msg.sender && allowance[src][msg.sender] != uint(-1)) {
            require(allowance[src][msg.sender] >= wad);
            allowance[src][msg.sender] -= wad;
        }

        balanceOf[src] -= wad;
        balanceOf[dst] += wad;

        Transfer(src, dst, wad);

        return true;
    }
}
