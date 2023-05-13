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

    # safety
    int e = Global.GroupSize-1
    for i in 0:e:
        
        assert(Gtxn[i].RekeyTo == Global.ZeroAddress)
        assert(Gtxn[i].AssetCloseTo == Global.ZeroAddress)
        assert(Gtxn[i].CloseRemainderTo == Global.ZeroAddress)

        # stay empty
        if Gtxn[i].TypeEnum == Pay:
            assert(Gtxn[i].Receiver != Global.CurrentApplicationAddress)
        end
        if Gtxn[i].TypeEnum == Axfer:
            assert(Gtxn[i].AssetReceiver != Global.CurrentApplicationAddress)
        end

    end



    int currency = Txn.Assets[0]
    int n = 0
    int d = 0
    bytes addr

    # USDC
    if currency == 10458941:
        # addr UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # TINYAU
    elif currency == 21582981:
        # addr DNPVHOLSYCBDA6UAB3MREZN6W4MZZV4OL227B5ABABQTHCJFMLD345JPXE
        addr = "\x1b_S\xb9r\xc0\x820z\x80\x0e\xd9\x12e\xbe\xb7\x19\x9c\xd7\x8e^\xb5\xf0\xf4\x01\x00a3\x89%b\xc7"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    end

    bytes nb = abi_encode_uint64(n)
    bytes db = abi_encode_uint64(d)
    abi_return(concat(nb, db))
    exit(1)
end

func tinyman() int, int:
    const int LP_APP = 148607000
    const bytes ASSET_1_KEY = "asset_1_reserves"
    const bytes ASSET_2_KEY = "asset_2_reserves"
    int asset_1_reserves
    _, asset_1_reserves = app_local_get_ex(Txn.Accounts[1], LP_APP, ASSET_1_KEY)
    int asset_2_reserves
    _, asset_2_reserves = app_local_get_ex(Txn.Accounts[1], LP_APP, ASSET_2_KEY)

    return asset_1_reserves, asset_2_reserves
end

func abi_return(result: bytes):
    # log(concat("\x15\x1f\x7c\x75", result))
    log(result)
    return
end

func abi_encode_uint64(value: int) bytes:
    return itob(value)
end