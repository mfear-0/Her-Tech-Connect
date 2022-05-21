//
//  RegisterPage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/22/21.
//  Modified by Arica Conrad on 11/7/21.
//  Modified by Arica Conrad on 11/14/21.
//  Modified by Arica Conrad on 12/6/21.
//  Modified by Arica Conrad on 12/15/21.
//  Modified by Natalman Nahm on 05/11/22
//  Modified by Natalman Nahm on 05/20/22

import SwiftUI

struct RegisterPage: View {
    
    @State var name = ""
    @State var email = ""
    @State var password = ""
    @State var rePassword = ""
    @State var isPasswordIncorrect = false
    @State var isFilled = true
    @EnvironmentObject var viewModel: AuthViewModel
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        
        VStack {
            
            // Arica: A decorative ombre band across the top that showcases the app's colors.
//            ZStack {
//
//                Rectangle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("LightYellow")]), startPoint: .leading, endPoint: .trailing))
//                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 20)
//            }
            VStack {
                Image("IconHtc")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Rectangle())
                    .cornerRadius(10)
                    .shadow(color: colorScheme == .dark ? Color("Black").opacity(0.8) : Color.gray, radius: 12)
                
                
                Text("Create an Account")
                    .bold()
                    .foregroundColor(Color("DarkBlue"))
                    .font(.system(size: 25))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                    .padding(.bottom, 3.0)
                
                // Arica: Instructional text for the users.
                Text("Welcome! Please fill out all the fields to create a new Her Tech Connect account.")
                    .foregroundColor(Color("Black"))
                    .font(.body)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                
                HStack {
                
                    Image(systemName: "person.fill")
                        .foregroundColor(Color("DarkBlue"))
                    
                    TextField("Full Name", text: $name)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding(.all, 15)
                .background( RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("DarkBlue"), lineWidth: 1).background(Color(.systemGray4).cornerRadius(10)).shadow(color: colorScheme == .dark ? Color("Black").opacity(0.5) : Color.black.opacity(0.5), radius: 8, x: 0, y: 8))
                .padding()
                
                
                HStack {
                    
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color("DarkBlue"))
                    
                    TextField("Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding(.all, 15)
                .background( RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("DarkBlue"), lineWidth: 1).background(Color(.systemGray4).cornerRadius(10)).shadow(color: colorScheme == .dark ? Color("Black").opacity(0.5) : Color.black.opacity(0.5), radius: 8, x: 0, y: 8))
                .padding()
                
                
                HStack {
                    
                    Image(systemName: "lock.fill")
                        .foregroundColor(Color("DarkBlue"))
                    
                    SecureField("Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding(.all, 15)
                .background( RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("DarkBlue"), lineWidth: 1).background(Color(.systemGray4).cornerRadius(10)).shadow(color: colorScheme == .dark ? Color("Black").opacity(0.5) : Color.black.opacity(0.5), radius: 8, x: 0, y: 8))
                .padding()
                
                HStack {
                    
                    Image(systemName: "lock.fill")
                        .foregroundColor(Color("DarkBlue"))
                    
                    SecureField("Confirm your password", text: $rePassword)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding(.all, 15)
                .background( RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("DarkBlue"), lineWidth: 1).background(Color(.systemGray4).cornerRadius(10)).shadow(color: colorScheme == .dark ? Color("Black").opacity(0.5) : Color.black.opacity(0.5), radius: 8, x: 0, y: 8))
                .padding()
                
                // Arica: The following are the field entries to create a new account.
                
                // Arica: The name field.
//                    VStack(alignment: .leading) {
//
//                        Text("Name")
//                            .foregroundColor(Color("Black"))
//                            .font(.body)
//
//                        HStack {
//
//                            Image(systemName: "person.fill")
//                                .foregroundColor(Color("DarkBlue"))
//
//                            TextField("Her Tech Connect", text: $name)
//                                .disableAutocorrection(true)
//                                .autocapitalization(.none)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .overlay( RoundedRectangle(cornerRadius: 6)
//                                .stroke(Color("DarkBlue"), lineWidth: 2))
//                        }
//                    }
//                    .padding()
                
                // Arica: The email field.
//                    VStack(alignment: .leading) {
//
//                        Text("Email")
//                            .foregroundColor(Color("Black"))
//                            .font(.body)
//
//                        HStack {
//
//                            Image(systemName: "envelope.fill")
//                                .foregroundColor(Color("DarkBlue"))
//
//                            TextField("yourname@hertechconnect.com", text: $email)
//                                .disableAutocorrection(true)
//                                .autocapitalization(.none)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .overlay( RoundedRectangle(cornerRadius: 6)
//                                .stroke(Color("DarkBlue"), lineWidth: 2))
//                        }
//                    }
//                    .padding()
                
                // Arica: The password field.
//                    VStack(alignment: .leading) {
//
//                        Text("Password *")
//                            .foregroundColor(Color("Black"))
//                            .font(.body)
//
//                        // Arica: Instructional text notifying users about the necessary length for the password.
//                        Text("* Passwords must be at least 6 characters long.")
//                            .foregroundColor(Color("Black"))
//                            .font(.caption)
//
//                        HStack {
//
//                            Image(systemName: "lock.fill")
//                                .foregroundColor(Color("DarkBlue"))
//
//                            SecureField("Password", text: $password)
//                                .disableAutocorrection(true)
//                                .autocapitalization(.none)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .overlay( RoundedRectangle(cornerRadius: 6)
//                                .stroke(Color("DarkBlue"), lineWidth: 2))
//                        }
//                    }
//                    .padding()
                
                // Arica: The confirm password field.
//                    VStack(alignment: .leading) {
//
//                        Text("Confirm Password")
//                            .foregroundColor(Color("Black"))
//                            .font(.body)
//
//                        HStack {
//
//                            Image(systemName: "lock.fill")
//                                .foregroundColor(Color("DarkBlue"))
//
//                            SecureField("Confirm your password", text: $rePassword)
//                                .disableAutocorrection(true)
//                                .autocapitalization(.none)
//                                .textFieldStyle(RoundedBorderTextFieldStyle())
//                                .overlay( RoundedRectangle(cornerRadius: 6)
//                                .stroke(Color("DarkBlue"), lineWidth: 2))
//                        }
//                    }
//                    .padding()
                 
            }
            
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
                    .stroke(Color("LightBlue"), lineWidth: 2))
            })
            .padding()
            
            Spacer()
        }
//        .background(Color("White").ignoresSafeArea())
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage()
    }
}
