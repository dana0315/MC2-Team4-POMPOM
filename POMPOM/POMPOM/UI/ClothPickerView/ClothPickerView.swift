//
//  ClothPickerView.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/13.
//

import SwiftUI

struct ClothPickerView: View {
    @StateObject var viewModel = PickerViewModel()
    
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                CategoryGrid(viewModel: viewModel)
                
                Seperator()
                
                HStack {
                    Text("내 옷장")
                        .font(.custom("none", size: 15))
                    Spacer()
                }
                .padding(.leading, 20)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    ColorGrid(viewModel: viewModel)
                        .padding(.leading, 10)
                        .padding(10)
                    
                }
                Seperator()
                    .padding(.bottom, 20)
                ClothGrid(viewModel: viewModel)
                    .padding(.horizontal, 20)
            }
        }
    }
}

struct CategoryGrid: View {
    @ObservedObject var viewModel: PickerViewModel
    @State var cuurentCategory = ClothCategory.hat
    
    let rows = [GridItem(.fixed(44), spacing: 20)]
    var body: some View {
        LazyHGrid(rows: rows, spacing: 27) {
            ForEach(ClothCategory.allCases) { category in
                Text(category.koreanSubtitle())
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(category == cuurentCategory ? Color(hex: "FF5100") : Color(hex: "A0A0A0"))
                    .onTapGesture {
                        // 맥락 바꾸기.
                        cuurentCategory = category
                        
                    }
            }
        }
    }
}

struct ColorGrid: View {
    @ObservedObject var viewModel: PickerViewModel
    let rows = [GridItem(.fixed(44), spacing: 20)]
    var body: some View {
        LazyHGrid(rows: rows, spacing: 18) {
            ForEach($viewModel.presets, id: \.self) { item in
                ZStack {
                    Circle()
                        .fill(Color(hex: item.wrappedValue))
                        .frame(width: 44)
                        .shadow(radius: 5)
                }
            }
            Circle()
                .fill(Color(hex: "D8D8D8"))
                .frame(width: 44)
                .overlay(
                    Image(systemName: "plus")
                        .font(.title2)
                        
                )
                .onTapGesture {
                    print("DEBUG : Button tapped")
                    viewModel.addPreset(hex: "23F323")
                }
        }
    }
}


struct ClothGrid: View {
    @ObservedObject var viewModel: PickerViewModel
    let columns = [
        GridItem(.flexible(minimum: 60, maximum: 200), spacing: 20),
        GridItem(.flexible(minimum: 60, maximum: 200),spacing: 20)
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(0..<12) { item in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(height: 160)
                    .onTapGesture {
                        
                    }
            }
        }
    }
}

struct ClothPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ClothPickerView()
    }
}

struct Seperator: View {
    var body: some View {
        Rectangle()
            .fill(Color(hex: "D8D8D8"))
            .frame(height: 0.75)
    }
}
