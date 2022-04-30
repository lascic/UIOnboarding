//
//  ContentView.swift
//  UIOnboarding SwiftUI
//
//  Created by Lukman Aščić on 19.02.22.
//

import SwiftUI

struct ContentView: View {
    @State private var showingOnboarding = true
    
    var body: some View {
        NavigationView {
            Text("Hello, UIOnboarding!")
                .toolbar {
                    Button {
                        showingOnboarding = true
                    } label: {
                        Image(systemName: "repeat")
                    }
                }
                .fullScreenCover(isPresented: $showingOnboarding, content: {
                    OnboardingView()
                        .edgesIgnoringSafeArea(.all)
                })
                .preferredColorScheme(.dark)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("iPhone 13")
    }
}
