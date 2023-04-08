#pragma version 8

if Txn.ApplicationID == 0:
    # Handle Create App
    exit(1)
end

switch Txn.OnCompletion:
    NoOp: main
    OptIn: opt_in
    CloseOut: close_out
    UpdateApplication: update_app
    DeleteApplication: delete_app
end

block opt_in:
    # Disallow Opt In
    exit(0)
end

block close_out:
    # Disallow Closing Out
    exit(0)
end

block update_app:
    # Handle Update App
    # Only allow the Creator to update the app
    assert(Txn.Sender == Global.CreatorAddress)
     # (for now)
    exit(1)
end

block delete_app:
    # Handle Delete App
    # Only allow the Creator to delete the app
    assert(Txn.Sender == Global.CreatorAddress)
     # (for now)
    exit(1)
end

block main:
    bytes lp_address = Txn.Accounts[1]
    const int LP_APP = 148607000
    const bytes ASSET_1_KEY = "asset_1_reserves"
    int exists
    # bytes asset_1_reserves_bytes
    int asset_1_reserves
    exists, asset_1_reserves = app_local_get_ex(lp_address, LP_APP, ASSET_1_KEY)

    exit(1)
end