//
//  ContentView.swift
//  VizvozApp
//
//  Created by Irem Nur Arslaner on 11/12/24.
//

import SwiftUI

struct ContentView: View {
    @State private var currentView: CurrentView = .splash

    var body: some View {
        NavigationStack {
            switch currentView {
            case .splash:
                SplashScreenView(isPresented: Binding(
                    get: { currentView == .splash },
                    set: { if !$0 { currentView = .onboarding } }
                ))
            case .onboarding:
                OnboardingView(onNext: {
                    currentView = .contacts
                })
            case .contacts:
                ContactPage()
            }
        }
    }
}

enum CurrentView {
    case splash
    case onboarding
    case contacts
}


#Preview {
    ContentView()
}
