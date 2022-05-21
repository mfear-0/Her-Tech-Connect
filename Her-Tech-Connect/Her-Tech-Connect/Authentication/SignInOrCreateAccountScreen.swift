//
//  SignInOrCreateAccountScreen.swift
//  Her-Tech-Connect
//
//  Created by Arica Conrad on 11/14/21.
//  Modified by Arica Conrad on 12/6/21.
//  MOdified by Natalman Nahm on 05/19/2022

import SwiftUI

struct SignInOrCreateAccountScreen: View {
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
                
                Text("Welcome to Her Tech Connect!")
                    .bold()
                    .foregroundColor(Color("DarkBlue"))
                    .font(.system(size: 25))
                    .padding([.horizontal, .top])
                    .padding(.bottom, 5.0)
                
                Text("Sign in or create an account if you are a new user.")
                    .foregroundColor(Color("Black"))
                    .font(.body)
                    .padding(.horizontal)
                
                // Arica: Instructional text for the users.
//                    Text("If you are a new user, tap the \"Create Account\" button to create a new Her Tech Connect account. If you are a returning user, tap the \"Sign In\" button to sign in and continue to the rest of the app.")
//                        .foregroundColor(Color("Black"))
//                        .font(.body)
//                        .padding()
                
                NavigationLink(
                    destination: LoginPage(),
                    label: {
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
                .padding([.horizontal, .top])
                .padding(.bottom, 2.0)
                
                HStack{
                    Rectangle()
                        .fill(Color("LightBlueSwitch"))
                        .frame(maxWidth: .infinity, maxHeight: 2.0)
                        .padding(.leading, 15)
                    Text("or")
                        .font(.system(size: 18))
                        .foregroundColor(Color("DarkBlue"))
                    Rectangle()
                        .fill(Color("LightBlueSwitch"))
                        .frame(maxWidth: .infinity, maxHeight: 2.0)
                        .padding(.trailing, 15)
                }
                .padding(.horizontal)
                .padding(.vertical, 3)
                
                NavigationLink(
                    destination: RegisterPage(),
                    label: {
                        Text("Create Account")
                            .padding()
                            .foregroundColor(Color("Black"))
                            .font(.title3)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .background(Color("VeryLightBlue"))
                            .cornerRadius(40)
                            .overlay( RoundedRectangle(cornerRadius: 40)
                            .stroke(Color("LightBlueSwitch"), lineWidth: 4))
                })
                .padding([.horizontal, .bottom])
                .padding(.top, 2.0)
                
                Spacer()
            }
        }
//        .background(Color("White").ignoresSafeArea())
    }
}

struct SignInOrCreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInOrCreateAccountScreen()
    }
}
