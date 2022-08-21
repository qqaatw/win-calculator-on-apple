//
//  MSCalculatorApp.swift
//  Shared
//
//  Created by Allan Lin on 2022/8/7.
//

import SwiftUI

// handle window closed event
// https://stackoverflow.com/questions/65743619/close-swiftui-application-when-last-window-is-closed
class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
}

@main
struct MSCalculatorApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var mode = MSCalculatorMode.Standard
    
    let control = MSCalculatorControl()
    
    var body: some Scene {
        WindowGroup {
            if (mode == MSCalculatorMode.Standard) {
                StandardView(control_instance: control)
            } else if (mode == MSCalculatorMode.Scientific) {
                ScientificView(control_instance: control)
            } else if (mode == MSCalculatorMode.Programmer) {
                ProgrammerView(control_instance: control)
            }
            
        }.commands {
            CommandMenu("Mode") {
                Button{
                    control.setMode(mode: MSCalculatorMode.Standard)
                    mode = MSCalculatorMode.Standard
                } label: {
                    Text("Standard")
                }
                Button{
                    control.setMode(mode: MSCalculatorMode.Scientific)
                    mode = MSCalculatorMode.Scientific
                } label: {
                    Text("Scientific")
                }
                Button{
                    control.setMode(mode: MSCalculatorMode.Programmer)
                    mode = MSCalculatorMode.Programmer
                } label: {
                    Text("Programmer")
                }
                
            }
        
        }
    }
}
