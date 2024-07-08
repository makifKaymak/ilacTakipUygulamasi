//
//  OTPView.swift
//  ilacTakip
//
//  Created by Mehmet Akif Kaymak on 13.02.2024.
//
/*
import SwiftUI

struct OTPView: View {
    @Binding var otpText: String
    /// Environment Properties
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading,spacing: 15, content: {
            /// Back Button
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 10)
            
            Text("Enter OTP")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 5)
            
            Text("An 6 digit code has been sent to your Email ID.")
                .font(.caption)
                .font(.callout)
                .fontWeight(.semibold)
                .foregroundStyle(.gray)
                .padding(.top, -5)
            
            VStack(spacing: 25) {
                /// Custom OTP TextField
                
                GradientButton(title: "Send Link", icon: "arrow.right") {
                    /// Buraya code yaz firebaseden işte bi şekilde bişiler link yollansın falan
                    
                }
                .hSpacing(.trailing)
                /// Disabling Until the Data is Entered
                .disableWithOpacity(otpText.isEmpty)
            }
            .padding(.top, 20)
        })
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        /// Since this is going to be a Sheet
        .interactiveDismissDisabled()
    }
}

#Preview {
 LoginSignUpContentView(userId: <#String#>)
}
*/
