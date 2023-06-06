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
    if currency == 31566704:
        # addr 2PIFZW53RHCSFSYMCFUBW4XOCXOMB7XOYQSQ6KGT3KVGJTL4HM6COZRNMM
        # addr = 0xd3d05cdbbb89c522cb0c11681b72ee15dcc0feeec4250f28d3daaa64cd7c3b3c
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # PEPE
    elif currency == 1096015467:
        # addr QT2GLKM6FSVHQMRQ53POMDBMCHH452FERI6WGNAT2J34KVRZPV6GA5DGOI
        # addr = 0x84f465a99e2caa783230eedee60c2c11cfcee8a48a3d633413d277c556397d7c
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # OPUL
    elif currency == 287867876:
        # addr 6JRMS5GWPSRHBDKNWO46PDVMOLWYURW2VXZEWBR2QOKHOFNR2VLAFDU3TU
        # addr = 0xf262c974d67ca2708d4db3b9e78eac72ed8a46daadf24b063a83947715b1d556
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # GALGO
    elif currency == 793124631:
        # addr 6NAKH5IVZGBDTDEETKV6SLBJNDHZZASX2YO2CUPESH2IPRBN3LSKCH4E2M
        # addr = 0xf340a3f515c982398c849aabe92c2968cf9c8257d61da151e491f487c42ddae4
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # PLANETS
    elif currency == 27165954:
        # addr X2YCX7P6MUEANKFOTTDXXKTAZFKKKYZ544W6TWFARGVRTEWQQNZP4BY7ZA
        # addr = 0xbeb02bfdfe650806a8ae9cc77baa60c954a5633de72de9d8a089ab1992d08372
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # DEFLY
    elif currency == 470842789:
        # addr DJIP7MVWAAJKTPDG7SEH64OD4QIZMRHOH5LYHY4YXWRZRG6YMD2ERJ4C2Q
        # addr = 0x1a50ffb2b60012a9bc66fc887f71c3e4119644ee3f5783e398bda3989bd860f4
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # AKTA
    elif currency == 523683256:
        # addr 6FS7FD2Q6LCSCDDMAQMRZFYRXAC7XATD5XE777TH5HP3CKYRINMF4YNYJA
        # addr = 0xf165f28f50f2c5210c6c04191c9711b805fb8263edc9fffe67e9dfb12b114358
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # GOBTC
    elif currency == 386192725:
        # addr FKMV6GSU57764TQ5NLSBEDXNPUXL7OAOKANVDP2A6FSB77BHI3GTWHQAZA
        # addr = 0x2a995f1a54efffee4e1d6ae4120eed7d2ebfb80e501b51bf40f1641ffc2746cd
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # CHIP
    elif currency == 388592191:
        # addr TVFMM3ZTK3QJM2BT5AZ4O3VIU4XMODAGWJ2AMAJ64OI55NO5DLHXS4ADTY
        # addr = 0x9d4ac66f3356e0966833e833c76ea8a72ec70c06b27406013ee391deb5dd1acf
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # RIO
    elif currency == 2751733:
        # addr 7UDZ3MGXEYHJ2OGC5ST4WEHE7GRHEGWIBTPX6L4NUKHINGFEMFGESRXFXI
        # addr = 0xfd079db0d7260e9d38c2eca7cb10e4f9a2721ac80cdf7f2f8da28e8698a4614c
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # USDT
    elif currency == 312769:
        # addr MM4NTQDAT32TSVDE65YXYUPDFVMVP2LUREJCQ4PJV4MFQCW5VV23Y5SEHM
        # addr = 0x6338d9c0609ef5395464f7717c51e32d5957e97489122871e9af18580addad75
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # INFT
    elif currency == 975807033:
        # addr XQZ7P6QN6A77RHWK6G3LTCBHZJG3NRZFUT6BYJMOTOUAAWHBL7AEKNAV2I
        # addr = 0xbc33f7fa0df03ff89ecaf1b6b98827ca4db6c725a4fc1c258e9ba80058e15fc0
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # BUTTS
    elif currency == 753137719:
        # addr BQ64QBC7CLJI5SUMOWZPYHN4R4RRI52LUWGDO2SASVWJ7KABC66LPW6A4Q
        # addr = 0x0c3dc8045f12d28eca8c75b2fc1dbc8f2314774ba58c376a40956c9fa80117bc
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # YLDY
    elif currency == 226701642:
        # addr VTO4WOPIS4TAYYECOZXS6LHMACE46MWW36X3A7X5MKJVK37UCC6IFJFULI
        # addr = 0xacddcb39e897260c6082766f2f2cec0089cf32d6dfafb07efd6293556ff410bc
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # SKYNET
    elif currency == 1076768277:
        # addr RIGDKWA7VJNZ4OAKNV53UJ4RDKA2DOFVFZ2U4VDP64IR4CKSNOP45EVAX4
        # addr = 0x8a0c35581faa5b9e380a6d7bba27911a81a1b8b52e754e546ff7111e09526b9f
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # BLOCK
    elif currency == 251014570:
        # addr P6ZE6ZTUZCMRUXHJ7ZFAXYDZSUYZRJHAEG3NYGHYZURLOMOEMRILCYJTVM
        # addr = 0x7fb24f6674c8991a5ce9fe4a0be079953198a4e021b6dc18f8cd22b731c46450
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # BRD
    elif currency == 1054801592:
        # addr SKFWGGQAFA2DPZXCPUNBWZZGI42ZWCJ35XYTN6XFFZATHY355NBRVP5BEU
        # addr = 0x928b631a00283437e6e27d1a1b672647359b093bedf136fae52e4133e37deb43
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # ROOBZ
    elif currency == 790704501:
        # addr 2JKSQ4VSLLTPJB6E7FFKO5BMUUPCBKC75QMCJF4K4JE6URFF2JNJW23V4I
        # addr = 0xd2552872b25ae6f487c4f94aa7742ca51e20a85fec1824978ae249ea44a5d25a
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # GOETH
    elif currency == 386195940:
        # addr L6CDM74YQEZ7RABX7AGTD32ZJEMDOJ5OGY4QNGZUS35S5VPIGC5UNHZTPA
        # addr = 0x5f84367f988133f88037f80d31ef5949183727ae3639069b3496fb2ed5e830bb
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # IAQ
    elif currency == 923640017:
        # addr ED57RDPEG53HHJKAHQGFBF74GUZ5JHH464424OZ4NSOJVV5VAL5YLZXQ5U
        # addr = 0x20fbf88de4377673a5403c0c5097fc3533d49cfcf739ae3b3c6c9c9ad7b502fb
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # COSG
    elif currency == 1065092715:
        # addr 4PE4NCV73L26GIUKZPZTIEASAERJQL2E4IFVXPTOPWVQFZ2RHCQW3VU7AM
        # addr = 0xe3c9c68abfdaf5e3228acbf33410120122982f44e20b5bbe6e7dab02e75138a1
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # DHARM
    elif currency == 818432243:
        # addr RAMRCQUQBSWOKOLV6OGBK6LTURVFMY2Z4U47FFO2NIPEOUI53UMRYW2TZY
        # addr = 0x88191142900cace53975f38c157973a46a566359e539f295da6a1e47511ddd19
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # MOIST
    elif currency == 756578163:
        # addr UFSDSEJIMDSZY6AN2ZWJDJS2YSYVAXDSO5FLJAPCTS2NGRGTAEJDGR34QY
        # addr = 0xa16439112860e59c780dd66c91a65ac4b1505c72774ab481e29cb4d344d30112
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # SMILE
    elif currency == 300208676:
        # addr JEHWNGR6SW3VWEHFHCNWHNQFVS5U7FW2P6JCGU327Z2DNN2RL77EIVESUQ
        # addr = 0x490f669a3e95b75b10e5389b63b605acbb4f96da7f9223537afe7436b7515ffe
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # GP
    elif currency == 403499324:
        # addr G6ACWKTWJAFNSEAIDNBUIX6UOSDBRXL46ULGBD62RQTM7CLM6IYF2WT3UQ
        # addr = 0x37802b2a76480ad910081b43445fd4748618dd7cf516608fda8c26cf896cf230
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # ZONE
    elif currency == 444035862:
        # addr FX2SYGWYWUEMJCQCL33VH36P4NI2STOWXATPIEVEKJKRCDHDSHFLJNDACM
        # addr = 0x2df52c1ad8b508c48a025ef753efcfe351a94dd6b826f412a45255110ce391ca
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    # XUT
    elif currency == 947923645:
        # addr 7GYM7BFFGSE3WOGWF6M47VXORZKTP37FULMLPHWMTH2ICDQ6DPCXXUH6Q4
        # addr = 0xf9b0cf84a53489bb38d62f99cfd6ee8e5537efe5a2d8b79ecc99f4810e1e1bc5
        addr = "\xa0\xcbi\xf4v\xdd\xfb\x1c\xc3\x17T\x08\xcc\xf9\x91\xb0\t\x83\xdb\x0f\xfe(\x07\xe5O\xb7\xac\x95m'\xdb\xb2"
        assert(Txn.Accounts[1] == addr)
        n, d = tinyman()
    end

    bytes nb = abi_encode_uint64(n)
    bytes db = abi_encode_uint64(d)
    abi_return(concat(nb, db))
    exit(1)
end

func tinyman() int, int:
    const int LP_APP = 1002541853
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