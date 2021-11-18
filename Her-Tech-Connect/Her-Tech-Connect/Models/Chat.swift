//
//  Chat.swift
//  Her-Tech-Connect
//
//  Created by Natalman Nahm on 11/14/21.
//

import Foundation
import SwiftUI

class Chat: ObservableObject{
    @Published var data: [Message] = [Message]()
}
