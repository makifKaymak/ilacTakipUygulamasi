//
//  YeniKayıtOlDenemesi.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 13.02.2024.
//

import SwiftUI

struct LoginSignUpContentView: View {
    
    @State private var showSignup: Bool = false
    @State private var isKeyboardShowing = false
    @State private var keyboardHeight: CGFloat = 0
    
    //let userId: String
    
    var body: some View {
        NavigationStack {
            LoginView(showSignup: $showSignup)
                .navigationDestination(isPresented: $showSignup) {
                    SignupView(showSignup: $showSignup)
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillShowNotification)) { notification in
                    if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                        let frame = keyboardFrame.cgRectValue
                        keyboardHeight = frame.height
                    }
                    isKeyboardShowing = true
                }
                .onReceive(NotificationCenter.default.publisher(for: UIResponder.keyboardWillHideNotification)) { _ in
                    isKeyboardShowing = false
                    keyboardHeight = 0
                }
        }
        .overlay {
            // Animate CircleView vertically based on keyboardHeight
            CircleView()
                .animation(.easeInOut(duration: 0.3), value: isKeyboardShowing)
                .offset(y: isKeyboardShowing ? -keyboardHeight / 2 : 0)
        }
    }
    
    @ViewBuilder
    func CircleView() -> some View {
        Circle()
            //.fill(.linearGradient(colors: [.yellow, .orange, .red], startPoint: .top, endPoint: .bottom))
            .fill(.pinkAccent)
            .frame(width: 200, height: 200)
            .offset(x: showSignup ? 90 : -90, y: -90 - (isKeyboardShowing ? 200: 0))
            .blur(radius: 15)
            .hSpacing(showSignup ? .trailing : .leading)
            .vSpacing(.top)
    }
}

/*
 #Preview {
 LoginSignUpContentView()
 }
 */
