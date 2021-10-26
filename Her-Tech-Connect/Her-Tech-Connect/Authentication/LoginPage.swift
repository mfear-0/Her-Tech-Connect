//
//  LoginPage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/21/21.
//

import SwiftUI

struct LoginPage: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State var isUserInfoCorrect = true
    @State private var showingSheet = false
    var body: some View {
        VStack{
            Image(systemName: "applelogo")
                .resizable()
                .frame(width: 100, height: 120)
                .foregroundColor(.pink)
            
            ZStack(alignment: .bottom){
                VStack(alignment:.center, spacing: 16){
                    if viewModel.isWrongEmail {
                        Text("Email provided is invalid")
                            .foregroundColor(.red)
                    }
                    
                    else if viewModel.isWrongPassword {
                        Text("Password provided is wrong")
                            .foregroundColor(.red)
                    }
                    
                    else if !viewModel.isFilled {
                        Text("Please fill out all info")
                            .foregroundColor(.red)
                    }
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
                    .padding(.top, 25)
                    
                    HStack{
                        Image(systemName: "lock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.pink)
                        SecureField("Enter Password", text: $password)
                            .padding(.leading, 12)
                            .font(.system(size: 20))
                    }
                    .padding(12)
                    .background(Color(.systemGray4))
                    .clipShape(Rectangle())
                    .cornerRadius(35)
                    .padding(.top, 25)
                    
                    HStack {
                        Spacer(minLength: 0)
                        
                        Button(action: {
                            showingSheet.toggle()
                        }, label: {
                            Text("Forgot Password?")
                                .foregroundColor(Color.pink.opacity(0.6))
                        })
                        .sheet(isPresented: $showingSheet) {
                            ResetPasswordPage()
                        }
                    }
                }
                .padding()
                .padding(.bottom, 25)
                .padding(.horizontal, 20)
            }
            
            Button(action: {
                guard !email.isEmpty, !password.isEmpty else {
                    viewModel.isFilled = false
                    viewModel.isWrongEmail = false
                    viewModel.isWrongPassword = false
                    return
                }
                
                viewModel.signIn(email: email, password: password)
                
            }, label: {
                Text("LOGIN")
                    .foregroundColor(Color(.systemTeal))
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 80)
                    .background(Color.pink)
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
            })
            
            HStack(spacing: 15){
                Rectangle()
                    .fill(Color.pink)
                    .frame(height: 1)
                Text("Or")
                    .foregroundColor(.pink)
                Rectangle()
                    .fill(Color.pink)
                    .frame(height: 1)
                
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 25)
            NavigationLink(
                destination: RegisterPage(),
                label: {
                    Text("REGISTER")
                        .foregroundColor(Color(.systemTeal))
                        .fontWeight(.bold)
                        .padding(.vertical)
                        .padding(.horizontal, 100)
                        .background(Color.pink)
                        .clipShape(Capsule())
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                })
        }
        .padding(.bottom, 60)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemTeal).ignoresSafeArea())
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
