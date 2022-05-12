//
//  LoginPage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/21/21.
//  Modified by Arica Conrad on 11/14/21.
//  Modified by Arica Conrad on 12/6/21.
//  Modified by Arica Conrad on 12/15/21.
//  Modified by Natalman Nahm on 05/11/22

import SwiftUI

struct LoginPage: View {
    
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State var isUserInfoCorrect = true
    @State private var showingSheet = false
    
    var body: some View {
        
        VStack {
            
            // Arica: A decorative ombre band across the top that showcases the app's colors.
            ZStack {
                
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("LightYellow")]), startPoint: .leading, endPoint: .trailing))
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 20)
            }
            
            Spacer()
            
            ScrollView {
                
                VStack {
                                        
                    // Arica: The title text.
                    Text("Sign In")
                        .foregroundColor(Color("DarkBlue"))
                        .font(.title2)
                        .padding()
                    
                    // Arica: Instructional text for the users.
                    Text("Welcome back! Please enter your email and password to sign in.")
                        .foregroundColor(Color("Black"))
                        .font(.body)
                        .padding()
                    
                    // Arica: The following are the field entries to log in.
                    
                    // Arica: The email field.
                    VStack(alignment: .leading) {
                        
                        Text("Email")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                        
                        HStack {
                            
                            Image(systemName: "envelope.fill")
                                .foregroundColor(Color("DarkBlue"))
                            
                            TextField("yourname@hertechconnect.com", text: $email)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay( RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("DarkBlue"), lineWidth: 2))
                        }
                    }
                    .padding()
                    
                    // Arica: The password field.
                    VStack(alignment: .leading) {
                        
                        Text("Password")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                        
                        HStack {
                            
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color("DarkBlue"))
                            
                            SecureField("Password", text: $password)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay( RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("DarkBlue"), lineWidth: 2))
                        }
                        
                        // Arica: The forgot password button.
                        HStack {
                            
                            Spacer()
                            
                            Button(action: {
                                showingSheet.toggle()
                            }, label: {
                                Text("Forgot password?")
                                    .foregroundColor(Color("DarkBlue"))
                                    .font(.body)
                            })
                            .sheet(isPresented: $showingSheet) {
                                ResetPasswordPage()
                            }
                        }
                    }
                    .padding()
                }
                
                if viewModel.isWrongEmail {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(Color("DarkRed"))
                        Text("The email provided is incorrect.")
                            .foregroundColor(Color("DarkRed"))
                            .font(.body)
                    }
                }
                
                else if viewModel.isWrongPassword {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(Color("DarkRed"))
                        Text("The password provided is incorrect.")
                            .foregroundColor(Color("DarkRed"))
                            .font(.body)
                    }
                }
                
                else if !viewModel.isFilled {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(Color("DarkRed"))
                        Text("All fields must be filled out.")
                            .foregroundColor(Color("DarkRed"))
                            .font(.body)
                    }
                }
                
                // Arica: The Sign In button.
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        viewModel.isFilled = false
                        viewModel.isWrongEmail = false
                        viewModel.isWrongPassword = false
                        return
                    }
                    
                    viewModel.signIn(email: email, password: password)
                    
                }, label: {
                    Text("Sign In")
                        .padding()
                        .foregroundColor(Color("Black"))
                        .font(.title3)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("LightBlueSwitch"))
                        .cornerRadius(40)
                        .overlay( RoundedRectangle(cornerRadius: 40)
                        .stroke(Color("LightBlue"), lineWidth: 2))
                })
                .padding()
                
                Spacer()
            }
        }
        .background(Color("White").ignoresSafeArea())
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
