//
//  SplashScreenView.swift
//  VizvozApp
//
//  Created by Irem Nur Arslaner on 11/12/24.
//
import SwiftUI

struct SplashScreenView: View {
    @Binding var isPresented: Bool
    @State private var scale = CGSize(width: 0.8, height: 0.8)
    @State private var imageOpacity = 1.0
    @State private var opacity = 1.0

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            ZStack {
                Image(.vizvoz)
                    .resizable()
                    .scaledToFit()
                    .opacity(imageOpacity)
                    .frame(width: 250, height: 250)
                    .offset(x: 1)
            }
            .scaleEffect(scale)
        }
        .opacity(opacity)
        .onAppear {
            withAnimation(.easeInOut(duration: 1.5)) {
                scale = CGSize(width: 1, height: 1)
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                withAnimation(.easeIn(duration: 0.35)) {
                    scale = CGSize(width: 50, height: 50)
                    opacity = 0
                }
            }

            DispatchQueue.main.asyncAfter(deadline: .now() + 2.9) {
                isPresented = false
            }
        }
    }
}

    
    #Preview {
        SplashScreenView(isPresented: .constant(true))
    }
