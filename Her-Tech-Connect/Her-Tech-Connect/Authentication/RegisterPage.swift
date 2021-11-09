//
//  RegisterPage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/22/21.
//  Modified by Arica Conrad on 11/7/21.
//

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
            
            // Arica: A decorative band across the top.
            ZStack {
                
                Rectangle()
                    .fill(LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("LightYellow")]), startPoint: .leading, endPoint: .trailing))
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 20)
            }
            
            Spacer()
            
            /*
            // Arica: The title text.
            Text("Create an Account")
                .foregroundColor(Color("DarkBlue"))
                .font(.title2)
                .padding()
             */
            
            //ZStack(alignment: .bottom) {
            
            ScrollView {
                
                VStack(/*alignment:.center, spacing: 16*/) {
                    
                    if viewModel.userAlreadyExist {
                        Text("This email has already been used.")
                            .foregroundColor(.red)
                    }
                    
                     if isPasswordIncorrect {
                        Text("These passwords do not match.")
                            .foregroundColor(.red)
                    }
                    
                    if !isFilled {
                        Text("Please fill out all fields.")
                            .foregroundColor(.red)
                    }
                    
                    // Arica: The title text.
                    Text("Create an Account")
                        .foregroundColor(Color("DarkBlue"))
                        .font(.title2)
                        .padding()
                    
                    // Arica: The field entries.
                    VStack(alignment: .leading) {
                        
                        Text("Name")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                        
                        HStack {
                            
                            Image(systemName: "person.fill")
                                .foregroundColor(Color("DarkBlue"))
                            
                            TextField("Her Tech Connect", text: $name)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color("DarkBlue"), width: 1)
                        }
                        /*
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.pink)
                        TextField("Her Tech Connect", text: $name)
                            .padding(.leading, 12)
                            .font(.system(size: 20))
                         */
                    }
                    .padding()
                    /*
                    .padding(12)
                    .background(Color(.systemGray4))
                    .clipShape(Rectangle())
                    .cornerRadius(35)
                    .padding(.top, 25)
                     */
                    
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
                                .border(Color("DarkBlue"), width: 1)
                        }
                        /*
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.pink)
                        TextField("Her Tech Connect", text: $name)
                            .padding(.leading, 12)
                            .font(.system(size: 20))
                         */
                    }
                    .padding()
                    /*
                    .padding(12)
                    .background(Color(.systemGray4))
                    .clipShape(Rectangle())
                    .cornerRadius(35)
                    .padding(.top, 25)
                     */
                    
                    /*
                    HStack{
                        Image(systemName: "envelope.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.pink)
                        TextField("Email", text: $email)
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
                     */
                    
                    // My version
                    
                    VStack(alignment: .leading) {
                        
                        Text("Password")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                        
                        HStack {
                            
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color("DarkBlue"))
                            
                            SecureField("Password", text: $password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color("DarkBlue"), width: 1)
                        }
                    }
                    .padding()
                    
                    
                    // Natalman's version
                    /*
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
                     */
                     
                    // My version
                    
                    VStack(alignment: .leading) {
                        
                        Text("Confirm Password")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                        
                        HStack {
                            
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color("DarkBlue"))
                            
                            SecureField("Confirm your password", text: $rePassword)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .border(Color("DarkBlue"), width: 1)
                        }
                    }
                    .padding()
                     
                    
                    // Natalman's version
                    /*
                    HStack{
                        Image(systemName: "lock.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.pink)
                        SecureField("Re-Enter Password", text: $rePassword)
                            .padding(.leading, 12)
                            .font(.system(size: 20))
                    }
                    .padding(12)
                    .background(Color(.systemGray4))
                    .clipShape(Rectangle())
                    .cornerRadius(35)
                    .padding(.top, 25)
                     */
                     
                }
                .padding()
                /*
                .padding(.bottom, 25)
                .padding(.horizontal, 20)
                 */
                
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
                        //.fontWeight(.bold)
                        //.padding(.vertical)
                        //.padding(.horizontal, 80)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("LightBlue"))
                        //.clipShape(Capsule())
                        .cornerRadius(40)
                        //.shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                })
                .padding()
                 
                
                Spacer()
            }
        }
        //.padding(.bottom, 160)
        //.frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color("White").ignoresSafeArea())
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage()
    }
}
