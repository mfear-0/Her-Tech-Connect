//
//  RegisterPage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/22/21.
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
        VStack{
            Image(systemName: "applelogo")
                .resizable()
                .frame(width: 100, height: 120)
                .foregroundColor(.pink)
            
            ZStack(alignment: .bottom){
                VStack(alignment:.center, spacing: 16){
                    
                    if viewModel.userAlreadyExist {
                        Text("Email already exists")
                            .foregroundColor(.red)
                    }
                    
                     if isPasswordIncorrect {
                        Text("Passwords do not match! Please enter passwords again! ")
                            .foregroundColor(.red)
                    }
                    
                    if !isFilled {
                        Text("Please fill out all info")
                            .foregroundColor(.red)
                    }
                    
                    HStack{
                        Image(systemName: "person.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                            .foregroundColor(.pink)
                        TextField("Name", text: $name)
                            .padding(.leading, 12)
                            .font(.system(size: 20))
                    }
                    .padding(12)
                    .background(Color(.systemGray4))
                    .clipShape(Rectangle())
                    .cornerRadius(35)
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
                }
                .padding()
                .padding(.bottom, 25)
                .padding(.horizontal, 20)
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
                } else {
                    self.isFilled = true
                    self.isPasswordIncorrect = true
                    viewModel.userAlreadyExist = false
                }
                
            }, label: {
                Text("REGISTER")
                    .foregroundColor(Color(.systemTeal))
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 80)
                    .background(Color.pink)
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
            })
        }
        .padding(.bottom, 160)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemTeal).ignoresSafeArea())
    }
}

struct RegisterPage_Previews: PreviewProvider {
    static var previews: some View {
        RegisterPage()
    }
}
