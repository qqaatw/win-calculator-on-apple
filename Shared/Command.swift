//
//  Command.swift
//  MSCalculator (macOS)
//
//  Created by Allan Lin on 2022/8/8.
//

import Foundation


enum CalculatorCommandType
{
    case UnaryCommand, BinaryCommand, OperandCommand, Parentheses
};

enum CalculatorCommand: NSNumber
{
    // Commands for programmer calculators are omitted.
    case CommandDEG = 321
    case CommandRAD = 322
    case CommandGRAD = 323
    case CommandDegrees = 324
    case CommandHYP = 325

    case CommandNULL = 0

    case CommandSIGN = 80
    case CommandCLEAR = 81
    case CommandCENTR = 82
    case CommandBACK = 83

    case CommandPNT = 84

    // Hole  85
    // Unused commands defined in Command.h is omitted.
    case CommandXor = 88
    case CommandLSHF = 89
    case CommandRSHF = 90
    case CommandDIV = 91
    case CommandMUL = 92
    case CommandADD = 93
    case CommandSUB = 94
    case CommandMOD = 95
    case CommandROOT = 96
    case CommandPWR = 97

    case CommandCHOP = 98 // Unary operators must be between CommandCHOP and CommandEQU
    case CommandROL = 99
    case CommandROR = 100
    case CommandCOMNOT = 101

    case CommandSIN = 102
    case CommandCOS = 103
    case CommandTAN = 104

    case CommandSINH = 105
    case CommandCOSH = 106
    case CommandTANH = 107

    case CommandLN = 108
    case CommandLOG = 109
    case CommandSQRT = 110
    case CommandSQR = 111
    case CommandCUB = 112
    case CommandFAC = 113
    case CommandREC = 114
    case CommandDMS = 115
    case CommandCUBEROOT = 116 // x ^ 1/3
    case CommandPOW10 = 117    // 10 ^ x
    case CommandPERCENT = 118

    case CommandFE = 119
    case CommandPI = 120
    case CommandEQU = 121

    case CommandMCLEAR = 122
    case CommandRECALL = 123
    case CommandSTORE = 124
    case CommandMPLUS = 125
    case CommandMMINUS = 126

    case CommandEXP = 127

    case CommandOPENP = 128
    case CommandCLOSEP = 129

    case Command0 = 130 // The controls for 0 through F must be consecutive and in order
    case Command1 = 131
    case Command2 = 132
    case Command3 = 133
    case Command4 = 134
    case Command5 = 135
    case Command6 = 136
    case Command7 = 137
    case Command8 = 138
    case Command9 = 139
    case CommandA = 140
    case CommandB = 141
    case CommandC = 142
    case CommandD = 143
    case CommandE = 144
    case CommandF = 145 // this is last control ID which must match the string table
    case CommandINV = 146
    case CommandSET_RESULT = 147

    case CommandSEC = 400
    case CommandASEC = 401
    case CommandCSC = 402
    case CommandACSC = 403
    case CommandCOT = 404
    case CommandACOT = 405

    case CommandSECH = 406
    case CommandASECH = 407
    case CommandCSCH = 408
    case CommandACSCH = 409
    case CommandCOTH = 410
    case CommandACOTH = 411

    case CommandPOW2 = 412 // 2 ^ x
    case CommandAbs = 413
    case CommandFloor = 414
    case CommandCeil = 415
    case CommandROLC = 416
    case CommandRORC = 417
    case CommandLogBaseY = 500
    case CommandNand = 501
    case CommandNor = 502

    case CommandRSHFL = 505
    case CommandRand = 600
    case CommandEuler = 601

    case CommandAnd = 86
    case CommandOR = 87

    case ModeBasic = 200
    case ModeScientific = 201

    case CommandASIN = 202
    case CommandACOS = 203
    case CommandATAN = 204
    case CommandPOWE = 205
    case CommandASINH = 206
    case CommandACOSH = 207
    case CommandATANH = 208

    case ModeProgrammer = 209
    case CommandHex = 313
    case CommandDec = 314
    case CommandOct = 315
    case CommandBin = 316
    case CommandQword = 317
    case CommandDword = 318
    case CommandWord = 319
    case CommandByte = 320

    
}

enum CalculatorBinCommand: NSNumber
{
    case CommandBINEDITSTARTORPOS0 = 700
    case CommandBINPOS1 = 701
    case CommandBINPOS2 = 702
    case CommandBINPOS3 = 703
    case CommandBINPOS4 = 704
    case CommandBINPOS5 = 705
    case CommandBINPOS6 = 706
    case CommandBINPOS7 = 707
    case CommandBINPOS8 = 708
    case CommandBINPOS9 = 709
    case CommandBINPOS10 = 710
    case CommandBINPOS11 = 711
    case CommandBINPOS12 = 712
    case CommandBINPOS13 = 713
    case CommandBINPOS14 = 714
    case CommandBINPOS15 = 715
    case CommandBINPOS16 = 716
    case CommandBINPOS17 = 717
    case CommandBINPOS18 = 718
    case CommandBINPOS19 = 719
    case CommandBINPOS20 = 720
    case CommandBINPOS21 = 721
    case CommandBINPOS22 = 722
    case CommandBINPOS23 = 723
    case CommandBINPOS24 = 724
    case CommandBINPOS25 = 725
    case CommandBINPOS26 = 726
    case CommandBINPOS27 = 727
    case CommandBINPOS28 = 728
    case CommandBINPOS29 = 729
    case CommandBINPOS30 = 730
    case CommandBINPOS31 = 731
    case CommandBINPOS32 = 732
    case CommandBINPOS33 = 733
    case CommandBINPOS34 = 734
    case CommandBINPOS35 = 735
    case CommandBINPOS36 = 736
    case CommandBINPOS37 = 737
    case CommandBINPOS38 = 738
    case CommandBINPOS39 = 739
    case CommandBINPOS40 = 740
    case CommandBINPOS41 = 741
    case CommandBINPOS42 = 742
    case CommandBINPOS43 = 743
    case CommandBINPOS44 = 744
    case CommandBINPOS45 = 745
    case CommandBINPOS46 = 746
    case CommandBINPOS47 = 747
    case CommandBINPOS48 = 748
    case CommandBINPOS49 = 749
    case CommandBINPOS50 = 750
    case CommandBINPOS51 = 751
    case CommandBINPOS52 = 752
    case CommandBINPOS53 = 753
    case CommandBINPOS54 = 754
    case CommandBINPOS55 = 755
    case CommandBINPOS56 = 756
    case CommandBINPOS57 = 757
    case CommandBINPOS58 = 758
    case CommandBINPOS59 = 759
    case CommandBINPOS60 = 760
    case CommandBINPOS61 = 761
    case CommandBINPOS62 = 762
    case CommandBINPOS63 = 763
    case CommandBINEDITENDORPOS63
}

