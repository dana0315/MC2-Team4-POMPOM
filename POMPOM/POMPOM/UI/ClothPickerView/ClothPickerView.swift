//
//  ClothPickerView.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/13.
//

import SwiftUI

struct ClothPickerView: View {
    @StateObject var vm = PickerViewModel()
    @State var currentCategory = ClothCategory.hat
    @State var currentHex: String = "FFFFFF"
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                CategoryGrid(vm: vm, currentHex: $currentHex, currentCategory: $currentCategory)
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
                    ColorGrid(vm: vm, currentHex: $currentHex)
                        .padding(.leading, 10)
                        .padding(10)
                    
                }
                Seperator()
                    .padding(.bottom, 20)
                ClothGrid(vm: vm, currentCategory: $currentCategory, currentHex: $currentHex)
                    .padding(.horizontal, 20)
            }
        }
    }
}

struct CategoryGrid: View {
    @ObservedObject var vm: PickerViewModel
    @State var offSet: CGFloat = Constant.screenWidth / 2 - 60
    @Binding var currentHex: String
    @Binding var currentCategory: ClothCategory
    let rows = [GridItem(.fixed(44))]
    var body: some View {
        LazyHGrid(rows: rows, spacing: 40) {
            ForEach(ClothCategory.allCases) { category in
                Text(category.koreanSubtitle)
                    .font(.body)
                    .fontWeight(.semibold)
                    .foregroundColor(category == vm.currentType ? Color(hex: "FF5100") : Color(hex: "A0A0A0"))
                    .onTapGesture {
                        // 맥락 바꾸기.
                        vm.changeCategory(with: category)
                        withAnimation(.spring()) {
                            switch vm.currentType {
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
                        currentCategory = category
                        currentHex = vm.currentPresets.first!
                    }
            }
            .offset(x: offSet, y: 0)
        }
       
    }
}

struct ColorGrid: View {
    @ObservedObject var vm: PickerViewModel
    @Binding var currentHex: String
    
    let rows = [GridItem(.fixed(44), spacing: 20)]
    var body: some View {
        LazyHGrid(rows: rows, spacing: 18) {
            ForEach($vm.currentPresets, id: \.self) { item in
                ZStack {
                    Circle()
                        .fill(Color(hex: item.wrappedValue))
                        .frame(width: 44)
                        .shadow(radius: 5)
                        .onTapGesture {
                            withAnimation {
                                currentHex = item.wrappedValue
                            }
                        }
                        .overlay {
                            if item.wrappedValue == currentHex {
                                Circle()
                                    .stroke(Color(hex: "BABABA"), lineWidth: 3)
                                    .frame(width: 60, height: 60, alignment: .center)
                            }
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
                    vm.addPreset(hex: "23F323")
                }
        }
    }
}


struct ClothGrid: View {
    @ObservedObject var vm: PickerViewModel
    @Binding var currentCategory: ClothCategory
    @Binding var currentHex: String
    
    let columns = [
        GridItem(.flexible(minimum: 60), spacing: 20),
        GridItem(.flexible(minimum: 60), spacing: 20)
    ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach($vm.currentItems, id: \.self) { item in
                ZStack {
                    Image(vm.imageName(name: item.wrappedValue) + "B")
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundColor(Color(hex: currentHex))
                    
                    Image(vm.imageName(name: item.wrappedValue))
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .foregroundColor(currentHex == "000000" ? .gray : .black) // 검정색일 때 옷 테두리 색상 변경
                        .overlay {
                            if vm.selectedItems[currentCategory]?.id == item.wrappedValue {
                                RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color(hex: "BABABA"), lineWidth: 4)
                                    .frame(width: 180, height: 180, alignment: .center)
                            }
                        }
                }
                .onTapGesture {
                    withAnimation {
                        vm.selectItem(name: item.wrappedValue, hex: currentHex)
                    }
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
