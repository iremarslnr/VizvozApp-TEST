//
//  OnboardingView.swift
//  VizvozApp
//
//  Created by Irem Nur Arslaner on 11/12/24.
//

import SwiftUI

struct OnboardingView: View {
    
    var onNext: () -> Void
    
    var body: some View {
        ZStack{
            Color.black
                .ignoresSafeArea()
            
            
            
            Image(.screenshot20241210At192031)
                .resizable()
                .frame(width: 850,height: 850)
                .position(x:500, y:400)
            
            Text("Remember people !")
                .foregroundStyle(Color.black)
                .bold()
                .padding(.leading,200)
                .font(.system(size:25))
                .padding(.top,40)
            
            
            Text("Register your contacts")
                .foregroundStyle(Color.white)
                .bold()
                .padding(.trailing,230)
                .font(.system(size:25))
                .padding(.bottom,500)
            
            ZStack{
                
                
                RoundedRectangle(cornerRadius: 30)
                    .frame(width: 120, height: 50)
                    .padding(.trailing,50)
                    .padding(.top,500)
                    .foregroundStyle(Color.label)
                
                
                
                Button {
                    onNext()
                } label: {
                    Text("Next")
                        .foregroundStyle((Color.white))
                        .padding(.trailing,50)
                        .padding(.top,498)
                }
                .accessibilityLabel("Next")
                .accessibilityHint("Tap to go next page")
                
                
            }
        }
    }
}

#Preview {
   // OnboardingView()
}
