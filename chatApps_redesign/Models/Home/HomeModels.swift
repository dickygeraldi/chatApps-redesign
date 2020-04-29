//
//  HomeModels.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 29/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import Foundation
import UIKit

// Topik enumeration
enum TopicList: String {
    case Tekno
    case Desain
    case Bisnis
}

// Chatting Models
struct ChatModels {
    let message: String
    let isIncoming: Int
    let sender: String
    let time: String
    
    init(message: String, isIncoming: Int, sender: String, time: String) {
        self.message = message
        self.time = time
        self.isIncoming = isIncoming
        self.sender = sender
    }
}

// TopicModels
class Topic {
    var image: UIImage
    var headline: String
    var topicLasMessage: String
    var sendingTime: String
    var category: String
    var idData: String
    
    init(image: UIImage, headline: String, topicLastMessage: String, sendingTime: String, category: String, idData: String) {
        self.headline = headline
        self.image = image
        self.sendingTime = sendingTime
        self.topicLasMessage = topicLastMessage
        self.category = category
        self.idData = idData
    }
}
