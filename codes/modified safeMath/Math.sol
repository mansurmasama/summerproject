//with a SafeMath2 library

pragma solidity ^0.5.0;
import "browser/SafeMath2.sol";


contract Maths {
    using SafeMath2 for uint256;
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

    total =x.addsub(y);

}

    //substraction operation
    function substraction(uint256 x, uint y) public  {

    total =x.addsub(y);

}

    //modulus operation
    function modulus(uint256 x, uint y) public  {

    total =x.divmod(y);

}

   //division operation
    function division(uint256 x, uint y) public  {

    total =x.divmod(y);

}
    
}