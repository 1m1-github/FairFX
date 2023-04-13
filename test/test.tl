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
    bytes fx_log = Gtxn[0].LastLog
    app_global_put("fx_log", fx_log)
    int n = extract_uint64(fx_log, 0)
    int d = extract_uint64(fx_log, 8)
    app_global_put("n", n)
    app_global_put("d", d)
    
    exit(1)
end