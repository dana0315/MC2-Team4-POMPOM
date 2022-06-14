//
//  ClothPickerView.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/13.
//

import SwiftUI

struct ClothPickerView: View {
    @StateObject var viewModel = PickerViewModel()
    @State var currentCategory = ClothCategory.hat
    @State var currentColor: Color = .white
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                CategoryGrid(viewModel: viewModel, currentColor: $currentColor)
                    .frame(width: Constant.screenWidth)
                
                Seperator()
                
                HStack {
                    Text("내 옷장")
                        .font(.custom("none", size: 15))
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.top, 15)
                
                
                ScrollView(.horizontal, showsIndicators: false) {
                    ColorGrid(viewModel: viewModel, currentColor: $currentColor)
                        .padding(.leading, 10)
                        .padding(10)
                    
                }
                Seperator()
                    .padding(.bottom, 20)
                ClothGrid(viewModel: viewModel, currentCategory: $currentCategory, currentColor: $currentColor)
                    .padding(.horizontal, 20)
            }
        }
    }
}

struct CategoryGrid: View {
    @ObservedObject var viewModel: PickerViewModel
    @State var offSet: CGFloat = Constant.screenWidth / 2 - 60
    @Binding var currentColor: Color
    
    let rows = [GridItem(.fixed(44))]
    var body: some View {
        LazyHGrid(rows: rows, spacing: 40) {
            ForEach(ClothCategory.allCases) { category in
                Text(category.koreanSubtitle)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(category == viewModel.currentType ? Color(hex: "FF5100") : Color(hex: "A0A0A0"))
                    .onTapGesture {
                        // 맥락 바꾸기.
                        viewModel.changeCategory(with: category)
                        withAnimation(.spring()) {
                            switch viewModel.currentType {
                            case .hat:
                                offSet = Constant.screenWidth / 2 - 60
                            case .top:
                                offSet = Constant.screenWidth / 2 - 120
                            case .bottom:
                                offSet = Constant.screenWidth / 2 - 190
                            case .socks:
                                offSet = Constant.screenWidth / 2 - 265
                            case .shoes:
                                offSet = Constant.screenWidth / 2 - 330
                            }
                        }
                        currentColor = Color(hex: viewModel.currentPresets.first!)
                    }
            }
            .offset(x: offSet, y: 0)
        }
       
    }
}

struct ColorGrid: View {
    @ObservedObject var viewModel: PickerViewModel
    @Binding var currentColor: Color
    
    let rows = [GridItem(.fixed(44), spacing: 20)]
    var body: some View {
        LazyHGrid(rows: rows, spacing: 18) {
            ForEach($viewModel.currentPresets, id: \.self) { item in
                ZStack {
                    Circle()
                        .fill(Color(hex: item.wrappedValue))
                        .frame(width: 44)
                        .shadow(radius: 5)
                        .onTapGesture {
                            currentColor = Color(hex: item.wrappedValue)
                        }
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
    @Binding var currentCategory: ClothCategory
    @Binding var currentColor: Color
    
    let columns = [
        GridItem(.flexible(minimum: 60), spacing: 20),
        GridItem(.flexible(minimum: 60), spacing: 20)
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach($viewModel.currentItems, id: \.self) { item in
               
               
                Image("c-\(currentCategory.englishSutitle)-\(item.wrappedValue)B")
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundColor(currentColor)
                    .overlay {
                        Image("c-\(currentCategory.englishSutitle)-\(item.wrappedValue)")
                            .resizable()
                            //검정색일 때 테두리 색 변경해주어야함.
                    }
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
