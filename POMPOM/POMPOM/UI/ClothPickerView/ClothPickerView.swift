//
//  ClothPickerView.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/13.
//

import SwiftUI

struct ClothPickerView: View {
    @StateObject var viewModel = ViewModel()
 
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                HStack {
                    Text("내 옷장")
                        .font(.custom("몰라", size: 15))
                    Spacer()
                }
                .padding(.leading, 20)
                .padding(.bottom, 10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    ColorGrid(viewModel: viewModel)
                    .padding(.leading, 20)
                    .padding(.bottom, 20)
                }
               Rectangle()
                    .fill(.black.opacity(0.3))
                    .frame(height: 0.75)
                    .padding(.bottom, 20)
                ClothGrid(viewModel: viewModel)
                    .padding(.horizontal, 20)
            }
        }
    }
}

struct ColorGrid: View {
    @ObservedObject var viewModel: ViewModel
    let rows = [GridItem(.fixed(44), spacing: 20)]
    var body: some View {
        LazyHGrid(rows: rows, spacing: 18) {
            ForEach($viewModel.items) { item in
                ZStack {
                    Circle()
                        .fill(.blue)
                        .frame(width: 44)
                   
                }
            }
            Circle()
                .fill(.pink)
                .frame(width: 44)
                .onTapGesture {
                    print("DEBUG : Button tapped")
                    viewModel.addItem()
                }
        }
    }
}


struct ClothGrid: View {
    @ObservedObject var viewModel: ViewModel
    let columns = [
        GridItem(.flexible(minimum: 60, maximum: 200), spacing: 20),
        GridItem(.flexible(minimum: 60, maximum: 200),spacing: 20)
    ]
    var body: some View {
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(viewModel.items) { item in
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.blue)
                    .frame(height: 160)
                    .onTapGesture {
                        print(item.id)
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
