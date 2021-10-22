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
    var body: some View {
        VStack{
            Image(systemName: "person.fill")
                .resizable()
                .frame(width: 100, height: 100)
            
            ZStack(alignment: .bottom){
                VStack{
                    HStack {
                        Text("Login")
                            .foregroundColor(.pink)
                            .font(.title)
                            .fontWeight(.bold)
                        
                        Spacer(minLength: 0)
                    }
                    .padding(.top, 40)
                    
                    VStack{
                        HStack(spacing: 15){
                            Image(systemName: "envelope.fill")
                                .foregroundColor(.pink)
                            TextField("Email Address", text: $email)
                        }
                        
                        Divider().background(Color.pink.opacity(0.5))
                    }
                    .padding()
                    .padding(.top, 40)
                    
                    VStack{
                        HStack(spacing: 15){
                            Image(systemName: "eye.slash.fill")
                                .foregroundColor(.pink)
                            SecureField("Password", text: $password)
                        }
                        
                        Divider().background(Color.pink.opacity(1))
                    }
                    .padding()
                    .padding(.top, 30)
                    
                    HStack {
                        Spacer(minLength: 0)
                        
                        Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                            Text("Forgot Password?")
                                .foregroundColor(Color.pink.opacity(0.6))
                        })
                    }
                }
                .padding()
                .padding(.bottom, 65)
                .background(Color(.systemGray4))
                .clipShape(Rectangle())
                .cornerRadius(35)
                .padding(.horizontal, 20)
            }
            
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                Text("LOGIN")
                    .foregroundColor(Color(.systemTeal))
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 80)
                    .background(Color.pink)
                    .clipShape(Capsule())
                    .shadow(color: Color.pink.opacity(0.2), radius: 5, x: 0, y: 5)
            })
            .offset(y: -30)
            
        }
        .padding(.bottom, 150)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemTeal).ignoresSafeArea())
        
    }
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
