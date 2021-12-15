//
//  RegisterPage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/22/21.
//  Modified by Arica Conrad on 11/7/21.
//  Modified by Arica Conrad on 11/14/21.
//  Modified by Arica Conrad on 12/6/21.
//  Modified by Arica Conrad on 12/15/21.
//

// TODO: The password field lengths must be checked, as it is currently an error that is not shown to the users. If the password length is less than 6 characters, text should be displayed to the user saying something like, "Passwords must be at least 6 characters long." - Arica

import SwiftUI

struct RegisterPage: View {
    
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var rePassword = ""
    @State var isPasswordIncorrect = false
    @State var isFilled = true
    @EnvironmentObject var viewModel: AuthViewModel
    
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
                    Text("Create an Account")
                        .foregroundColor(Color("DarkBlue"))
                        .font(.title2)
                        .padding()
                    
                    // Arica: Instructional text for the users.
                    Text("Welcome! Please fill out all the fields to create a new Her Tech Connect account.")
                        .foregroundColor(Color("Black"))
                        .font(.body)
                        .padding()
                    
                    // Arica: The following are the field entries to create a new account.
                    
                    // Arica: The name field.
                    VStack(alignment: .leading) {
                        
                        Text("Name")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                        
                        HStack {
                            
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("DarkBlue"))
                            
                            TextField("Her Tech Connect", text: $name)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay( RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("DarkBlue"), lineWidth: 2))
                        }
                    }
                    .padding()
                    
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
                        
                        Text("Password *")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                        
                        // Arica: Instructional text notifying users about the necessary length for the password.
                        Text("* Passwords must be at least 6 characters long.")
                            .foregroundColor(Color("Black"))
                            .font(.caption)
                        
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
                    }
                    .padding()
                    
                    // Arica: The confirm password field.
                    VStack(alignment: .leading) {
                        
                        Text("Confirm Password")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                        
                        HStack {
                            
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color("DarkBlue"))
                            
                            SecureField("Confirm your password", text: $rePassword)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .overlay( RoundedRectangle(cornerRadius: 6)
                                .stroke(Color("DarkBlue"), lineWidth: 2))
                        }
                    }
                    .padding()
                     
                }
                .padding()
                
                if viewModel.userAlreadyExist {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(Color("DarkRed"))
                        Text("This email has already been used.")
                            .foregroundColor(Color("DarkRed"))
                            .font(.body)
                    }
                }
                
                 if isPasswordIncorrect {
                     HStack {
                         Image(systemName: "exclamationmark.triangle")
                             .foregroundColor(Color("DarkRed"))
                         Text("The passwords must match each other.")
                              .foregroundColor(Color("DarkRed"))
                              .font(.body)
                     }
                }
                
                if !isFilled {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(Color("DarkRed"))
                        Text("All fields must be filled out.")
                            .foregroundColor(Color("DarkRed"))
                            .font(.body)
                    }
                }
                
                // Arica: The Create Account button.
                Button(action: {
                    guard !name.isEmpty, !email.isEmpty, !password.isEmpty, !rePassword.isEmpty else {
                        self.isFilled = false
                        self.isPasswordIncorrect = false
                        viewModel.userAlreadyExist = false
                        return
                    }
                    
                    if password == rePassword {
                        
                        viewModel.signUp(email: email, password: password)
                        UserHandler.addUser(name: name, email: email, image: "https://cdn.iconscout.com/icon/free/png-256/account-avatar-profile-human-man-user-30448.png")
                    } else {
                        self.isFilled = true
                        self.isPasswordIncorrect = true
                        viewModel.userAlreadyExist = false
                    }
                    
                }, label: {
                    Text("Create Account")
                        .padding()
                        .foregroundColor(Color("Black"))
                        .font(.title3)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("LightBlueSwitch"))
                        .cornerRadius(40)
                        .overlay( RoundedRectangle(cornerRadius: 40)
                        .stroke(Color("LightBlue"), lineWidth: 4))
                })
                .padding()
                
                Spacer()
            }
        }
        .background(Color("White").ignoresSafeArea())
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage()
    }
}
