//
//  SignInOrCreateAccountScreen.swift
//  Her-Tech-Connect
//
//  Created by Arica Conrad on 11/14/21.
//  Modified by Arica Conrad on 12/6/21.
//

import SwiftUI

struct SignInOrCreateAccountScreen: View {
    
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
                    Text("Welcome to Her Tech Connect!")
                        .foregroundColor(Color("DarkBlue"))
                        .font(.title2)
                        .padding()
                    
                    // Arica: Instructional text for the users.
                    Text("If you are a new user, tap the \"Create Account\" button to create a new Her Tech Connect account. If you are a returning user, tap the \"Sign In\" button to sign in and continue to the rest of the app.")
                        .foregroundColor(Color("Black"))
                        .font(.body)
                        .padding()
                    
                    // Arica: The Sign In button.
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
                                .stroke(Color("LightBlue"), lineWidth: 4))
                    })
                    .padding()
                    
                    // Arica: The Create Account button.
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
                    .padding()
                }
            }
        }
        .background(Color("White").ignoresSafeArea())
    }
}

struct SignInOrCreateAccountScreen_Previews: PreviewProvider {
    static var previews: some View {
        SignInOrCreateAccountScreen()
    }
}
