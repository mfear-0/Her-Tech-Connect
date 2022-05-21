//
//  ResetPasswordPage.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 10/26/21.
//  Modified by Arica Conrad on 11/14/21.
//  Modified by Arica Conrad on 12/6/21.
//  Modified by Natalman Nahm on 05/11/22

import SwiftUI

struct ResetPasswordPage: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.presentationMode) var presentationMode
    @State var email = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        
        VStack {
            
            // Arica: A decorative ombre band across the top that showcases the app's colors.
//            ZStack {
//
//                Rectangle()
//                    .fill(LinearGradient(gradient: Gradient(colors: [Color("LightBlue"), Color("LightYellow")]), startPoint: .leading, endPoint: .trailing))
//                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 20)
//            }
//
//            Spacer()
            VStack {
                
                Image("IconHtc")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .clipShape(Rectangle())
                    .cornerRadius(10)
                    .shadow(color: colorScheme == .dark ? Color("Black").opacity(0.8) : Color.gray, radius: 12)
                
                Text("Reset Password")
                    .bold()
                    .foregroundColor(Color("DarkBlue"))
                    .font(.system(size: 25))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.horizontal, .top])
                    .padding(.bottom, 3.0)
                
                // Arica: Instructional text for the users.
                Text("Please enter your email address. An email will be sent to this address with instructions on how to reset your password.")
                    .foregroundColor(Color("Black"))
                    .font(.body)
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                HStack {
                    
                    Image(systemName: "envelope.fill")
                        .foregroundColor(Color("DarkBlue"))
                    
                    TextField("Your Email", text: $email)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                .padding(.all, 15)
                .background( RoundedRectangle(cornerRadius: 10)
                                .stroke(Color("DarkBlue"), lineWidth: 1).background(Color(.systemGray4).cornerRadius(10)).shadow(color: colorScheme == .dark ? Color("Black").opacity(0.5) : Color.black.opacity(0.5), radius: 8, x: 0, y: 8))
                .padding()
                
//                VStack(alignment: .leading) {
//
//                    Text("Email")
//                        .foregroundColor(Color("Black"))
//                        .font(.body)
//
//                    HStack {
//
//                        Image(systemName: "envelope.fill")
//                            .foregroundColor(Color("DarkBlue"))
//
//                        TextField("yourname@hertechconnect.com", text: $email)
//                            .disableAutocorrection(true)
//                            .autocapitalization(.none)
//                            .textFieldStyle(RoundedBorderTextFieldStyle())
//                            .overlay( RoundedRectangle(cornerRadius: 6)
//                            .stroke(Color("DarkBlue"), lineWidth: 2))
//                    }
//                }
//                .padding()
                
                // Arica: The Submit Email button.
                Button(action: {
                    viewModel.resetPassword(email: email)
                    presentationMode.wrappedValue.dismiss()
                }, label: {
                    Text("Submit")
                        .padding()
                        .foregroundColor(Color("Black"))
                        .font(.title3)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .background(Color("LightBlueSwitch"))
                        .cornerRadius(40)
                        .overlay( RoundedRectangle(cornerRadius: 40)
                        .stroke(Color("LightBlue"), lineWidth: 2))
                })
                .padding()
            }
            .padding(.top, 100)
            
            Spacer()
        }
//        .background(Color("White").ignoresSafeArea())
    }
}

struct ResetPasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordPage()
    }
}
