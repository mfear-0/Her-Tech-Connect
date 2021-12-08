//
//  ShoutOutCard.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 12/7/21.
//

import SwiftUI

struct ShoutOutCard: View {
    @State var imageUrl: String = "https://firebasestorage.googleapis.com/v0/b/her-tech-connect.appspot.com/o/profileImage%2F5cROPaoHQcPmGZTwloETHBTLUbs1.jpg?alt=media&token=94f00fdd-0042-401e-b7be-d1662c1ccc00"
    var publisher: String = "Reuters"
    @State var timeCreated: Double = 1635644084.37
    @State var content: String = "I just got a promotion at my Job!😍😍 I am Really excited!"
    @State var voteCount: Int = 100
    @State var userName: String = "Anic Lopez"
    
    var body: some View {
        VStack{
            
            HStack{
                RoundedImage(urlImage: imageUrl, imageWidth: 58.0, imageHeight: 58.0)
                    .padding(.vertical, 5)
                    .padding(.leading, 5)
                VStack(alignment: .leading, spacing: 2.0){
                    HStack{
                        Text(userName).bold()
                            .font(.system(size: 16))
                            .lineLimit(nil)

                        Text(calculateTimeStamp(seconds: timeCreated))
                            .font(.system(size: 12))
                            .foregroundColor(.red)
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.trailing)
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
            }
            
            Text(self.content)
                .bold()
                .font(.system(size: 18))
                .lineLimit(4)
                .padding(.horizontal)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
            
            HStack {
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Text("Read More")
                        .foregroundColor(Color.blue)
                })
                    .padding(.leading, 5)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    HStack(spacing: 0){
                        Image(systemName: "heart")
                            .foregroundColor(Color.blue)
                            .padding(.trailing, 2)
                        Text("\(self.voteCount)")
                            .foregroundColor(Color.blue)
                    }
                    
                })
                    .padding(.trailing, 5)
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .trailing)
            }
            .padding(.horizontal, 5.0)
            .padding(.vertical)
            .frame(alignment: .bottom)
        }
        .background(RoundedRectangle(cornerRadius: 10).stroke((Color(UIColor.systemGray6)), lineWidth: 2).background((Color.white).cornerRadius(10)).shadow(radius: 8))
        .padding()
        
        
    }
}

struct ShoutOutCard_Previews: PreviewProvider {
    static var previews: some View {
        ShoutOutCard()
    }
}
