//
//  ContentView.swift
//  Calculator
//
//  Created by Greyson Flippo on 5/2/24.
//

import SwiftUI

@Observable
class CalcFunctions {
    
    var storedValue: Float = 0
    var inputValue: String = "0"
    var operatorChar: String = ""
    
    init () {}
    
    func clearVal(){
        if (inputValue == "0") {
            storedValue = 0
            operatorChar = ""
        } else {
            inputValue = "0"
        }
    }

    func neg() {
        if (self.inputValue != "0") {
            inputValue = String((Float(inputValue) ?? 0) * -1)
        }
    }

    func operatorClicked(operatorCharacter: String) -> () -> () {
        return {
            self.operatorChar = operatorCharacter
            self.storedValue = Float(self.inputValue) ?? 0
            self.inputValue = "0"
        }
    }

    func numberClicked(numberValue: Int) -> () -> () {
        return {
            if (self.inputValue == "0") {
                self.inputValue = String(numberValue)
            } else {
                self.inputValue += String(numberValue)
            }
        }
    }
    
    func AddDecimal() {
        if (!inputValue.contains(".")){
            inputValue += "."
        }
    }
    
    func SetPercent() {
        inputValue = String((Float(inputValue) ?? 0) / 100)
    }

    func runOperation() {
        switch(operatorChar) {
            case("+"):
                inputValue = String(storedValue + (Float(inputValue) ?? 0))
            case("-"):
                inputValue = String(storedValue - (Float(inputValue) ?? 0))
            case("X"):
                inputValue = String(storedValue * (Float(inputValue) ?? 0))
            case("/"):
                inputValue = String(storedValue / (Float(inputValue) ?? 0))
            default:
                break
        }
        storedValue = 0
        operatorChar = ""
    }
    
}

struct NumberButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 80, alignment: .center)
            .background(
                configuration.isPressed
                ? Color(red: 0.7, green: 0.7, blue: 0.7)
                : Color(red: 0.8, green: 0.8, blue: 0.8)
            )
            .foregroundStyle(Color(red: 1, green: 1, blue: 1))
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .font(.system(size: 30, weight: .regular, design: .monospaced))
    }
}

struct FunctionButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 80, alignment: .center)
            .background(
                configuration.isPressed
                ? Color(red: 0.9, green: 0.5, blue: 0.1)
                : Color(red: 1, green: 0.6, blue: 0.1)
            )
            .foregroundStyle(Color(red: 1, green: 1, blue: 1))
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .font(.system(size: 30, weight: .regular, design: .monospaced))
    }
}

struct ExtraButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 80, height: 80, alignment: .center)
            .background(
                configuration.isPressed
                ? Color(red: 0.4, green: 0.4, blue: 0.4)
                : Color(red: 0.5, green: 0.5, blue: 0.5)
            )
            .foregroundStyle(Color(red: 1, green: 1, blue: 1))
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .font(.system(size: 25, weight: .regular, design: .monospaced))
    }
}

struct ZeroButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 168, height: 80, alignment: .center)
            .background(
                configuration.isPressed
                ? Color(red: 0.7, green: 0.7, blue: 0.7)
                : Color(red: 0.8, green: 0.8, blue: 0.8)
            )
            .foregroundStyle(Color(red: 1, green: 1, blue: 1))
            .clipShape(Capsule())
            .font(.system(size: 30, weight: .regular, design: .monospaced))
    }
}

struct ContentView: View {
    
    @State private var calcFunctions = CalcFunctions()
    
    var body: some View {
        VStack {
            Grid(alignment: .center) {
                GridRow {
                    Text(String(calcFunctions.storedValue))
                        .frame(height: 150)
                        .font(.system(size: 30, weight: .regular, design: .monospaced))
                    Text(String(calcFunctions.operatorChar))
                        .frame(height: 150)
                        .font(.system(size: 30, weight: .regular, design: .monospaced))
                        .foregroundStyle(Color(red: 1, green: 0.6, blue: 0.1))
                }
            }
            Grid(alignment: .center) {
                GridRow {
                    Text(String(calcFunctions.inputValue))
                        .frame(height: 150)
                        .font(.system(size: 80, weight: .regular, design: .monospaced))
                        .foregroundStyle(Color(red: 1, green: 0.6, blue: 0.1))
                }
            }
            Grid(alignment: .center) {
                GridRow {
                    Button(action: calcFunctions.clearVal) {
                        Text("AC")
                    }
                    .buttonStyle(ExtraButton())
                    Button(action: calcFunctions.neg) {
                        Text("NEG")
                    }
                    .buttonStyle(ExtraButton())
                    Button(action: calcFunctions.SetPercent) {
                        Text("%")
                    }
                    .buttonStyle(ExtraButton())
                    Button(action: calcFunctions.operatorClicked(operatorCharacter: "/")) {
                        Text("/")
                    }
                    .buttonStyle(FunctionButton())
                }
                GridRow {
                    Button(action: calcFunctions.numberClicked(numberValue: 7)) {
                        Text("7")
                    }
                    .buttonStyle(NumberButton())
                    Button(action: calcFunctions.numberClicked(numberValue: 8)) {
                        Text("8")
                    }
                    .buttonStyle(NumberButton())
                    Button(action: calcFunctions.numberClicked(numberValue: 9)) {
                        Text("9")
                    }
                    .buttonStyle(NumberButton())
                    Button(action: calcFunctions.operatorClicked(operatorCharacter: "X")) {
                        Text("X")
                    }
                    .buttonStyle(FunctionButton())
                }
                GridRow {
                    Button(action: calcFunctions.numberClicked(numberValue: 4)) {
                        Text("4")
                    }
                    .buttonStyle(NumberButton())
                    Button(action: calcFunctions.numberClicked(numberValue: 5)) {
                        Text("5")
                    }
                    .buttonStyle(NumberButton())
                    Button(action: calcFunctions.numberClicked(numberValue: 6)) {
                        Text("6")
                    }
                    .buttonStyle(NumberButton())
                    Button(action: calcFunctions.operatorClicked(operatorCharacter: "-")) {
                        Text("-")
                    }
                    .buttonStyle(FunctionButton())
                }
                GridRow {
                    Button(action: calcFunctions.numberClicked(numberValue: 1)) {
                        Text("1")
                    }
                    .buttonStyle(NumberButton())
                    Button(action: calcFunctions.numberClicked(numberValue: 2)) {
                        Text("2")
                    }
                    .buttonStyle(NumberButton())
                    Button(action: calcFunctions.numberClicked(numberValue: 3)) {
                        Text("3")
                    }
                    .buttonStyle(NumberButton())
                    Button(action: calcFunctions.operatorClicked(operatorCharacter: "+")) {
                        Text("+")
                    }
                    .buttonStyle(FunctionButton())
                }
            }
            Grid {
                GridRow {
                    Button(action: calcFunctions.numberClicked(numberValue: 0)) {
                        Text("0")
                    }
                    .buttonStyle(ZeroButton())
                    Button(action: calcFunctions.AddDecimal) {
                        Text(".")
                    }
                    .buttonStyle(ExtraButton())
                    Button(action: calcFunctions.runOperation) {
                        Text("=")
                    }
                    .buttonStyle(FunctionButton())
                }
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
