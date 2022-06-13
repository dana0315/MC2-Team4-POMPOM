//
//  OnboardingViewModel.swift
//  POMPOM
//
//  Created by 양원모 on 2022/06/13.
//

import SwiftUI

struct OnboardingViewModel: Identifiable {
    var id = UUID()
    var title: String
    var message: String
    var onboardingImage: String
    var ImageSpacer: CGFloat
}

let onboardingViewData : [OnboardingViewModel] = [
    OnboardingViewModel(
        title: "내일 뭐 입고 올꺼야?",
        message: "커플 인생샷을 남기고 싶은데\n상대방이 무엇이 입고올지 고민인가요?",
        onboardingImage: "CuriousBear",
        ImageSpacer: 110
    ),
    
    OnboardingViewModel(
        title: "코디 너로 결정!",
        message: "내 옷장에 색상을 넣고\n같이 컬러 조합을 맞춰봐요",
        onboardingImage: "ChooseClothes",
        ImageSpacer: 6
    ),
    
    OnboardingViewModel(
        title: "함께 맞춰봐요",
        message: "상대방과 연결을 통해\n실시간으로 소통하며 확인해요",
        onboardingImage: "Connection",
        ImageSpacer: 36
    )
]

