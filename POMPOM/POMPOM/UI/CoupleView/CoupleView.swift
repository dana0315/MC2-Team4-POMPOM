//
//  CoupleView.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/09.
//

import SwiftUI

struct CoupleView: View {
    var characterSpacing: CGFloat {
        Constant.screenWidth * (33 / 390)
    }
    
    var characterWidth: CGFloat {
        Constant.screenWidth * (145 / 390)
    }
    
    var characterOffset: CGFloat {
        Constant.screenHeight * (93 / 844)
    }
    
    @State private var partnerConnected = false
    @State private var actionSheetPresented = false
    @State private var selectedTab = "home"
    @State private var codeInput = ""
    
    var body: some View {
        NavigationView {
            TabView(selection: $selectedTab, content: {
                VStack {
                    HStack(spacing: characterSpacing) {
                        Button {
                            actionSheetPresented = true
                        } label: {
                            ZStack {
                                Image("Character")
                                    .scaledToFit()
                                    .frame(width: characterWidth)
                                    .opacity(partnerConnected ? 1 : 0.3)
                                if !partnerConnected {
                                    Text("초대하기")
                                        .foregroundColor(.orange)
                                }
                            }
                        }
                        .disabled(partnerConnected)

                        Image("Character")
                            .scaledToFit()
                            .frame(width: characterWidth)
                    }
                    .offset(y: characterOffset)
                    Spacer()
                }
                .tag("home")
                
                CodeOutputView(code: "ABCSDDFS") {
                    
                }
                .tag("codeOutput")
                
                CodeInputView(textInput: $codeInput) {
                    
                }
                .tag("codeInput")
            })
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("POMPOM")
                        .font(.custom("Montserrat-ExtraBold", size: 20))
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Text("Hello world")) {
                        Image(systemName: "gearshape.fill")
                            .foregroundColor(Color(UIColor.label))
                    }
                }
            }
            .actionSheet(isPresented: $actionSheetPresented) {
                ActionSheet(title: Text("초대코드 확인/입력"), buttons: [
                    .default(Text("초대코드 확인하기")) {
                    selectedTab = "codeOutput"
                },
                    .default(Text("초대코드 입력하기")) {
                    selectedTab = "codeInput"
                    codeInput = ""
                }, .cancel(Text("돌아가기"))])
            }
        }
    }
}

struct CoupleView_Previews: PreviewProvider {
    static var previews: some View {
        CoupleView()
    }
}
