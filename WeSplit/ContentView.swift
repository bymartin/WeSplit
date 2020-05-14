//
//  ContentView.swift
//  WeSplit
//
//  Created by Barry Martin on 5/8/20.
//  Copyright © 2020 Barry Martin. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = ""
    @State private var numberOfPeople = "2"
    @State private var tipPercentage = 3
    
    let tipPercentages = [10, 15, 18, 20, 25, 0]
    
    private var peopleCount: Double {
        if let numPeople = Double(numberOfPeople) {
            return numPeople
        } else {
            return 2
        }
    }
    
    private var tipSelection: Double {
        return Double(tipPercentages[tipPercentage])
    }
    
    private var orderAmount: Double {
        return Double(checkAmount) ?? 0
    }
    
    private var tipValue: Double {
        return orderAmount / 100 * tipSelection
    }
    
    private var grandTotal: Double {
        if orderAmount == 0 {
            return 0
        } else {
            return orderAmount + tipValue
        }
    }
    
    private var totalPerPerson: Double {
        return grandTotal / peopleCount
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", text: $checkAmount)
                        .keyboardType(.decimalPad)
                    
//                    Picker("Number of people", selection: $numberOfPeople) {
//                        ForEach(2 ..< 100) {
//                            Text("\($0) people")
//                        }
//                    }
                }
                
                Section(header: Text("How many people are splitting?")) {
                    TextField("2", text: $numberOfPeople)
                        .keyboardType(.numberPad)
                }
                
                Section(header: Text("How much tip do you want to leave?")) {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Amount per person")) {
                    Text("$\(totalPerPerson, specifier: "%.2f")")
                }
                Section(header: Text("Total Amount with tip")) {
                    Text("$\(grandTotal, specifier: "%.2f")")
                        // show total in red if no tip
                        .foregroundColor(tipValue > 0 ? .black : .red)
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
