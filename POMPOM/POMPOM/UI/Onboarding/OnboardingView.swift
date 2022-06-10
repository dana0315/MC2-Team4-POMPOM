//
//  OnboardingView.swift
//  POMPOM
//
//  Created by GOngTAE on 2022/06/09.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        TabView {
            FirstOnboardingView()
            SecondOnboardingView()
            ThirdOnboardingView()
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
     }
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}

// "내일 뭐 입고 올거야?" Onboarding View
struct FirstOnboardingView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 84)
            Text("내일 뭐 입고 올꺼야?")
                .font(.system(size: 30))
                .bold()
                .frame(height: 14)
                .padding()
            Text("커플 인생샷을 남기고 싶은데\n상대방이 무엇이 입고올지 고민인가요?")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 75)
            // "물음표 곰돌이" 자리
            Rectangle()
                .frame(width: 350, height: 350)
            Spacer()
         }
     }
}

// "코디 너로 결정!" Onboarding View
struct SecondOnboardingView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 84)
            Text("코디 너로 결정!")
                .font(.system(size: 30))
                .bold()
                .frame(height: 14)
                .padding()
            Text("내 옷장에 색상을 넣고\n같이 컬러 조합을 맞춰봐요")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 75)
            // "기능 사진" 자리
            Rectangle()
                .frame(width: 350, height: 350)
            Spacer()
         }
     }
}

// "함께 맞춰봐요" Onboarding View
struct ThirdOnboardingView: View {
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 84)
            Text("함께 맞춰봐요")
                .font(.system(size: 30))
                .bold()
                .frame(height: 14)
                .padding()
            Text("상대방과 연결을 통해\n실시간으로 소통하며 확인해요")
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
            Spacer()
                .frame(height: 75)
            // "공유 사진" 자리
            Rectangle()
                .frame(width: 350, height: 350)
            Spacer()
            Button(action: {
                //임시코드
                print("시작하기")
            }) {
                Text("시작하기")
                    .padding()
                    .frame(width: 302, height: 50)
                    .foregroundColor(.white)
                    .background(Color.black)
                    .cornerRadius(8)
            }
            .padding(30)
         }
     }
}
