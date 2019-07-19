//with a SafeMath8, merging sub, div and mod

pragma solidity ^0.5.0;



//Modifying the require() to test the output not input
//import "browser/SafeMath4.sol";

//This library focuses on output (c) rather than inputs (a and b) V1
import "browser/SafeMath8.sol";

contract Maths {
    using SafeMath8 for uint256;
    uint256 public total;
    //uint256 public b;
    
    function Math() public pure {
        //constructor
    }
    
    //multiplication operation
    function multiplication(uint256 x, uint256 y) public  {
    //c=a+b;
    total=x*y;
    total.addmult(x,y);
    //total.addmult;
    //addmult(total)=x*y;
    //addmult(total);
    //this.addmult(total);   //only for external function, public function consumes more gas than external
    
}

                                                                                                                                        
    // addition operation
    function addition(uint256 x, uint256 y) public  {

    total =x+y;
    total.addmult(x,y);
    //total =.addmult(total);
    //addmult(total)=x+y;
    //addmult(total);
    //this.addmult(total);

}


    //substraction operation
    function substraction(uint256 x, uint256 y) public  {
    total = x - y;
    total.moddivsub(x,y);

}

    //modulus operation
    function modulus(uint256 x, uint256 y) public  {
    total =x%y;
    total.moddivsub(x,y);
  
}

   //division operation
    function division(uint256 x, uint256 y) public  {

    total =x/y;
    total.moddivsub(x,y);
   
}
  
}