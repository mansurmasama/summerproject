//with a SafeMath8, merging sub, div and mod

pragma solidity ^0.4.2;


library SafeMath {

     //merging add and mul functions 
    function addmult(uint256 c,uint256 a, uint256 b) internal constant {

    
     require(c >= a && c >= b);
}
   
     // merging mod and div and sub functions
    function moddivsub(uint256 c, uint256 a, uint256 b  ) internal constant  {

        require(c<=a && b > 0);
        
           }
    
}

contract Maths {
    using SafeMath for uint256;
    uint256 public total;
    //uint256 public b;
    
    function Math() public constant {
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