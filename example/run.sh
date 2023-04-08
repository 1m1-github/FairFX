export FROM_ACC=5B3SUGACYLICWU3DHXYCS45NDNEFZCZM4MCKCKQA3DLGKZEOFQR74HLGEU
export LP_ACC=UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y
export LP_APP=148607000
# A
goal app create --creator $FROM_ACC --approval-prog A.teal --clear-prog A.teal --global-byteslices 0 --global-ints 0 --local-byteslices 0 --local-ints 0 --on-completion NoOp --app-account $LP_ACC --foreign-app $LP_APP
export A=178596639
goal app update --app-id $A --from $FROM_ACC --approval-prog A.teal --clear-prog A.teal
goal app call --app-id $A --from $FROM_ACC --foreign-app $LP_APP --app-account $LP_ACC

# B
goal app create --creator $FROM_ACC --approval-prog B.teal --clear-prog B.teal --global-byteslices 0 --global-ints 0 --local-byteslices 0 --local-ints 0 --on-completion NoOp --foreign-app $A --foreign-app $LP_APP --app-account $LP_ACC --fee 100000
export B=178596899
goal app update --app-id $B --from $FROM_ACC --approval-prog B.teal --clear-prog B.teal --foreign-app $A --foreign-app $A --foreign-app $LP_APP --app-account $LP_ACC --fee 100000
goal app call --app-id $B --from $FROM_ACC --foreign-app $A --foreign-app $LP_APP --app-account $LP_ACC --fee 100000