//This library focuses on output (c) rather than inputs (a and b)

pragma solidity ^0.5.0;
//pragma solidity ^0.4.11;


library SafeMath8 {

     //merging add and mul functions 
    function addmult(uint256 c,uint256 a, uint256 b) internal pure {

    
        require(c >= a && c >= b, "SafeMath: overflow encountered");
}
   
     // merging mod and div and sub functions
    function moddivsub(uint256 c, uint256 a, uint256 b  ) internal pure  {

        require(c<=a && b > 0, "SafeMath: overflow encountered");
        
           }
    
}