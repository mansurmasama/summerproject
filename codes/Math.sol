//testing the execution cost and transaction cost with the SafeMath library imported
pragma solidity ^0.5.0;
import "browser/SafeMath.sol";


contract Maths {
    using SafeMath for uint256;
    uint256 public total;
    
    function Math() public pure {
        //constructor
    }
    
    //multiplication operation
    function pewPew(uint256 x, uint y) public  {

    total =x.mul(y);

}

    // addition operations
    function additions(uint256 x, uint y) public  {

    total =x.add(y);

}

    //substraction operation
    function substraction(uint256 x, uint y) public  {

    total =x.sub(y);

}

    //modulus operation
    function modulus(uint256 x, uint y) public  {

    total =x.mod(y);

}

   //division operation
    function division(uint256 x, uint y) public  {

    total =x.div(y);

}
    
}