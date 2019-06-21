pragma solidity ^0.5.0;

library SafeMath2 {
    
     //merging addition and substraction to reduce overhead of gas cost.
    function addsub(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        c = a - b;

        require(c >= a, "SafeMath: addition overflow");
        require(b <= a, "SafeMath: subtraction overflow");

        return c;
    }
       
       //only multiplication operation for now, to add exponential operation later on.
      function mul(uint256 a, uint256 b) internal pure returns (uint256) {

        if (a == 0) {

            return 0;

        }

        uint256 c = a * b;

        require(c / a == b, "SafeMath: multiplication overflow");

        return c;

    }

       function divmod(uint256 a, uint256 b) internal pure returns (uint256) {

        // Solidity only automatically asserts when dividing by 0

        require(b > 0, "SafeMath: division by zero");

        uint256 c = a / b;

        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        require(b != 0, "SafeMath: modulo by zero");

        return a % b;
        return c;

    }

    

}