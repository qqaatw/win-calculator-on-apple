//
//  control.swift
//  MSCalculator (macOS)
//
//  Created by Allan Lin on 2022/8/7.
//

import Foundation

enum MSCalculatorMode {
    case Standard, Scientific, Programmer
}
enum MSCalculatorProgrammerDisplays {
    case Binary, Octal, Decimal, Hexdecimal
}

class MSCalculatorControl {
    let cal_manager = CalculatorManagerWrapper()

    init() {
        cal_manager.reset(true)
    }
    
    func setMode(mode: MSCalculatorMode) {
        if (mode == MSCalculatorMode.Standard) {
            print("Standard Mode")
            cal_manager.setStandardMode();
        } else if (mode == MSCalculatorMode.Scientific) {
            cal_manager.setScientificMode();
        } else if (mode == MSCalculatorMode.Programmer) {
            print("Programmer Mode")
            cal_manager.setProgrammerMode();
        }
    }
    
    func sendCommand(command: CalculatorCommand) {
        self.cal_manager.sendCommand(command.rawValue)
    }
    
    func getPrimaryDisplay() -> String {
        return self.cal_manager.getPrimaryDisplay()
    }
    func getProgrammerDisplays(display: MSCalculatorProgrammerDisplays) -> String {
        let radix: uint32
        switch display {
            case MSCalculatorProgrammerDisplays.Binary:
                radix = 2
            case MSCalculatorProgrammerDisplays.Octal:
                radix = 8
            case MSCalculatorProgrammerDisplays.Decimal:
                radix = 10
            case MSCalculatorProgrammerDisplays.Hexdecimal:
                radix = 16
        }
        return self.cal_manager.getResultForRadix(radix, 8, true)
    }
    func setProgrammerRadix(radix: MSCalculatorProgrammerDisplays) {
        let command: CalculatorCommand
        switch radix {
            case MSCalculatorProgrammerDisplays.Binary:
                command = CalculatorCommand.CommandBin
            case MSCalculatorProgrammerDisplays.Octal:
                command = CalculatorCommand.CommandOct
            case MSCalculatorProgrammerDisplays.Decimal:
                command = CalculatorCommand.CommandDec
            case MSCalculatorProgrammerDisplays.Hexdecimal:
                command = CalculatorCommand.CommandHex
        }
        self.sendCommand(command: command)
    }
    
    func test() -> String {
        let commands: [NSNumber] = [
            CalculatorCommand.Command2.rawValue,
            CalculatorCommand.CommandADD.rawValue,
            CalculatorCommand.Command3.rawValue,
            CalculatorCommand.CommandEQU.rawValue
        ]
        self.cal_manager.executeCommands(commands)
        return self.cal_manager.getPrimaryDisplay();
    }
}

