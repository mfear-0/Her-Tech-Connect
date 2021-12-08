//
//  ShoutOutView.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 12/7/21.
//

import SwiftUI

struct ShoutOutView: View {
    @State private var showingSheet = false
       
   var body: some View {
       ZStack{
           VStack{
               ScrollView(.vertical, showsIndicators: false){
                   if #available(iOS 14.0, *) {
                       LazyVStack(alignment: .leading, spacing: 0){
                           ForEach((1...10), id: \.self){ index in
                               ShoutOutCard()
                           }
                       }
                   } else {
                       // Fallback on earlier versions
                   }
               }
           }
           
           VStack{
               Spacer()
               HStack{
                   Spacer()
                   if #available(iOS 14.0, *) {
                       Image(systemName: "plus")
                           .font(.largeTitle)
                           .frame(width: 60, height: 60)
                           .background(Color.blue)
                           .clipShape(Circle())
                           .foregroundColor(.white)
                           .padding()
                           .shadow(radius: 2)
                           .onTapGesture {
                               showingSheet.toggle()
                           }
                           .sheet(isPresented: $showingSheet, onDismiss: {
                           }) {
                               Text("Add new ShoutOut post")
                           }
                   } else {
                       // Fallback on earlier versions
                   }
               }
           }
       }
   }
}

struct ShoutOutView_Previews: PreviewProvider {
    static var previews: some View {
        ShoutOutView()
    }
}
