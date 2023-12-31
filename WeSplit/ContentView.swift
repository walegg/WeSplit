//
//  ContentView.swift
//  WeSplit
//
//  Created by Louis Mille on 26/06/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 0
    @FocusState private var amountIsFocused: Bool
    
    var tipPercentages = 0..<101
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople)
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        
        return amountPerPerson
    }
    
    var grandTotal: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        
        return grandTotal
    }
    
    var tipValue: Double {
        let tipSelection = Double(tipPercentage)
        
        let tipValue = checkAmount / 100 * tipSelection
        
        return tipValue
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                } header: {
                    Text("Enter the check's size")
                }
                
                Section {
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(0..<100) {
                            Text("\($0) people")
                        }
                    }
                } header: {
                    Text("Enter the amount of people")
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                            
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(tipValue, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header: {
                    Text("Tip amount")
                }
                
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                } header : {
                    Text("Amount per person")
                }
                
                Section {
                    if tipValue == 0 {
                        Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .foregroundColor(.red)
                    } else {
                        Text(grandTotal, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                } header : {
                    Text("Total amount for the check")
                }
            }
            .navigationTitle("WeSplit 💸")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
