// https://developer.algorand.org/docs/run-a-node/setup/install/#sync-node-network-using-fast-catchup
// chrome://inspect/#devices

// set env vars for terminal
export ALGORAND_DATA="$HOME/algorand/testnetdata"
export WALLET=Fair
export TEALISH_DIR=./tealish
export TEAL_DIR=./tealish/build
export TXNS_DIR=./txns
export APPROVAL_FILE_NAME=state_approval_program
export CLEAR_FILE_NAME=state_clear_program
export CREATOR=5B3SUGACYLICWU3DHXYCS45NDNEFZCZM4MCKCKQA3DLGKZEOFQR74HLGEU
export APP_ID=177398602
export APP_ACCOUNT=Y46IEUKGFPIQJWLDOUL34N4M3Q4XC6JZB7OTX3SGK64GFFSWW4P34OEMXQ
export ASA=

// start goal, create wallet and account
goal node start
goal node status
goal node end
goal wallet new $WALLET
goal account new -w $WALLET
goal clerk send -a 1000000 -f $CREATOR -t $A -w $WALLET

// create teal
tealish compile $TEALISH_DIR/$APPROVAL_FILE_NAME.tl
tealish compile $TEALISH_DIR/$CLEAR_FILE_NAME.tl

// create ap
goal app create --creator $CREATOR --approval-prog $TEAL_DIR/$APPROVAL_FILE_NAME.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal --global-byteslices 0 --global-ints 0 --local-byteslices 0 --local-ints 0 --on-completion NoOp
goal app info --app-id $APP_ID
goal app update --app-id=$APP_ID --from=$CREATOR --approval-prog $TEAL_DIR/$APPROVAL_FILE_NAME.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal

// withdraw
goal clerk send --amount 1000 --from $BENEFICIARY --to $APP_ACCOUNT --out=$TXNS_DIR/withdraw_algo.stxn -w $WALLET
goal app call --app-id=$APP_ID --from $BENEFICIARY --app-arg="str:withdraw" --foreign-asset=$ASA --out=$TXNS_DIR/withdraw_call.stxn -w $WALLET
cat $TXNS_DIR/withdraw_algo.stxn $TXNS_DIR/withdraw_call.stxn > $TXNS_DIR/combinedtransactions.txn
goal clerk group --infile $TXNS_DIR/combinedtransactions.txn --outfile $TXNS_DIR/groupedtransactions.txn
goal clerk sign --infile $TXNS_DIR/groupedtransactions.txn --outfile $TXNS_DIR/withdraw.stxn
goal clerk rawsend --filename $TXNS_DIR/withdraw.stxn

// test
tealish compile test/test.tl
goal app create --creator $CREATOR --approval-prog test/build/test.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal --global-byteslices 0 --global-ints 0 --local-byteslices 0 --local-ints 0 --on-completion NoOp --foreign-app $APP_ID --app-account UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y
export TEST_APP_ID=177419770
goal app info --app-id $TEST_APP_ID
export TEST_APP_ACCOUNT=MOOM2XFSWZ2PNM23R2EHFUFLAAUDQJ77AVW3VOAYNDSRGRPYHKDFXUJI3Q
goal clerk send -a 1000000 -f $CREATOR -t $TEST_APP_ACCOUNT
goal app update --app-id=$TEST_APP_ID --from=$CREATOR --approval-prog test/build/test.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal --foreign-app=$APP_ID --app-account UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y
goal app call --app-id=$TEST_APP_ID --from $CREATOR --foreign-app=$APP_ID --out=$TXNS_DIR/appcall_test.stxn
goal clerk dryrun -t $TXNS_DIR/appcall_test.stxn --dryrun-dump -o $TXNS_DIR/dryrun.json
tealdbg debug test/build/test.teal -d $TXNS_DIR/dryrun.json

// debug
goal clerk send --amount 100000 --from $CREATOR --to $APP_ACCOUNT --wallet $WALLET
goal clerk dryrun -t $TXNS_DIR/init.stxn --dryrun-dump -o $TXNS_DIR/dryrun.json
tealdbg debug $SYSTEM_APPROVAL_FILE -d $TXNS_DIR/dryrun.json --group-index 0
// update - disabled in prod
goal app update --app-id=$APP_ID --from=$CREATOR --approval-prog $TEAL_DIR/$APPROVAL_FILE_NAME.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal

