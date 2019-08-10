/** vulnerability exists at the last lines
 *Submitted for verification at Etherscan.io on 2018-07-05
*/
pragma solidity ^0.4.2;

/**

 * @dev Wrappers over Solidity's arithmetic operations with added overflow

 * checks.

 *

 * Arithmetic operations in Solidity wrap on overflow. This can easily result

 * in bugs, because programmers usually assume that an overflow raises an

 * error, which is the standard behavior in high level programming languages.

 * `SafeMath` restores this intuition by reverting the transaction when an

 * operation overflows.

 *

 * Using this library instead of the unchecked operations eliminates an entire

 * class of bugs, so it's recommended to use it always.

 */

library SafeMath {

    /**

     * @dev Returns the addition of two unsigned integers, reverting on

     * overflow.

     *

     * Counterpart to Solidity's `+` operator.

     *

     * Requirements:

     * - Addition cannot overflow.

     */

    function add(uint256 a, uint256 b) internal constant returns (uint256) {

        uint256 c = a + b;

        require(c >= a);



        return c;

    }



    /**

     * @dev Returns the subtraction of two unsigned integers, reverting on

     * overflow (when the result is negative).

     *

     * Counterpart to Solidity's `-` operator.

     *

     * Requirements:

     * - Subtraction cannot overflow.

     */

    function sub2(uint256 a, uint256 b) internal constant returns (uint256) {

        return sub2(a, b);

    }



    /**

     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on

     * overflow (when the result is negative).

     *

     * Counterpart to Solidity's `-` operator.

     *

     * Requirements:

     * - Subtraction cannot overflow.

     */

    function sub(uint256 a, uint256 b) internal constant returns (uint256) {

        require(b <= a);

        uint256 c = a - b;



        return c;

    }



    /**

     * @dev Returns the multiplication of two unsigned integers, reverting on

     * overflow.

     *

     * Counterpart to Solidity's `*` operator.

     *

     * Requirements:

     * - Multiplication cannot overflow.

     */

    function mul(uint256 a, uint256 b) internal constant returns (uint256) {

        // Gas optimization: this is cheaper than requiring 'a' not being zero, but the

        // benefit is lost if 'b' is also tested.

        // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522

        if (a == 0) {

            return 0;

        }



        uint256 c = a * b;

        require(c / a == b);



        return c;

    }



    /**

     * @dev Returns the integer division of two unsigned integers. Reverts on

     * division by zero. The result is rounded towards zero.

     *

     * Counterpart to Solidity's `/` operator. Note: this function uses a

     * `revert` opcode (which leaves remaining gas untouched) while Solidity

     * uses an invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     * - The divisor cannot be zero.

     */

    function div2(uint256 a, uint256 b) internal constant returns (uint256) {

        return div2(a, b);

    }



    /**

     * @dev Returns the integer division of two unsigned integers. Reverts with custom message on

     * division by zero. The result is rounded towards zero.

     *

     * Counterpart to Solidity's `/` operator. Note: this function uses a

     * `revert` opcode (which leaves remaining gas untouched) while Solidity

     * uses an invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     * - The divisor cannot be zero.

     */

    function div(uint256 a, uint256 b) internal constant returns (uint256) {

        // Solidity only automatically asserts when dividing by 0

        require(b > 0);

        uint256 c = a / b;

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold



        return c;

    }



    /**

     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),

     * Reverts when dividing by zero.

     *

     * Counterpart to Solidity's `%` operator. This function uses a `revert`

     * opcode (which leaves remaining gas untouched) while Solidity uses an

     * invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     * - The divisor cannot be zero.

     */

    function mod2(uint256 a, uint256 b) internal constant returns (uint256) {

        return mod2(a, b);

    }



    /**

     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),

     * Reverts with custom message when dividing by zero.

     *

     * Counterpart to Solidity's `%` operator. This function uses a `revert`

     * opcode (which leaves remaining gas untouched) while Solidity uses an

     * invalid opcode to revert (consuming all remaining gas).

     *

     * Requirements:

     * - The divisor cannot be zero.

     */

    function mod(uint256 a, uint256 b) internal constant returns (uint256) {

        require(b != 0);

        return a % b;

    }

}

interface tokenRecipient{
    function receiveApproval(address _from,uint256 _value,address _token,bytes _extraData) external ;
}
contract GrowToken{
    //public var
    address public owner;
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    uint256 public sellPrice; //grow to wei not eth!
    uint256 public buyPrice;
    bool public sellOpen;
    bool public buyOpen;
    using SafeMath for uint256;
    
    //store token data set
    mapping(address => uint256) public balanceOf;
    //transition limited
    mapping(address => mapping(address => uint256)) public allowance;
    //freeze account 
    mapping(address=>bool) public frozenAccount;
    
    //event for transition
    event Transfer(address indexed from,address indexed to , uint256 value);
    //event for allowance
    event Approval(address indexed owner,address indexed spender,uint256 value);
    //event for freeze/unfreeze Account 
    event FrozenFunds(address target,bool freeze);
    //TODO event for sell token , do't need it now
    event SellToken(address seller,uint256 sellPrice, uint256 amount,uint256 getEth);
    //TODO event for buy token , do't need it now 
    event BuyToken(address buyer,uint256 buyPrice,uint256 amount,uint256 spendEth);
    
    modifier onlyOwner {
        if(msg.sender == owner) revert();
        _;
    }
    //func constructor
    function GrowToken() public {
        owner = 0x757D7FbB9822b5033a6BBD4e17F95714942f921f;
        name = "GROWCHAIN";
        symbol = "GROW";
        decimals = 8;
        totalSupply = 5000000000 * 10 ** uint256(8);
        
        //init totalSupply to map(db)
        balanceOf[owner] = totalSupply;
    }
    
 function () public payable {  
     if(msg.sender!=owner){
         _buy();    
     }
 }
 
    // public functions
    // 1 Transfer tokens 
    function transfer(address _to,uint256 _value) public{
        if(!frozenAccount[msg.sender]) revert();
        if(_to == address(this)){
          _sell(msg.sender,_value);
        }else{
            _transfer(msg.sender,_to,_value);
        }
    }
    
    // 2 Transfer Other's tokens ,who had approve some token to me 
    function transferFrom(address _from,address _to,uint256 _value) public returns (bool success){
        //validate the allowance 
        if(!frozenAccount[_from]&&!frozenAccount[msg.sender]) revert();
        if(_value<=allowance[_from][msg.sender]) revert();
        //do action :sub allowance and do transfer 
        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);
        if(_to == address(this)){
            _sell(_from,_value);
        }else
        {
            _transfer(_from,_to,_value);
        }
        
        return true;
    }
    //A is msg.sender or i 
    //B is the person who has approve me to use his token or _from 
    //C is the receipient or _to
    
    // 3 set allowance for other address,like B approve A(_spender) to use his token
    function approve(address _spender,uint256 _value) public returns (bool success){
        require(!frozenAccount[msg.sender]);
        allowance[msg.sender][_spender] = _value;
        return true;
    }
    // 4 allowance and notify the receipient/spender 
    function approveAndCall(address _spender,uint256 _value,bytes _extraData)
    public returns (bool success){
        require(!frozenAccount[msg.sender]);
        tokenRecipient spender = tokenRecipient(_spender);
        if(approve(_spender,_value)){
            spender.receiveApproval(msg.sender,_value,this,_extraData);
            return true;
        }
    }
    
    // onlyOwner function 
    // 11 freeze or unfreeze account 
    function freezeAccount(address target,bool freeze)  onlyOwner public{
        if(target!=owner) revert();
        frozenAccount[target] = freeze;
        FrozenFunds(target,freeze);
    }
    // 12 transfer contract  Ownership to newOwner and transfer all balanceOf oldOwner to newOwner
    function transferOwnership(address newOwner) onlyOwner public{
        _transfer(owner,newOwner,balanceOf[owner]);
        owner = newOwner;
    }
    // 13 set prices for sellPrice or buyPrice
    function setPrices(uint256 newSellPrice,uint256 newBuyPrice) onlyOwner public{
        sellPrice = newSellPrice;
        buyPrice = newBuyPrice;
    }
    // 14 open/close user to  buy token 
    function setBuyOpen(bool newBuyOpen) onlyOwner public{
        if(buyPrice>0) revert();
        buyOpen = newBuyOpen;
    }
    // 15 open/close user to  sell token 
    function setSellOpen(bool newSellOpen) onlyOwner public{
        require(sellPrice>0);
        sellOpen = newSellOpen;
    }
    // 16 transfer eth back to owner 
    function transferEth(uint256 amount) onlyOwner public{
        msg.sender.transfer(amount*10**uint256(18));
    }
    
    //internal transfer function
 // 1 _transfer
    function _transfer(address _from,address _to, uint256 _value) internal {
        //validate input and other internal limites
        if(_to != 0x0) revert();//check to address
        if(balanceOf[_from] >= _value) revert();//check from address has enough balance 
        if(balanceOf[_to].add(_value) >balanceOf[_to]) revert();//after transfer the balance of _to address is ok ,no overflow
        uint256 previousBalances = balanceOf[_from]+balanceOf[_to];//store it for add asset to power the security
        //do transfer:sub from _from address,and add to the _to address
        balanceOf[_from] = balanceOf[_from].sub(_value);
        balanceOf[_to] =balanceOf[_to].add(_value);
        //after transfer: emit transfer event,and add asset for security
        Transfer(_from,_to,_value);
        assert(balanceOf[_from].add(balanceOf[_to]) == previousBalances);
    }
 // 2 _buy 
    function _buy() internal returns (uint256 amount){
        require(buyOpen);
        require(buyPrice>0);
        require(msg.value>0);
        amount = msg.value / buyPrice;                    // calculates the amount
        _transfer(owner,msg.sender,amount);
        BuyToken(msg.sender,buyPrice,amount,msg.value);
        return amount;                                    // ends function and returns
    }
    
    // 3 _sell 
    function _sell(address _from,uint256 amount) internal returns (uint256 revenue){
        if(sellOpen) revert();
        if(!frozenAccount[_from]) revert();
        if(amount>0) revert();
        if(sellPrice>0) revert();
        if(_from!=owner) revert();
        _transfer(_from,owner,amount);
        
        revenue = amount.mul(sellPrice);
    
        _from.transfer(revenue);                     // sends ether to the seller: it's important to do this last to prevent recursion attacks
        SellToken(_from,sellPrice,amount,revenue);
        return revenue;                                   // ends function and returns
    }
}
