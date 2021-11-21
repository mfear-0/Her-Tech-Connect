//
//  MessageBubble.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/14/21.
//

import SwiftUI
import FirebaseDatabase

struct MessageBubble: View {
    var isSent = false
    @State var message: Message
    @State var imageUrl = ""
    @State var recieverId = ""
    let ref = Database.database().reference()

    var body: some View {
         
        HStack {
            if isSent {
                Spacer()
                
                VStack {
                    Text(message.message)
                        .padding(15)
                        .background(RoundedRectangle(cornerRadius: 25).stroke((Color.white.opacity(0)), lineWidth: 1).background((Color.gray).cornerRadius(25, corners: [.topLeft, .topRight, .bottomLeft])).shadow(radius: 15))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    Text(calculateTimeStamp(seconds: message.timeCreated))
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 18)
            } else {
                HStack {
                    RoundedImage(urlImage: self.imageUrl, imageWidth: 50.0, imageHeight: 50.0)
                        .frame(maxHeight: .infinity, alignment: .top)
                        .padding(.trailing, 2)
                    
                    VStack{
                        Text(message.message)
                            .padding(15)
//                            .background(Color.blue)
                            .background(RoundedRectangle(cornerRadius: 25).stroke((Color.white.opacity(0)), lineWidth: 1).background((Color.blue).cornerRadius(25, corners: [.bottomRight, .topRight, .bottomLeft])).shadow(radius: 15))
                        
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(calculateTimeStamp(seconds: message.timeCreated))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 15)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    
                }
                .padding(.horizontal, 10)
                .padding(.bottom, 18)
                Spacer()
            }
        }
        .onAppear(perform: {
            if !isSent {
                ref.child("Users").child(recieverId).observeSingleEvent(of: .value, with: { user in
                    
                    DispatchQueue.main.async{
                        let userDict = user.value as! [String: Any]
                        self.imageUrl = userDict["image"] as! String
                    }
                })
            }
        })
    }
    
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
    
    func calculateTimeStamp(seconds: Double) -> String {
            
            let currentSeconds = Date().timeIntervalSince1970
            let difference = currentSeconds - seconds
            
            var timeStamp = ""
            if difference < 60 {
                timeStamp = "Now"
            } else if difference < 3600 {
                timeStamp = String(Int(difference / 60)) + "m ago"
            } else if difference < 86400 {
                timeStamp = String(Int(difference / 3600)) + "h ago"
            } else if difference < 604800 {
                let date = Date(timeIntervalSince1970: seconds)
                let formatter = DateFormatter()
                formatter.dateFormat = "h:mm a"
                formatter.timeZone = .current
                formatter.amSymbol = "AM"
                formatter.pmSymbol = "PM"
                let weekDay = getDayOfWeek(seconds: seconds)
                timeStamp = weekDay + " " + formatter.string(from: date)
            } else if difference < 31449600 {
                let date = Date(timeIntervalSince1970: seconds)
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d h:mm a"
                formatter.timeZone = .current
                formatter.amSymbol = "AM"
                formatter.pmSymbol = "PM"
                timeStamp = formatter.string(from: date)
            } else {
                let date = Date(timeIntervalSince1970: seconds)
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d YYYY h:mm a"
                formatter.timeZone = .current
                formatter.amSymbol = "AM"
                formatter.pmSymbol = "PM"
                timeStamp = formatter.string(from: date)
            }
            
            return timeStamp
        }
        
        private func getDayOfWeek(seconds: Double) -> String {
            let weekDays = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            let date = Date(timeIntervalSince1970: seconds)
            let myCalendar = Calendar(identifier: .gregorian)
            let weekDay = myCalendar.component(.weekday, from: date)
            
            return weekDays[weekDay - 1]
        }
}

struct MessageBubble_Previews: PreviewProvider {
    static var previews: some View {
        MessageBubble(isSent: false, message: Message(senderId: "0118E49C-EADB-4518-95CD-8A37F94080AA", senderName: "Jane Doe", message: "How are You?!🤓🧐😎", type: "text", timeCreated: 1630832248.292776), recieverId: "0118E49C-EADB-4518-95CD-8A37F94080AA")
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
