//
//  SettingsView.swift
//  Her-Tech-Connect
//
//  Created by Student Account on 11/17/21.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    var body: some View {
        
        VStack {
        NavigationView {
            Form {
                Section(header: Text("Dark Mode")) {
                    Toggle(isOn: $isDarkMode,
                           label: {
                        Text("Dark Mode")
                    })
                }
            }
            .navigationTitle("Settings")
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemTeal).ignoresSafeArea())
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
