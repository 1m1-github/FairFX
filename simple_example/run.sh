export FROM_ACC=5B3SUGACYLICWU3DHXYCS45NDNEFZCZM4MCKCKQA3DLGKZEOFQR74HLGEU
export LP_ACC=UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y
export LP_APP=148607000

# A
tealish compile A.tl && cp build/A.teal .
goal app create --creator $FROM_ACC --approval-prog A.teal --clear-prog A.teal --global-byteslices 0 --global-ints 0 --local-byteslices 0 --local-ints 0
export A=178895540
goal app update --app-id $A --from $FROM_ACC --approval-prog A.teal --clear-prog A.teal
goal app call --app-id $A --from $FROM_ACC --foreign-app $LP_APP --app-account $LP_ACC

# B
tealish compile B.tl && cp build/B.teal .
goal app create --creator $FROM_ACC --approval-prog B.teal --clear-prog B.teal --global-byteslices 0 --global-ints 1 --local-byteslices 0 --local-ints 0
export B=178907864
goal app update --app-id $B --from $FROM_ACC --approval-prog B.teal --clear-prog B.teal

# call
goal app call --app-id $A --from $FROM_ACC --foreign-app $LP_APP --app-account $LP_ACC --out A.txn
goal app call --app-id $B --from $FROM_ACC --out B.txn
cat A.txn B.txn > combined.txn
goal clerk group --infile combined.txn --outfile call.txn
goal clerk sign --infile call.txn --outfile call.stxn
goal clerk rawsend --filename call.stxn
goal clerk dryrun -t call.stxn --dryrun-dump -o dryrun.json
tealdbg debug B.teal -d dryrun.json --group-index 1
