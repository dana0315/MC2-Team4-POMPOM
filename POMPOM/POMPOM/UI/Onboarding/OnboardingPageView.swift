//
//  OnboardingPageView.swift
//  POMPOM
//
//  Created by 양원모 on 2022/06/13.
//

import SwiftUI

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

//struct OnboardingPageView_Previews: PreviewProvider {
//    static var previews: some View {
//        OnboardingPageView()
//    }
//}

