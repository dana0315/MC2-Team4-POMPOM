//
//  ColorPickerView.swift
//  POMPOM
//
//  Created by 양원모 on 2022/06/15.
//

import SwiftUI

struct ColorPickerView: View {
    
    @State private var selectColor: Color = .black
    
    var body: some View {
        
        VStack {
            Circle()
                .fill(selectColor)
                .frame(width: 44)
                .shadow(radius: 5)

            ColorPicker("", selection: $selectColor,supportsOpacity: false)
                .labelsHidden()
                .overlay(Circle()
                    .fill(Color(hex: "D8D8D8"))
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "plus")
                            .font(.title2))
                            .allowsHitTesting(false))
        }
    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
    }
}

//https://stackoverflow.com/questions/67145122/how-can-i-change-layout-of-apple-colorpicker-from-circle-to-square-in-swiftui
//
