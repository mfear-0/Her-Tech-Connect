//
//  HomePage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/23/21.
//

import SwiftUI
import FirebaseAuth

struct HomePage: View {
    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        
        VStack {
            Text("Welcome to Her Tech Connect")
            
            Button(action: {
                viewModel.signOut()
            }, label: {
                Text("LOG OUT")
                    .foregroundColor(Color(.systemTeal))
                    .fontWeight(.bold)
                    .padding(.vertical)
                    .padding(.horizontal, 80)
                    .background(Color.pink)
                    .clipShape(Capsule())
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
            })
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
//        .background(Color(.systemTeal).ignoresSafeArea())
        
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        HomePage()
    }
}
