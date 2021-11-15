//
//  ContentView.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/20/21.
//  Modified by Arica Conrad on 11/7/21.
//  Modified by Arica Conrad on 11/14/21.
//

import SwiftUI
import Firebase
struct ContentView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                TabTest()
            } else {
                SignInOrCreateAccountScreen()
            }
        }
        .onAppear(perform: {
            viewModel.signedIn = viewModel.isSignedIn
        })
        // Arica: This changes the color of the "Back" button across the app.
        .accentColor(Color("DarkBlue"))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
