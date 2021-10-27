//
//  ResetPasswordPage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/26/21.
//

import SwiftUI

struct ResetPasswordPage: View {
    @Environment(\.presentationMode) var presentationMode
    @State var email = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        VStack {
            Image(systemName: "applelogo")
                .resizable()
                .frame(width: 100, height: 120)
                .foregroundColor(.pink)
            
            Text("Enter your email to reset your password")
                .fontWeight(.bold)
                .foregroundColor(.red)
                .padding(.top, 25)
            
            HStack{
                Image(systemName: "envelope.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20, height: 20)
                    .foregroundColor(.pink)
                TextField("Email Address", text: $email)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.leading, 12)
                    .font(.system(size: 20))
            }
            .padding(12)
            .background(Color(.systemGray4))
            .clipShape(Rectangle())
            .cornerRadius(35)
            .padding(.top, 15)
            .padding(.horizontal, 24)
            
            Button(action: {
                viewModel.resetPassword(email: email)
                presentationMode.wrappedValue.dismiss()
            }, label: {
                Text("SUBMIT")
                    .foregroundColor(Color(.systemTeal))
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 80)
                    .background(Color.pink)
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
            })
            .padding(.top, 15)
            
        }
        .padding(.bottom, 60)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemTeal).ignoresSafeArea())
    }
}

struct ResetPasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordPage()
    }
}
