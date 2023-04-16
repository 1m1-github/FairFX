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

# create app
goal app create --creator $CREATOR --approval-prog $TEAL_DIR/$APPROVAL_FILE_NAME.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal --global-byteslices 0 --global-ints 0 --local-byteslices 0 --local-ints 0
goal app info --app-id $APP_ID
goal app update --app-id=$APP_ID --from=$CREATOR --approval-prog $TEAL_DIR/$APPROVAL_FILE_NAME.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal

# call fx
goal app call --app-id $APP_ID --from $CREATOR --foreign-app $LP_APP --foreign-asset 10458941 --app-account UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y --out $TXNS_DIR/fx.stxn
goal clerk dryrun -t $TXNS_DIR/fx.stxn --dryrun-dump -o $TXNS_DIR/dryrun.json
tealdbg debug $TEAL_DIR/$APPROVAL_FILE_NAME.teal -d $TXNS_DIR/dryrun.json

goal app call --app-id $APP_ID --from $CREATOR --foreign-app $LP_APP --foreign-asset 21582981 --app-account DNPVHOLSYCBDA6UAB3MREZN6W4MZZV4OL227B5ABABQTHCJFMLD345JPXE --out $TXNS_DIR/fx.stxn
goal clerk dryrun -t $TXNS_DIR/fx.stxn --dryrun-dump -o $TXNS_DIR/dryrun.json
tealdbg debug $TEAL_DIR/$APPROVAL_FILE_NAME.teal -d $TXNS_DIR/dryrun.json

goal app call --app-id $APP_ID --from $CREATOR --foreign-app $LP_APP --foreign-asset 21582982 --app-account DNPVHOLSYCBDA6UAB3MREZN6W4MZZV4OL227B5ABABQTHCJFMLD345JPXE --out $TXNS_DIR/fx.stxn
goal clerk dryrun -t $TXNS_DIR/fx.stxn --dryrun-dump -o $TXNS_DIR/dryrun.json
tealdbg debug $TEAL_DIR/$APPROVAL_FILE_NAME.teal -d $TXNS_DIR/dryrun.json

# test
tealish compile test/test.tl
goal app create --creator $CREATOR --approval-prog test/build/test.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal --global-byteslices 1 --global-ints 2 --local-byteslices 0 --local-ints 0
export TEST_APP_ID=178979676
goal app update --app-id=$TEST_APP_ID --from=$CREATOR --approval-prog test/build/test.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal

# call test
goal app call --app-id $APP_ID --from $CREATOR --foreign-app $LP_APP --foreign-asset 10458941 --app-account UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y --out $TXNS_DIR/A.txn
goal app call --app-id $APP_ID --from $CREATOR --foreign-app $LP_APP --foreign-asset 21582981 --app-account DNPVHOLSYCBDA6UAB3MREZN6W4MZZV4OL227B5ABABQTHCJFMLD345JPXE --out $TXNS_DIR/A.txn
goal app call --app-id $APP_ID --from $CREATOR --foreign-app $LP_APP --foreign-asset 21582982 --app-account DNPVHOLSYCBDA6UAB3MREZN6W4MZZV4OL227B5ABABQTHCJFMLD345JPXE --out $TXNS_DIR/A.txn
goal app call --app-id $TEST_APP_ID --from $CREATOR --out $TXNS_DIR/B.txn
cat $TXNS_DIR/A.txn $TXNS_DIR/B.txn > $TXNS_DIR/combined.txn
goal clerk group --infile $TXNS_DIR/combined.txn --outfile $TXNS_DIR/call.txn
goal clerk sign --infile $TXNS_DIR/call.txn --outfile $TXNS_DIR/call.stxn
goal clerk dryrun -t $TXNS_DIR/call.stxn --dryrun-dump -o $TXNS_DIR/dryrun.json
tealdbg debug $TEAL_DIR/$APPROVAL_FILE_NAME.teal -d $TXNS_DIR/dryrun.json --group-index 0 --mode application
tealdbg debug test/build/test.teal -d $TXNS_DIR/dryrun.json --group-index 1 --mode application
goal clerk rawsend --filename $TXNS_DIR/call.stxn

# debug
goal clerk send --amount 100000 --from $CREATOR --to $APP_ACCOUNT --wallet $WALLET
goal clerk dryrun -t $TXNS_DIR/init.stxn --dryrun-dump -o $TXNS_DIR/dryrun.json
tealdbg debug $SYSTEM_APPROVAL_FILE -d $TXNS_DIR/dryrun.json --group-index 0
// update - disabled in prod
goal app update --app-id=$APP_ID --from=$CREATOR --approval-prog $TEAL_DIR/$APPROVAL_FILE_NAME.teal --clear-prog $TEAL_DIR/$CLEAR_FILE_NAME.teal

goal app read --app-id=$TEST_APP_ID --global
