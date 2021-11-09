//
//  AricaDesignTest.swift
//  Her-Tech-Connect
//
//  Created by Arica Conrad on 11/7/21.
//

// Arica: Please do not delete this file yet. It contains some styling for a TextField that only has an underline beneath it.

import SwiftUI

struct AricaDesignTest: View {
    
    struct underlineTextFieldStyle: TextFieldStyle {
        func _body(configuration: TextField<_Label>) -> some View {
            configuration
                .padding(.vertical, 10)
                .overlay(Rectangle().frame(height: 2).padding(.top, 35))
                    .foregroundColor(Color("DarkBlue"))
                    .padding(10)
        }
    }
    
    @State private var text = ""

        var body: some View {
            
            VStack {
                
                ScrollView {
                    
                    VStack(alignment: .leading) {
                        
                        Text("Name")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                    
                        HStack {
                            Image(systemName: "person.fill")
                            .foregroundColor(Color("DarkBlue"))
                            TextField("Her Tech Connect", text: $text)
                                .textFieldStyle(underlineTextFieldStyle())
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        
                        Text("Email")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                    
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(Color("DarkBlue"))
                            TextField("yourname@hertechconnect.com", text: $text)
                                .textFieldStyle(underlineTextFieldStyle())
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        
                        Text("Password")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                    
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color("DarkBlue"))
                            TextField("*******", text: $text)
                                .textFieldStyle(underlineTextFieldStyle())
                        }
                    }
                    .padding()
                    
                    VStack(alignment: .leading) {
                        
                        Text("Confirm Password")
                            .foregroundColor(Color("Black"))
                            .font(.body)
                    
                        HStack {
                            Image(systemName: "lock.fill")
                                .foregroundColor(Color("DarkBlue"))
                            TextField("*******", text: $text)
                            
                                //.textFieldStyle(underlineTextFieldStyle())
                                        .textFieldStyle(RoundedBorderTextFieldStyle())
                                        //.overlay(RoundedRectangle(cornerRadius: 5).stroke(Color("DarkBlue"), lineWidth: 1))
                            
                                                .border(Color("DarkBlue"), width: 1)
                            
                    
                        }
                    }
                    .padding()
                }
            }
        }
}

struct AricaDesignTest_Previews: PreviewProvider {
    static var previews: some View {
        AricaDesignTest()
    }
}
