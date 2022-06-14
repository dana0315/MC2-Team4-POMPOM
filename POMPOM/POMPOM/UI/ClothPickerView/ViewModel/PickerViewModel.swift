//
//  PickerViewModel.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/13.
//

import SwiftUI

class PickerViewModel: ObservableObject {
    //MARK: - Propeties
    @Published var currentType: ClothCategory = .hat
    @Published var currentPresets: [String] = []
    @Published var currentItems: [Cloth] = []
    @Published var items: [Cloth] = {
        var result: [Cloth] = []
        return result
    }()
    
    @Published var selectedItems: [Cloth] = []

    
    // presets 이차원 배열 key : ClothCategory , value -> [String]
    var presets: [ClothCategory : [String]] = [
        .hat : ["000000", "FFFFFF", "325593", "2E614E", "AD5139", "DF002B"],
        .top : ["000000", "FFFFFF", "BAD2F5", "C5C5C7", "23293F", "00914E", "3F2D24", "32323B", ""],
        .bottom : ["000000", "C5C5C7", "ACC8E0", "1D2433", "FAF3E6", "CBAF86", "6D7A3B"],
        .socks : ["000000", "FFFFFF"],
        .shoes : ["000000", "FFFFFF", "8D8983", "AC9F80"]
    ]
    
    // current Item [Cloth]
    
    //MARK: - LifeCycle
    init() {
        changeCategory(with: .hat)
    }
    
    //MARK: - Methods
    func addPreset(hex: String) {
        if currentPresets.contains(hex) {
            print("DEBUG: 중복된 hexcode preset")
            return
        }
    }
    
    func selectCloth(item: Cloth) {
        items.append(item)
    }
    
    func changeCategory(with category: ClothCategory) {
        currentType = category
        currentPresets = presets[category]!
        //옷 아이템도 변경해주기.
        currentItems = {
            let clothes: [Cloth] = []
            
           return clothes
        }()
    }
}

struct Cloth: Identifiable {
    var id: Int
    var name: String
    var category: ClothCategory
}

enum ClothCategory: CaseIterable, Identifiable {
    var id: ClothCategory {
        self
    }
    
    case hat
    case top
    case bottom
    case socks
    case shoes
    
    var koreanSubtitle: String {
        switch self {
        case .hat:
            return "모자"
        case .top:
            return "상의"
        case .bottom:
            return "하의"
        case .socks:
            return "양말"
        case .shoes:
            return "신발"
        }
    }
}
