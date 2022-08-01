//
//  ContentView.swift
//  Unit Conversion
//
//  Created by theswiftintern on 8/1/22.
//

import SwiftUI

struct ContentView: View {
    @State var selectedInputUnit = UnitLength.meters
    @State var selectedOutputUnit = UnitLength.kilometers
    @State var input = 0.0
    @State var output = 0.0
    @FocusState var inputIsFocused: Bool
    
    let length = [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]
    
    func formatLengthToString(_ lengthUnit: UnitLength) -> String {
        let distanceFormatter = MeasurementFormatter()
        distanceFormatter.unitOptions = .providedUnit
        return distanceFormatter.string(from: lengthUnit)
    }
    
    var convertedLength: String {
        let distanceFormatter = MeasurementFormatter()
        distanceFormatter.unitOptions = .providedUnit
        let measurement = Measurement(value: input, unit: selectedInputUnit)
        let convertedMeasurement = measurement.converted(to: selectedOutputUnit)
        return distanceFormatter.string(from: convertedMeasurement)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Input", value: $input, format: .number)
                        .keyboardType(.decimalPad)
                        .focused($inputIsFocused)
                    Picker("Choose length", selection: $selectedInputUnit) {
                        ForEach(length, id: \.self) {
                            Text(formatLengthToString($0))
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert from?")
                }
                
                Section {
                    Picker("Choose length", selection: $selectedOutputUnit) {
                        ForEach(length, id: \.self) {
                            Text(formatLengthToString($0))
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Convert to?")
                }
                
                Section {
                    Text(convertedLength)
                } header: {
                    Text("Result")
                }
            }
            .navigationTitle(("Length Conversion"))
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        inputIsFocused = false
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
