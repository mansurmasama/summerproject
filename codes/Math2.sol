//testing the execution cost and transaction cost without SafeMath library
pragma solidity ^0.5.0;
//import "browser/SafeMath.sol";


contract Maths {
   // using SafeMath for uint256;
    uint256 public total;
    
    function Math() public pure {
        //constructor
    }
    
    //multiplication operation
    function pewPew(uint256 x, uint y) public  {

    total =x*(y);

}

    // addition operations
    function additions(uint256 x, uint y) public  {

    total =x+(y);

}

    //substraction operation
    function substraction(uint256 x, uint y) public  {

    total =x-(y);

}

    //modulus operation
    function modulus(uint256 x, uint y) public  {

    total =x**(y);

}

   //division operation
    function division(uint256 x, uint y) public  {

    total =x/(y);

}
    
}