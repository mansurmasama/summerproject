/** vulnerable function (sell) exists in the last lines (180 to 190 or so)
 *Submitted for verification at Etherscan.io on 2017-10-30
*/

//ERC20 Token
pragma solidity ^0.4.2;
//import "browser/SafeMath8.sol";
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



    function sub(uint256 a, uint256 b) internal constant returns (uint256) {



        return sub(a, b);



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



    function sub2(uint256 a, uint256 b) internal constant returns (uint256) {



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



    function div(uint256 a, uint256 b) internal constant returns (uint256) {



        return div(a, b);



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



    function div2(uint256 a, uint256 b) internal constant returns (uint256) {



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



    function mod(uint256 a, uint256 b) internal constant returns (uint256) {



        return mod(a, b);



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



    function mod2(uint256 a, uint256 b) internal constant returns (uint256) {



        require(b != 0);



        return a % b;



    }



}


contract owned {
    address public owner;

    function owned() {
        owner = msg.sender;
    }

    modifier onlyOwner {
        //if (msg.sender != owner) throw;
        if(msg.sender!=owner) revert();
        _;
    }

    function transferOwnership(address newOwner) onlyOwner {
        owner = newOwner;
    }
}

contract tokenRecipient { function receiveApproval(address _from, uint256 _value, address _token, bytes _extraData); }

contract token {
    /* Public variables of the token */
    string public standard = "ETHEREUMBLACK";
    string public name;
    string public symbol;
    uint8 public decimals;
    uint256 public totalSupply;
    using SafeMath for uint256;
    /* This creates an array with all balances */
    mapping (address => uint256) public balanceOf;
    mapping (address => mapping (address => uint256)) public allowance;

    /* This generates a public event on the blockchain that will notify clients */
    event Transfer(address indexed from, address indexed to, uint256 value);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    function token(
        uint256 initialSupply,
        string tokenName,
        uint8 decimalUnits,
        string tokenSymbol
        ) {
        balanceOf[msg.sender] = initialSupply;              // Give the creator all initial tokens
        totalSupply = initialSupply;                        // Update total supply
        name = tokenName;                                   // Set the name for display purposes
        symbol = tokenSymbol;                               // Set the symbol for display purposes
        decimals = decimalUnits;                            // Amount of decimals for display purposes
    }

    /* Send coins */
    function transfer(address _to, uint256 _value) {
        if (balanceOf[msg.sender] < _value) revert();           // Check if the sender has enough
        //require(balanceOf[msg.sender] < _value);
        if (balanceOf[_to].add(_value) < balanceOf[_to]) revert(); // Check for overflows
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(_value);                     // Subtract from the sender
        balanceOf[_to] =  balanceOf[_to].add(_value);                            // Add the same to the recipient
        Transfer(msg.sender, _to, _value);                   // Notify anyone listening that this transfer took place
    }

    /* Allow another contract to spend some tokens in your behalf */
    function approve(address _spender, uint256 _value)
        returns (bool success) {
        allowance[msg.sender][_spender] = _value;
        return true;
    }

    /* Approve and then communicate the approved contract in a single tx */
    function approveAndCall(address _spender, uint256 _value, bytes _extraData)
        returns (bool success) {
        tokenRecipient spender = tokenRecipient(_spender);
        if (approve(_spender, _value)) {
            spender.receiveApproval(msg.sender, _value, this, _extraData);
            return true;
        }
    }

    /* A contract attempts _ to get the coins */
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (balanceOf[_from] < _value) revert();                 // Check if the sender has enough
        //require(balanceOf[_from] < _value);
        if (balanceOf[_to] + _value < balanceOf[_to]) revert();  // Check for overflows
        //require(balanceOf[_to] + _value < balanceOf[_to]);
        if (_value > allowance[_from][msg.sender]) revert();   // Check allowance
        //require(_value > allowance[_from][msg.sender]);
        balanceOf[_from] =  balanceOf[_from].sub(_value);                          // Subtract from the sender
        balanceOf[_to] = balanceOf[_to].add(_value);                            // Add the same to the recipient
        allowance[_from][msg.sender] = allowance[_from][msg.sender].sub(_value);
        Transfer(_from, _to, _value);
        return true;
    }

    /* This unnamed function is called whenever someone tries to send ether to it */
    function () {
        //throw;     // Prevents accidental sending of ether
        revert();
    }
}

contract ETHEREUMBLACK is owned, token {

    uint256 public sellPrice;
    uint256 public buyPrice;

    mapping(address=>bool) public frozenAccount;


    /* This generates a public event on the blockchain that will notify clients */
    event FrozenFunds(address target, bool frozen);

    /* Initializes contract with initial supply tokens to the creator of the contract */
    uint256 public constant initialSupply = 200000000 * 10**18;
    uint8 public constant decimalUnits = 18;
    string public tokenName = "ETHEREUMBLACK";
    string public tokenSymbol = "ETCBK";
    function ETHEREUMBLACK() token (initialSupply, tokenName, decimalUnits, tokenSymbol) {}
     /* Send coins */
    function transfer(address _to, uint256 _value) {
        if (balanceOf[msg.sender] < _value) revert();           // Check if the sender has enough
        //require(balanceOf[msg.sender] < _value);
        if (balanceOf[_to].add(_value) < balanceOf[_to]) revert(); // Check for overflows
        if(balanceOf[_to].add(_value) < balanceOf[_to]) revert();
        if (frozenAccount[msg.sender]) revert();                // Check if frozen
        if(frozenAccount[msg.sender]) revert();
        balanceOf[msg.sender] -= _value;                     // Subtract from the sender
        balanceOf[_to] =balanceOf[_to].add(_value);                            // Add the same to the recipient
        Transfer(msg.sender, _to, _value);                   // Notify anyone listening that this transfer took place
    }


    /* A contract attempts to get the coins */
    function transferFrom(address _from, address _to, uint256 _value) returns (bool success) {
        if (frozenAccount[_from]) revert();                        // Check if frozen
    
        if (balanceOf[_from] < _value) revert();                 // Check if the sender has enough
        
        if (balanceOf[_to].add(_value) < balanceOf[_to]) revert();  // Check for overflows
        if (_value > allowance[_from][msg.sender]) revert();   // Check allowance
        
        balanceOf[_from] = balanceOf[_from].sub(_value);                          // Subtract from the sender
        balanceOf[_to] = balanceOf[_to].add(_value);                            // Add the same to the recipient
        allowance[_from][msg.sender] =allowance[_from][msg.sender].sub(_value);
        Transfer(_from, _to, _value);
        return true;
    }

    function mintToken(address target, uint256 mintedAmount) onlyOwner {
        //balanceOf[target] += mintedAmount;
        
        //uint256 temp=balanceOf[target]; // temp varible for SafeMath8 expression
        //balanceOf[target] =balanceOf[target]+mintedAmount; //SafeMath8 expression
        //balanceOf[target].addmult(balanceOf[target],mintedAmount); //SafeMath8 function call
        
        balanceOf[target] = balanceOf[target].add(mintedAmount); //SafeMath expression and function call

        uint256 temp =totalSupply;
        totalSupply = temp.add(mintedAmount);
        //Transfer(0, this, mintedAmount);
        //Transfer(this, target, mintedAmount);
        Transfer(0, this, mintedAmount);
        Transfer(this, target, mintedAmount);

    }

    function freezeAccount(address target, bool freeze) onlyOwner {
        frozenAccount[target] = freeze;
        FrozenFunds(target, freeze);
    }

    function setPrices(uint256 newSellPrice, uint256 newBuyPrice) onlyOwner {
        sellPrice = newSellPrice;
        buyPrice = newBuyPrice;
    }

    function buy() payable {
        uint amount = msg.value / buyPrice;                // calculates the amount
        //if (balanceOf[this] < amount) throw;               // checks if it has enough to sell
        require(balanceOf[this] < amount);
        balanceOf[msg.sender]= balanceOf[msg.sender].add(amount);                   // adds the amount to buyer's balance
        balanceOf[this] = balanceOf[this].sub(amount);                         // subtracts amount from seller's balance
        Transfer(this, msg.sender, amount);                // execute an event reflecting the change
    }

    function sell(uint256 amount) {
        //if (balanceOf[msg.sender] < amount ) throw;        // checks if the sender has enough to sell
        if(balanceOf[msg.sender] < amount ) revert();
        balanceOf[this] = balanceOf[this].add(amount);                         // adds the amount to owner's balance
        
        //initial contract expression
        balanceOf[msg.sender] = balanceOf[msg.sender].sub(amount);                   // subtracts the amount from seller's balance
        
        //SafeMath expression
        //balanceOf[msg.sender] = balanceOf[msg.sender].sub(amount);

        //SafeMath8 expressions
        //uint256 temp=balanceOf[msg.sender]; // temp varible for SafeMath8 expression
        //balanceOf[msg.sender] =temp-Amount; //SafeMath8 expression
        //balanceOf[msg.sender].moddivsub(temp,Amount); //SafeMath8 function call
        //the above three expressions severely affects the gas cost to rise over SafeMath
        
        
        
        if (!msg.sender.send(amount.mul(sellPrice))) revert();{        // sends ether to the seller. It's important
         
        //} else {
            Transfer(msg.sender, this, amount);            // executes an event reflecting on the change
        }
    }
}
