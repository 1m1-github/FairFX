=
FairFX
FX rates for **any** currency 


== 
is a smart contract 
+ ccy is subjective: return *subjective*
+ ccy is objective: return current value derived from connector
+ objective is defined as the set of ccys that have a connector installed
+ connectors can be added/removed (theoretically by governance) 
+ connectors call on-DLT sources (e.g. DEXs for a current FX rate)
+ connectors can have arbitrary complexity, including liquiDity requirements or choices of metric (bid-ask middle, twap, etc.) 

base currency is the default energy currency of the DLT 

first implementation will use:
tealish.tinyman.org
https://tinyman.org/
ABI e.g.: https://github.com/tinymanorg/tealish/blob/31b6d81e04df359525a22d6daaabcc086ba77a53/examples/arc4/app.tl

