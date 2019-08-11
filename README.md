# summerproject title
Analysis of the Ethereum Smart Contracts Vulnerabilities
#################

Out of 500 plus published security vulnerabilities on the common vulnerabilities exposure (CVE) database, over 400 plus are related to arithmetic flaws like integer overflow or underflow also known as the two’s complement. To deal with arithmetic vulnerabilities, SafeMath library was developed.

Similarly, the arithmetic vulnerabilities are listed among the top 10 security issues in smart contracts applications, https://dasp.co/#item-3. A well-known DAO attack which engulfed $60m worth of ether exploited integer underflow vulnerability present in the smart contract implementation.

Despite the emerging success of the smart contracts, there is quite a number of security vulnerabilities arising such as re-entrancy, call to unknown, etc. (Atzei et al). The Arithmetic vulnerabilities which is about 90% out of the published vulnerabilities in the CVE (https://cve.mitre.org). Even the famous DAO attack was caused by the arithmetic flaws (Torres, Atzei et al, Barghavan). At the moment the commonly used library called the SafeMath  used by developers to mitigate arithmetic flaws consumes more gas cost and make the smart contract even fail to run if there is no enough gas to carry out the operations or if the gas limit set by the developer is less than the actual gas needed for the transactions. 

The aim of this research project is to analyse the security vulnerabilities in Ethereum Smart Contracts, in order to mitigate them through analysing the SafeMath library and optimise it to provide better performance and security protection.
