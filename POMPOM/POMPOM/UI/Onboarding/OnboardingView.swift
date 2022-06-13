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
            OnboardingPageView(onboardingViewModel: onboardingViewData[0])
            OnboardingPageView(onboardingViewModel: onboardingViewData[1])
            OnboardingPageView(onboardingViewModel: onboardingViewData[2])
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

///한개의 뷰로 구현
struct OnboardingPageView: View {
    var onboardingViewModel: OnboardingViewModel
    
    
    init(onboardingViewModel: OnboardingViewModel) {
        self.onboardingViewModel = onboardingViewModel
    }
    
    var body: some View {
        VStack {
            Spacer()
                .frame(height: 84)
            Text(onboardingViewModel.title)
                .font(.system(size: 30, weight: .heavy))
                .frame(height: 20)
                .padding(17)
            Text(onboardingViewModel.message)
                .font(.system(size: 17))
                .multilineTextAlignment(.center)
                .lineSpacing(6)
            Spacer()
                .frame(height: 80)
            HStack {
                Spacer()
                    .frame(width: onboardingViewModel.ImageSpacer)
                Image(onboardingViewModel.onboardingImage)
                Spacer()
            }
            Spacer()
         }
     }
}
