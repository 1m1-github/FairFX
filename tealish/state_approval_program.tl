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

# int base_currency = 0

block main:

# buttcoin 34,384,959
# micro algo 27,192,761,081
# pool account testnet USDC/ALGO UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y 
# 148607000 tinyman testnet main app

    int currency = Txn.Assets[0]
    int n
    int d

    addr a = UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y <- NOT WORKING

    # USDC
    if currency == 10458941:
        n, d = tinyman("UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y")
    # TINYAU
    elif currency == 21582981:
        n, d = tinyman("DNPVHOLSYCBDA6UAB3MREZN6W4MZZV4OL227B5ABABQTHCJFMLD345JPXE")
    else:
        # TODO if itob(n) starts with "SUBJECTIVE", its a mistake
        abi_return("SUBJECTIVE")
        exit(1)
    end

    bytes nb = abi_encode_uint64(n)
    bytes db = abi_encode_uint64(d)
    abi_return(concat(nb, db))
    exit(1)

    # block add:
    #     # Add 2 integers
    #     int x = btoi(Txn.ApplicationArgs[1])
    #     int y = btoi(Txn.ApplicationArgs[2])
    #     int result = x + y
    #     abi_return(abi_encode_uint64(result))
    #     exit(1)
    # end

    # block mulw:
    #     # Multiply 2 integers, returing a uint128
    #     bytes x = Txn.ApplicationArgs[1]
    #     bytes y = Txn.ApplicationArgs[2]
    #     bytes result = x b* y
    #     abi_return(abi_encode_uint128(result))
    #     exit(1)
    # end


    # block hello:
    #     # Return a greeting
    #     bytes name = abi_decode_string(Txn.ApplicationArgs[1])
    #     bytes result = concat("Hello ", name)
    #     abi_return(abi_encode_string(result))
    #     exit(1)
    # end

    # block send:
    #     # Send some Algo to the given address
    #     bytes address = Txn.ApplicationArgs[1]
    #     inner_txn:
    #         TypeEnum: Pay
    #         Receiver: address
    #         Amount: 10000000
    #         Fee: 0
    #     end
    #     exit(1)
    # end

    # block store_data:
    #     # Store some fixed size data in a box with the specified key
    #     bytes key = Txn.ApplicationArgs[1]
    #     bytes data = Txn.ApplicationArgs[2]
    #     box_put(key, data)
    #     exit(1)
    # end

    # block store_tuple:
    #     # Store some structured data in a box with the specified key
    #     bytes key = Txn.ApplicationArgs[1]
    #     # Item data = Txn.ApplicationArgs[2]
    #     # make some assertion about the data for the fun of it
    #     # assert(data.owner == Txn.Sender)
    #     # box_put(key, data)
    #     exit(1)
    # end

    # block balance:
    #     # Return balance of the specified account
    #     int result = balance(Txn.Accounts[btoi(Txn.ApplicationArgs[1])])
    #     abi_return(abi_encode_uint64(result))
    #     exit(1)
    # end
end

func tinyman(lp_address: bytes) int, int:
    # bytes lp_address = Txn.Accounts[1]
    const int LP_APP = 148607000
    const bytes ASSET_1_KEY = "asset_1_reserves"
    const bytes ASSET_2_KEY = "asset_2_reserves"
    int asset_1_reserves
    _, asset_1_reserves = app_local_get_ex(lp_address, LP_APP, ASSET_1_KEY)
    int asset_2_reserves
    _, asset_2_reserves = app_local_get_ex(lp_address, LP_APP, ASSET_2_KEY)

    return asset_1_reserves, asset_2_reserves
end

# func is_obj():
#     return
# end

# func abi_return_int(result):
#     # log(concat("\x15\x1f\x7c\x75", result))
#     # log(result)
#     int r = result
#     teal:
#         store 0
#     end
#     log(itob(result0))
#     return
# end

func abi_return(result: bytes):
    # log(concat("\x15\x1f\x7c\x75", result))
    log(result)
    return
end

# func abi_decode_string(value: bytes) bytes:
#     # return the content portion of the string, skipping the first 2 bytes which encode the length
#     return extract(2, 0, value)
# end

# func abi_encode_string(value: bytes) bytes:
#     # return the bytestring with a uint16 prefix denoting the length
#     return concat(extract(6, 2, itob(len(value))), value)
# end

func abi_encode_uint64(value: int) bytes:
    return itob(value)
end

# func abi_encode_uint32(value: int) bytes:
#     # return the last 4 bytes
#     return extract(4, 4, itob(value))
# end

# func abi_encode_uint16(value: int) bytes:
#     # return the last 2 bytes
#     return extract(6, 2, itob(value))
# end

# func abi_encode_uint8(value: int) bytes:
#     # return the last 1 byte
#     return extract(7, 1, itob(value))
# end

# func abi_encode_uint128(value: bytes) bytes:
#     # return 16 bytes with zero padding
#     return bzero(16) b| value
# end