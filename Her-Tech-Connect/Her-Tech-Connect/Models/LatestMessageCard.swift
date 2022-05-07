//
//  LatestMessageCard.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 5/5/22.
//

import SwiftUI
import FirebaseDatabase

@available(iOS 15.0, *)
struct LatestMessageCard: View {
    @State var message = [String: Any]()
    @State private var showingSheet = false
    let ref = Database.database().reference()
    var body: some View {
        VStack{
            HStack{
                RoundedImage(urlImage: message["recieverImage"] as! String, imageWidth: 58.0, imageHeight: 58.0)
                    .padding(.trailing, 6)
                VStack(alignment: .leading, spacing: 4.0){
                    HStack{
                        Text(message["recieverName"] as! String).bold()
                            .font(.system(size: 16))
                            .lineLimit(nil)
        //                    .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(calculateTimeStamp(seconds: message["time"] as! Double) )
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing)
                    }
                    Text(message["lastMessage"] as! String)
                        .font(.system(size: 16))
                        .lineLimit(1)
                        .multilineTextAlignment(.leading)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.leading, 16)
            .padding([.top, .bottom] , 20)
        }
        
        .onAppear(perform: {
        })
        .background(RoundedRectangle(cornerRadius: 10).stroke((Color(UIColor.systemGray6)), lineWidth: 2).background((Color.white).cornerRadius(10)).shadow(radius: 8))
        .padding()
        .onTapGesture {
            showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet, onDismiss: {}) {
            NavigationView{
                MessageView(currentUserID: message["currentUserId"] as! String, receiverEmail: message["recieverEmail"] as! String, receiverId: message["recieverId"] as! String)
            }
            
        }
    }
}

@available(iOS 15.0, *)
struct LatestMessageCard_Previews: PreviewProvider {
    static var previews: some View {
        LatestMessageCard()
    }
}
