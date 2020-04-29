//
//  TopicTableViewCell.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 29/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit

class TopicTableViewCell: UITableViewCell {

    @IBOutlet weak var topicImage: UIImageView!
    @IBOutlet weak var topicHeadline: UILabel!
    @IBOutlet weak var topicDetails: UILabel!
    @IBOutlet weak var timeMessage: UILabel!
    @IBOutlet weak var topicCategory: UILabel!
    
    func setTopic(topic: Topic) {
        topicImage.image = topic.image
        topicHeadline.text = topic.headline
        topicDetails.text = topic.topicLasMessage
        timeMessage.text = topic.sendingTime
        topicCategory.text = topic.category
        
        topicImage.circleImage(anyImage: topic.image)
    }
}
