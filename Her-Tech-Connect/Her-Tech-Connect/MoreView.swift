//
//  MoreView.swift
//  Her-Tech-Connect
//
//  Created by Hans Mandt on 11/12/21.
//

import SwiftUI

struct MoreView: View {
//    @EnvironmentObject var viewModel: AuthViewModel
    var body: some View {
        
        VStack {
            NavigationView {
                Form {
                    NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                    Text("Settings")
                
                    }
//            .navigationTitle("Settings")
//            .navigationBarTitleDisplayMode(.inline)
                }
            }
        
        
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemTeal).ignoresSafeArea())
    }
}

struct MoreView_Previews: PreviewProvider {
    static var previews: some View {
        MoreView()
    }
}
