# FairFX
on DLT FX rates for **any** currency

Smart Contract API returns fx_n and fx_d with:

FX of given currency to default DLT currency represented as a fraction:
$fx_n/fx_d$

+ ccy is subjective: return 0/0
+ ccy is objective: return current value derived from connector
+ objective is defined as the set of ccys that have a connector installed
+ connectors can be added/removed (theoretically by governance)
+ connectors call on-DLT sources (e.g. DEXs for a current FX rate)
+ connectors can have arbitrary complexity, including liquidity requirements or choices of metric (bid-ask middle, TWAP, etc.)

base currency is the default energy currency of the DLT