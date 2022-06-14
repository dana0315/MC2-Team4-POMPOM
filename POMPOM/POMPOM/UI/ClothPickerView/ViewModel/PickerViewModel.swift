//
//  PickerViewModel.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/13.
//

import Foundation

class ViewModel: ObservableObject {
    @Published var items: [Model] = {
        var result: [Model] = []
        for i in 0..<12 {
            result.append(Model(id: i))
        }
        return result
    }()
    
    func addItem() {
        items.append(Model(id: items.count + 1))
        print("DEBUG: add Item")
    }
}


struct Model: Identifiable {
    var id: Int
}
