//
//  ContentView.swift
//  WeSplit
//
//  Created by Thaddäus Schima on 04.02.23.
//

import SwiftUI

struct ContentView: View {
    @FocusState private var amountIsFocused: Bool
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    let tipPercentages = [10,15,20,25,0]
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let check = checkAmount + checkAmount*(Double(tipPercentage)/100)
        return check/peopleCount
    }
    var totalAmount: Double {
        checkAmount + (checkAmount/100*Double(tipPercentage))
    }
    var currency: FloatingPointFormatStyle<Double>.Currency = .currency(code: Locale.current.currency?.identifier ?? "EUR")
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currency).focused($amountIsFocused)
                        .keyboardType(.decimalPad)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) peoble")
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }.pickerStyle(.segmented)
                }
                Section {
                    Text((totalPerPerson), format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                        
                } header: {
                    Text("Amount per person")
                }
                Section {
                    Text((totalAmount), format: .currency(code: Locale.current.currency?.identifier ?? "EUR"))
                } header: {
                    Text("Total Amount")
                }
            }.navigationTitle("We Split")
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

