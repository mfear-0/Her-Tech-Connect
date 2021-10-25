//
//  ContentView.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/20/21.
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
                LoginPage()
            }
        }
        .onAppear(perform: {
            viewModel.signedIn = viewModel.isSignedIn
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
