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
