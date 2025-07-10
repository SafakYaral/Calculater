//
//  ContentView.swift
//  Simple Calculater
//
//  Created by Safak Yaral on 10.07.2025.
//

import SwiftUI

struct MainPage: View {
    init(){
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(named: "mainColor")
        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "textColor1")!,.font: UIFont(name: "Kanit-Italic", size: 24)!]
        
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        
        }
    
    @State private var display = "0"
        @State private var currentNumber: Double = 0
        @State private var previousNumber: Double = 0
        @State private var currentOperation: String? = nil
        @State private var isTypingNumber = false

        let buttons: [[String]] = [
            ["AC", "+/-", "%", "/"],
            ["1", "2", "3", "+"],
            ["4", "5", "6", "-"],
            ["7", "8", "9", "*"],
            ["0", ".", "="]
        ]
    var body: some View {
        NavigationStack{
            
            VStack{
                Text(display)
                    .font(.system(size: 30, weight: .bold, design: .default))
                    .foregroundStyle(Color("textColor1")).frame(width: 305, height: 50)
                    .background(Color("mainColor"))
                    .cornerRadius(5)
                    .padding(.bottom,10)
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { label in
                            Button(label) {
                                self.buttonTapped(label)
                            }
                            .padding(20)
                            .foregroundStyle(Color("textColor1"))
                            .frame(width: label == "0" ? 150 : 70, height: 70)
                            .background(Color("mainColor"))
                            .cornerRadius(5)
                        }
                    }
                }
                
            }.navigationTitle("Simple Calculater").navigationBarTitleDisplayMode(.inline)
                .padding()
            
        }
            
    }
    func buttonTapped(_ label: String) {
            switch label {
            case "0"..."9":
                if isTypingNumber {
                    display += label
                } else {
                    display = label
                    isTypingNumber = true
                }
                currentNumber = Double(display) ?? 0
            case ".":
                if !display.contains(".") {
                    display += "."
                    isTypingNumber = true
                }
            case "+", "-", "*", "/":
                previousNumber = Double(display) ?? 0
                currentOperation = label
                isTypingNumber = false
            case "=":
                let newNumber = Double(display) ?? 0
                if let op = currentOperation {
                    switch op {
                    case "+": currentNumber = previousNumber + newNumber
                    case "-": currentNumber = previousNumber - newNumber
                    case "*": currentNumber = previousNumber * newNumber
                    case "/": currentNumber = previousNumber / newNumber
                    default: break
                    }
                    display = String(currentNumber)
                    isTypingNumber = false
                }
            case "AC":
                if display.count > 1 {
                           display.removeLast()
                       } else {
                           display = "0"
                           currentNumber = 0
                           previousNumber = 0
                           currentOperation = nil
                           isTypingNumber = false
                       }
            case "+/-":
                if let value = Double(display) {
                    display = String(-value)
                    currentNumber = -value
                }
            case "%":
                if let value = Double(display) {
                    display = String(value / 100)
                    currentNumber = value / 100
                }
            default:
                break
            }
        }
}


#Preview {
    MainPage()
}

