//
//  ContentView.swift
//  Shared
//
//  Created by Allan Lin on 2022/8/7.
//

import SwiftUI

struct GridLayout<Content: View>: View {
    
    private let rows: Int
    private let columns: Int
    private let content: (Int, Int, GeometryProxy) -> Content
    
    init(columns: Int, rows: Int, @ViewBuilder content: @escaping (Int, Int, GeometryProxy) -> Content) {
        self.rows = rows
        self.columns = columns
        self.content = content
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 0) {
                ForEach(0 ..< rows, id: \.self) { row in
                    HStack(spacing: 0) {
                        ForEach(0 ..< self.columns, id: \.self) { column in
                            self.content(row, column, geo)
                                .frame(width: geo.size.width / CGFloat(self.columns), height: geo.size.height / CGFloat(self.rows))
                        }
                    }.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center).fixedSize()
                }
            }
        }
    }
}

struct StandardView: View {
    private let control: MSCalculatorControl
    
    @State var displayText = "0"
    
    let standard_texts = [
        ["%", "root", "x**2", "1/x"],
        ["CE", "C", "Backspace", "/"],
        ["7", "8", "9", "*"],
        ["4", "5", "6", "-"],
        ["1", "2", "3", "+"],
        ["+-", "0", ".", "="],
    ]
    let standard_keyboard_shortcuts: [[KeyboardShortcut?]] = [
        [KeyboardShortcut("%", modifiers: []), Optional.none, Optional.none, Optional.none],
        [KeyboardShortcut(KeyEquivalent.escape, modifiers: []), Optional.none, KeyboardShortcut(KeyEquivalent.delete, modifiers: []), KeyboardShortcut("/", modifiers: [])],
        [KeyboardShortcut("7", modifiers: []), KeyboardShortcut("8", modifiers: []), KeyboardShortcut("9", modifiers: []), KeyboardShortcut("*", modifiers: [])],
        [KeyboardShortcut("4", modifiers: []), KeyboardShortcut("5", modifiers: []), KeyboardShortcut("6", modifiers: []), KeyboardShortcut("-", modifiers: [])],
        [KeyboardShortcut("1", modifiers: []), KeyboardShortcut("2", modifiers: []), KeyboardShortcut("3", modifiers: []), KeyboardShortcut("+", modifiers: [])],
        [Optional.none, KeyboardShortcut("0", modifiers: []), KeyboardShortcut(".", modifiers: []), KeyboardShortcut(KeyEquivalent.return, modifiers: [])],
    ]
    let standard_commands = [
        [CalculatorCommand.CommandPERCENT, CalculatorCommand.CommandSQRT, CalculatorCommand.CommandSQR, CalculatorCommand.CommandREC],
        [CalculatorCommand.CommandCENTR, CalculatorCommand.CommandCLEAR, CalculatorCommand.CommandBACK, CalculatorCommand.CommandDIV],
        [CalculatorCommand.Command7, CalculatorCommand.Command8, CalculatorCommand.Command9, CalculatorCommand.CommandMUL],
        [CalculatorCommand.Command4, CalculatorCommand.Command5, CalculatorCommand.Command6, CalculatorCommand.CommandSUB],
        [CalculatorCommand.Command1, CalculatorCommand.Command2, CalculatorCommand.Command3, CalculatorCommand.CommandADD],
        [CalculatorCommand.CommandSIGN, CalculatorCommand.Command0, CalculatorCommand.CommandPNT, CalculatorCommand.CommandEQU],
    ]

    let standard_mem_texts = [
        ["MC", "MR", "M+", "M-", "MS", "M*"]
    ]
    let standard_mem_commands = [
        [CalculatorCommand.CommandMCLEAR, CalculatorCommand.CommandRECALL, CalculatorCommand.CommandMPLUS, CalculatorCommand.CommandMMINUS, CalculatorCommand.CommandMMINUS, CalculatorCommand.CommandMUL,]
    ]
    
    init(control_instance: MSCalculatorControl) {
        self.control = control_instance
    }

    var body: some View {
        
        Text(displayText).padding().transaction { transaction in
            transaction.animation = nil
        }
        GridLayout(columns: 6, rows: 1) { (row, column, geo) in
            Button {
                control.sendCommand(command: standard_mem_commands[row][column])
                displayText = control.getPrimaryDisplay()
                
            } label: {
                Text(standard_mem_texts[row][column])
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }
            .background(
                Rectangle().strokeBorder(Color.black))
        }
        GridLayout(columns: 4, rows: 6) { (row, column, geo)  in
            Button {
                control.sendCommand(command: standard_commands[row][column])
                displayText = control.getPrimaryDisplay()
                
            } label: {
                Text(standard_texts[row][column])
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }.frame(idealHeight: 50)
            .keyboardShortcut(standard_keyboard_shortcuts[row][column])
            .background(
                Rectangle().strokeBorder(Color.black))
        }
    }
}

struct ScientificView: View {
    private let control: MSCalculatorControl
    
    init(control_instance: MSCalculatorControl) {
        self.control = control_instance
    }
    
    var body: some View {
        Text("Scientific View").padding()
    }
}

struct ProgrammerView: View {
    private let control: MSCalculatorControl
    @State var displayText = "0"
    @State var binDisplayText = "0"
    @State var octDisplayText = "0"
    @State var decDisplayText = "0"
    @State var hexDisplayText = "0"
    
    let programmer_texts = [
        ["Lsh", "Rsh", "Or", "Xor", "Not", "And"],
        ["Up", "Mod", "CE", "C", "Backspace", "/"],
        ["A", "B", "7", "8", "9", "*"],
        ["C", "D", "4", "5", "6", "-"],
        ["E", "F", "1", "2", "3", "+"],
        ["(", ")", "+-", "0", ".", "="],
    ]
    let programmer_keyboard_shortcuts: [[KeyboardShortcut?]] = [
        [KeyboardShortcut("<", modifiers: []), KeyboardShortcut(">", modifiers: []), KeyboardShortcut("|", modifiers: []), KeyboardShortcut("^", modifiers: []), KeyboardShortcut("~", modifiers: []), KeyboardShortcut("&", modifiers: [])],
        [Optional.none, KeyboardShortcut("%", modifiers: []), KeyboardShortcut(KeyEquivalent.escape, modifiers: []), Optional.none, KeyboardShortcut(KeyEquivalent.delete, modifiers: []), KeyboardShortcut("/", modifiers: [])],
        [KeyboardShortcut("A", modifiers: []), KeyboardShortcut("B", modifiers: []), KeyboardShortcut("7", modifiers: []), KeyboardShortcut("8", modifiers: []), KeyboardShortcut("9", modifiers: []), KeyboardShortcut("*", modifiers: [])],
        [KeyboardShortcut("C", modifiers: []), KeyboardShortcut("D", modifiers: []), KeyboardShortcut("4", modifiers: []), KeyboardShortcut("5", modifiers: []), KeyboardShortcut("6", modifiers: []), KeyboardShortcut("-", modifiers: [])],
        [KeyboardShortcut("E", modifiers: []), KeyboardShortcut("F", modifiers: []), KeyboardShortcut("1", modifiers: []), KeyboardShortcut("2", modifiers: []), KeyboardShortcut("3", modifiers: []), KeyboardShortcut("+", modifiers: [])],
        [KeyboardShortcut("(", modifiers: []), KeyboardShortcut(")", modifiers: []), Optional.none, KeyboardShortcut("0", modifiers: []), KeyboardShortcut(".", modifiers: []), KeyboardShortcut(KeyEquivalent.return, modifiers: [])],
    ]
    let programmer_commands = [
        [CalculatorCommand.CommandLSHF, CalculatorCommand.CommandRSHF, CalculatorCommand.CommandOR, CalculatorCommand.CommandXor, CalculatorCommand.CommandCOMNOT, CalculatorCommand.CommandAnd],
        [CalculatorCommand.CommandMOD, CalculatorCommand.CommandMOD, CalculatorCommand.CommandCENTR, CalculatorCommand.CommandCLEAR, CalculatorCommand.CommandBACK, CalculatorCommand.CommandDIV],
        [CalculatorCommand.CommandA, CalculatorCommand.CommandB, CalculatorCommand.Command7, CalculatorCommand.Command8, CalculatorCommand.Command9, CalculatorCommand.CommandMUL],
        [CalculatorCommand.CommandC, CalculatorCommand.CommandD, CalculatorCommand.Command4, CalculatorCommand.Command5, CalculatorCommand.Command6, CalculatorCommand.CommandSUB],
        [CalculatorCommand.CommandE, CalculatorCommand.CommandF, CalculatorCommand.Command1, CalculatorCommand.Command2, CalculatorCommand.Command3, CalculatorCommand.CommandADD],
        [CalculatorCommand.CommandOPENP, CalculatorCommand.CommandCLOSEP, CalculatorCommand.CommandSIGN, CalculatorCommand.Command0, CalculatorCommand.CommandPNT, CalculatorCommand.CommandEQU],
    ]
    
    init(control_instance: MSCalculatorControl) {
        self.control = control_instance
    }
    
    var body: some View {
        Text(displayText).padding().transaction { transaction in
            transaction.animation = nil
        }
        Button {
            control.setProgrammerRadix(radix: MSCalculatorProgrammerDisplays.Binary)
        } label: {
            Text("BIN:" + binDisplayText).frame(maxWidth: .infinity,
                                            maxHeight: .infinity,
                                            alignment:.leading).transaction { transaction in
                transaction.animation = nil
            }
        }
        Button {
            control.setProgrammerRadix(radix: MSCalculatorProgrammerDisplays.Octal)
        } label: {
            Text("OCT:" + octDisplayText).frame(maxWidth: .infinity,
                                                maxHeight: .infinity,
                                                alignment:.leading).transaction { transaction in
                transaction.animation = nil
            }
        }
        Button {
            control.setProgrammerRadix(radix: MSCalculatorProgrammerDisplays.Decimal)
        } label: {
            Text("DEC:" + decDisplayText).frame(maxWidth: .infinity,
                                                maxHeight: .infinity,
                                                alignment:.leading).transaction { transaction in
                transaction.animation = nil
            }
        }
        Button {
            control.setProgrammerRadix(radix: MSCalculatorProgrammerDisplays.Hexdecimal)
        } label: {
            Text("HEX:" + hexDisplayText).frame(maxWidth: .infinity,
                                                maxHeight: .infinity,
                                                alignment:.leading).transaction { transaction in
                transaction.animation = nil
            }
        }
        
        GridLayout(columns: 6, rows: 6) { (row, column, geo)  in
            Button {
                control.sendCommand(command: programmer_commands[row][column])
                displayText = control.getPrimaryDisplay()
                binDisplayText = control.getProgrammerDisplays(display: MSCalculatorProgrammerDisplays.Binary)
                octDisplayText = control.getProgrammerDisplays(display: MSCalculatorProgrammerDisplays.Octal)
                decDisplayText = control.getProgrammerDisplays(display: MSCalculatorProgrammerDisplays.Decimal)
                hexDisplayText = control.getProgrammerDisplays(display: MSCalculatorProgrammerDisplays.Hexdecimal)
                
            } label: {
                Text(programmer_texts[row][column])
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            }.keyboardShortcut(programmer_keyboard_shortcuts[row][column])
            
            .background(
                Rectangle().strokeBorder(Color.black, lineWidth: 1))
        }
    }
}
