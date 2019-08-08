//original Math.sol. No library imported

pragma solidity ^0.4.2;



contract Maths {
    uint256 public total;
    
    function Math() public constant {
        //constructor
    }
    
    //multiplication operation
    function multiplication(uint256 x, uint256 y) public  {

   total =x*y;
  
}

    // addition operation
    function addition(uint256 x, uint256 y) public  {

    total =x+y;

}

    //substraction operation
    function substraction(uint256 x, uint256 y) public  {

    total =x-y;

}

    //modulus operation
    function modulus(uint256 x, uint256 y) public  {

    total =x%y;

}

   //division operation
    function division(uint256 x, uint256 y) public  {

    total =x/y;

}
    
}