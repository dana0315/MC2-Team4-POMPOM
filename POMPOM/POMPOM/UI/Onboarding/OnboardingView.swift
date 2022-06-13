//
//  OnboardingView.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/09.
//

import SwiftUI

struct OnboardingView: View {
    
    // CoupleView에 밑에 코드 추가
    //@AppStorage("_isFirstLanching") var isFirstLaunching: Bool = true
    
    //@Binding var isFirstLunching: Bool
    
    var body: some View {
        TabView {
            FirstOnboardingView()
            SecondOnboardingView()
            ThirdOnboardingView()
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
     }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

/// "내일 뭐 입고 올거야?" Onboarding View
struct FirstOnboardingView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 84)
            Text("내일 뭐 입고 올꺼야?")
                .font(.system(size: 30, weight: .heavy))
                .frame(height: 20)
                .padding(17)
            Text("커플 인생샷을 남기고 싶은데\n상대방이 무엇이 입고올지 고민인가요?")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .lineSpacing(6)
            Spacer()
                .frame(height: 80)
            HStack {
                Spacer()
                    .frame(width: 110)
                Image("CuriousBear")
                Spacer()
            }
            Spacer()
         }
     }
}

/// "코디 너로 결정!" Onboarding View
struct SecondOnboardingView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 84)
            Text("코디 너로 결정!")
                .font(.system(size: 30,  weight: .heavy))
                .frame(height: 20)
                .padding(17)
            Text("내 옷장에 색상을 넣고\n같이 컬러 조합을 맞춰봐요")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .lineSpacing(6)
            Spacer()
                .frame(height: 75)
            HStack {
                Spacer()
                    .frame(width: 5)
                Image("ChooseClothes")
                Spacer()
            }
            
            Spacer()
         }
     }
}

/// "함께 맞춰봐요" Onboarding View
struct ThirdOnboardingView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 84)
            Text("함께 맞춰봐요")
                .font(.system(size: 30, weight: .heavy))
                .frame(height: 20)
                .padding(17)
            Text("상대방과 연결을 통해\n실시간으로 소통하며 확인해요")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .lineSpacing(6)
            Spacer()
                .frame(height: 75)
            HStack {
                Spacer()
                Image("Connection")
                Spacer()
            }
            Spacer()
            Button(action: {
                //임시코드 - 누르면 CoupleView로 넘어감.
                print("시작하기")
                // isFirstLaunching.toggle()
                // 위에 코드로 변경예정
                
            }) {
                Text("시작하기")
                    .padding()
                    .frame(width: 302, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(8)
            }
            .padding(20)
            Spacer()
                .frame(height: 50)
         }
     }
}

//한개의 뷰로 구현
struct OnboardingPageView: View {
    var title: String
    var message: String
    var onboardingImage: String
    var ImageSpacer: CGFloat
    
    init(title: String, message: String, onbordingImage: String, ImageSpacer: CGFloat) {
        self.title = title
        self.message = message
        self.onboardingImage = onbordingImage
        self.ImageSpacer = ImageSpacer
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 84)
            Text(title)
                .font(.system(size: 30, weight: .heavy))
                .frame(height: 20)
                .padding(17)
            Text(message)
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .lineSpacing(6)
            Spacer()
                .frame(height: 80)
            HStack {
                Spacer()
                    .frame(width: ImageSpacer)
                Image(onboardingImage)
                Spacer()
            }
            Spacer()
         }
     }
}
