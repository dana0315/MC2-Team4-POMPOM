//
//  SheetView.swift
//  POMPOM
//
//  Created by 김남건 on 2022/06/12.
//

import SwiftUI

enum SheetMode {
    case low, mid, high, full
}

struct SheetView<Content: View>: View {
    @Binding var sheetMode: SheetMode
    let content: () -> Content
    
    private var offset: CGFloat {
        switch sheetMode {
        case .low:
            return Constant.screenHeight * (693 / 844)
        case .mid:
            return Constant.screenHeight * (396 / 844)
        case .high:
            return Constant.screenHeight * (216 / 844)
        case .full:
            return Constant.screenHeight * (93 / 844)
        }
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .foregroundColor(Color(UIColor.systemGray))
                .shadow(color: Color(UIColor.systemGray), radius: 15, x: 5, y: 3)
            VStack {
                content()
                Spacer(minLength: Constant.screenHeight - offset)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        }
        .offset(y: offset)
        .animation(.spring(), value: offset)
        .edgesIgnoringSafeArea(.all)
    }
}

struct SheetView_Previews: PreviewProvider {
    static var previews: some View {
        SheetView(sheetMode: .constant(.low)) {
            Text("Hello world!")
        }
    }
}

// 출처: https://www.youtube.com/watch?v=t2gFel5Bins
