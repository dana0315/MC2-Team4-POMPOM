//
//  PickerViewModel.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/13.
//

import SwiftUI

class PickerViewModel: ObservableObject {
    @Published var presets: [String] = ["FFFFFF", "121212", "234212"]
    @Published var items: [Cloth] = {
        var result: [Cloth] = []
        
        return result
    }()
    
    func addPreset(hex: String) {
        if presets.contains(hex) {
            print("DEBUG: 중복된 hexcode preset")
            return
        }
        presets.append(hex)
    }
}

extension Color {
    init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.currentIndex = hex.startIndex
        var rgbValue: UInt64 = 0
        scanner.scanHexInt64(&rgbValue)

        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff

        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff
        )
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
    case layered
    case bottom
    case socks
    case shoes
    
    func koreanSubtitle() -> String {
        switch self {
        case .hat:
            return "모자"
        case .top:
            return "상의"
        case .layered:
            return "레이어드"
        case .bottom:
            return "하의"
        case .socks:
            return "양말"
        case .shoes:
            return "신발"
        }
    }
}
