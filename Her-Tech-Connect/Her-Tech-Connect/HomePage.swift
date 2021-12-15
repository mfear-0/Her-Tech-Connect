//
//  HomePage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/23/21.
//  Modified by Arica Conrad on 12/15/21.
//

import SwiftUI
import FirebaseAuth

struct HomePage: View {
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
                    Text("Welcome to Her Tech Connect!")
                        .foregroundColor(Color("DarkBlue"))
                        .font(.title2)
                        .padding()
                    
                    // Arica: Instructional text for the users.
                    Text("Here are the highlights of what happened while you were away:")
                        .foregroundColor(Color("Black"))
                        .font(.body)
                        .padding()
                    
                    // Arica: The temporary location of the log out button. Please move to the bottom of the More tab.
                    Button(action: {
                        viewModel.signOut()
                    }, label: {
                        Text("Log Out")
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
        }
        .background(Color("White").ignoresSafeArea())
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
