#  https://developer.algorand.org/docs/run-a-node/setup/install/#sync-node-network-using-fast-catchup
# chrome://inspect/#devices

# set env vars for terminal
export ALGORAND_DATA="$HOME/algorand/testnetdata"
export WALLET=Fair
export TEALISH_DIR=./tealish
export TEAL_DIR=./tealish/build
export TXNS_DIR=./txns
export APPROVAL_FILE_NAME=state_approval_program
export CLEAR_FILE_NAME=state_clear_program
export CREATOR=5B3SUGACYLICWU3DHXYCS45NDNEFZCZM4MCKCKQA3DLGKZEOFQR74HLGEU
export APP_ID=178969021
export LP_ACC=UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y
export LP_APP=148607000

# start goal, create wallet and account
goal node start
goal node status
goal node end
goal wallet new $WALLET
goal account new -w $WALLET
goal clerk send -a 1000000 -f $CREATOR -t $A -w $WALLET

# create teal
tealish compile $TEALISH_DIR/$APPROVAL_FILE_NAME.tl
tealish compile $TEALISH_DIR/$CLEAR_FILE_NAME.tl

# create ap
goal app create --creator $CREATOR --approval-prog $TEAL_DIR/$APPROVAL_FILE_NAME.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal --global-byteslices 0 --global-ints 0 --local-byteslices 0 --local-ints 0
goal app info --app-id $APP_ID
goal app update --app-id=$APP_ID --from=$CREATOR --approval-prog $TEAL_DIR/$APPROVAL_FILE_NAME.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal

# test
tealish compile test/test.tl
goal app create --creator $CREATOR --approval-prog test/build/test.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal --global-byteslices 1 --global-ints 2 --local-byteslices 0 --local-ints 0
export TEST_APP_ID=178979676
goal app update --app-id=$TEST_APP_ID --from=$CREATOR --approval-prog test/build/test.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal

# call test
goal app call --app-id $APP_ID --from $CREATOR --foreign-app $LP_APP --foreign-asset 10458941 --app-account UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y --out A.txn
goal app call --app-id $TEST_APP_ID --from $CREATOR --out B.txn
cat A.txn B.txn > combined.txn
goal clerk group --infile combined.txn --outfile call.txn
goal clerk sign --infile call.txn --outfile call.stxn
goal clerk rawsend --filename call.stxn
goal clerk dryrun -t call.stxn --dryrun-dump -o dryrun.json
tealdbg debug B.teal -d dryrun.json --group-index 1

goal app call --app-id=$TEST_APP_ID --from $CREATOR --foreign-app=$APP_ID --out=$TXNS_DIR/appcall_test.stxn
goal clerk dryrun -t $TXNS_DIR/appcall_test.stxn --dryrun-dump -o $TXNS_DIR/dryrun.json
tealdbg debug test/build/test.teal -d $TXNS_DIR/dryrun.json

# debug
goal clerk send --amount 100000 --from $CREATOR --to $APP_ACCOUNT --wallet $WALLET
goal clerk dryrun -t $TXNS_DIR/init.stxn --dryrun-dump -o $TXNS_DIR/dryrun.json
tealdbg debug $SYSTEM_APPROVAL_FILE -d $TXNS_DIR/dryrun.json --group-index 0
// update - disabled in prod
goal app update --app-id=$APP_ID --from=$CREATOR --approval-prog $TEAL_DIR/$APPROVAL_FILE_NAME.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal

