//
//  CommentTextField.swift
//  POMPOM
//
//  Created by 김남건 on 2022/06/12.
//

import SwiftUI

struct CommentTextField: View {
    let height = Constant.screenHeight * (48 / 844)
    let spacing = Constant.screenWidth * (17.8 / 390)
    let fontSize = Constant.screenHeight * (16 / 844)
    
    let logoHeight = Constant.screenHeight * (16.28 / 844)
    var logoWidth: CGFloat {
        logoHeight * (22.2 / 16.28)
    }
    
    let leftMargin = Constant.screenWidth * (18 / 390)
    let rightMargin = Constant.screenWidth * (5 / 390)
    
    let buttonUnitLength = Constant.screenHeight * (44 / 844)
    
    var buttonColor: Color {
        textInput.isEmpty ? Color(UIColor.systemGray2) : .orange
    }
    
    @Binding var textInput: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: height / 2)
                .foregroundColor(Color(UIColor.systemGray5))
            HStack(spacing: spacing) {
                Rectangle()
                    .frame(width: logoWidth, height: logoHeight)
                    .padding(.leading, leftMargin)
                TextField("코멘트를 입력하세요.", text: _textInput)
                    .font(.system(size: fontSize))
                Button(action: {}) {
                    Image(systemName: "location.fill")
                        .foregroundColor(buttonColor)
                }
                .frame(width: buttonUnitLength, height: buttonUnitLength)
                .padding(.trailing, rightMargin)
            }
        }
        .frame(height: height)
    }
}

struct CommentTextField_Previews: PreviewProvider {
    static var previews: some View {
        CommentTextField(textInput: .constant(""))
    }
}
