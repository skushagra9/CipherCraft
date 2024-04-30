
// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.7.0 <0.9.0;

contract CipherCraft{
   mapping(address account => uint256) private _balances;
   mapping(address account => mapping(address spender => uint256)) private _allowances;
    
event Transfer(address indexed from, address indexed to, uint256 value);
    uint8 public decimals = 18;
    uint256 public _totalSupply = 1000000 * (10 ** uint256(decimals));


    string private _name = "CipherCraft";
    string private _symbol = "CCR";

    constructor() {
      _balances[msg.sender] = _totalSupply;
    }

    function name() public view returns(string memory){
      return _name;
    }

    function symbol() public view returns(string memory){
      return _symbol;
    }

    function totalSupply() public view returns(uint){
      return _totalSupply;
    }

    function balanceOf(address _myaddress) public view returns(uint){
      return _balances[_myaddress];
    }

    function transfer(address to, uint value) public returns(bool){
      address sender = msg.sender;
      _transfer(sender, to, value);
      return true;
    }

    function giveallowances(address owner, address spender) private  {
      _allowances[owner][spender] = 20000;
    }

    function transferFrom(address from, address to, uint256 value) public virtual returns (bool) {
        giveallowances(from, to); 
      if (_balances[msg.sender] < value) {
        _transfer(from, to, value);
        return true;
        }
        else{
          return false;
        }
    }

    function _transfer(address from, address to, uint value) internal{
      if (from == address(0) || to == address(0)) {
        revert("account undefined");
    }
    _update(from, to, value);
    }

    function _update(address from, address to, uint value) internal virtual {
      if (from == address(0)) {
        _totalSupply += value;
      }
      else{
        if (_balances[from] < value) {
          revert("Insufficient balance");
        }
              _balances[from] -= value;
      }
      if (to == address(0)) {
        _totalSupply -= value;
      }
      else{
         _balances[to] += value;
      }
      emit Transfer(from, to, value);
    }

    function _mint(address account, uint amount) public {
      if (account == address(0)) {
        revert("account undefined");
    }
    _update(address(0), account , amount);
    }
    
    function _burn(address account, uint amount) public {
      if (account == address(0)) {
        revert("account undefined");
    }
    _update(account, address(0) , amount);
    }
    }


