#pragma version 8

# int asset_id = 

inner_txn:
    TypeEnum: Appl
    ApplicationID: 177398602
    # Assets: asset_id
    # Applications: 
    Accounts: "UDFWT5DW3X5RZQYXKQEMZ6MRWAEYHWYP7YUAPZKPW6WJK3JH3OZPL7PO2Y"
end

# bytes
# bytes lastlog = itxn(LastLog)
bytes logs0 = itxna(Logs, 0)
bytes logs1 = itxna(Logs, 1)

int logs0int = btoi(logs0)
int logs1int = btoi(logs1)

int x = logs0int + logs1int

# if result == "SUBJ":
#     log(result)
# else:
#    # OBJ case
#     int numerator = btoi(result)
# end

# FX -> goes to DLT storage -> consumed by wasm/Rust

exit(1)