//
//  ChatMessageCell.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 29/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit

class ChatMessageCell: UITableViewCell {

    let messageLabel = UILabel()
    let whoChatLabel = UILabel()
    let bubbleBackgroundView = UIView()
    let decor = UIView()
    let timeChat = UILabel()
    
    var leadingConstraint: NSLayoutConstraint!
    var trailingConstraint: NSLayoutConstraint!
    var leadingConstraintSender: NSLayoutConstraint!
    var trailingConstraintSender: NSLayoutConstraint!
    var leadingConstraintTime: NSLayoutConstraint!
    var trailingConstraintTime: NSLayoutConstraint!
    
    var chatMessage: ChatModels! {
        didSet {
            bubbleBackgroundView.backgroundColor = chatMessage.isIncoming == 1  ? #colorLiteral(red: 0.8470588235, green: 0.8470588235, blue: 0.8470588235, alpha: 1) : #colorLiteral(red: 0.862745098, green: 0.7568627451, blue: 0.7568627451, alpha: 1)
            messageLabel.text = chatMessage.message
            whoChatLabel.text = chatMessage.sender
            timeChat.text = chatMessage.time
            
            if chatMessage.isIncoming == 1 {
                leadingConstraint.isActive = true
                trailingConstraint.isActive = false
                leadingConstraintSender.isActive = true
                trailingConstraintSender.isActive = false
                leadingConstraintTime.isActive = true
                trailingConstraintTime.isActive = false
            } else {
                leadingConstraint.isActive = false
                trailingConstraint.isActive = true
                leadingConstraintSender.isActive = false
                trailingConstraintSender.isActive = true
                leadingConstraintTime.isActive = false
                trailingConstraintTime.isActive = true
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        bubbleBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        bubbleBackgroundView.layer.cornerRadius = 12
        
        decor.translatesAutoresizingMaskIntoConstraints = false
        decor.sizeThatFits(CGSize.init(width: 10, height: 10))
        decor.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        whoChatLabel.translatesAutoresizingMaskIntoConstraints = false
        whoChatLabel.numberOfLines = 0
        whoChatLabel.textColor = .black
        whoChatLabel.font = whoChatLabel.font.withSize(11)
        whoChatLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        
        timeChat.translatesAutoresizingMaskIntoConstraints = false
        timeChat.numberOfLines = 0
        timeChat.textColor = .black
        timeChat.font = whoChatLabel.font.withSize(11)
        timeChat.font = UIFont.systemFont(ofSize: 11, weight: .regular)

        addSubview(timeChat)
        addSubview(decor)
        addSubview(whoChatLabel)
        addSubview(bubbleBackgroundView)
        addSubview(messageLabel)
        
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.numberOfLines = 0
        messageLabel.font = UIFont.systemFont(ofSize: 11, weight: .regular)
        
        let constraints = [
        messageLabel.topAnchor.constraint(equalTo: topAnchor, constant: 32),
        messageLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
        messageLabel.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
        
        bubbleBackgroundView.topAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -16),
        bubbleBackgroundView.leadingAnchor.constraint(equalTo: messageLabel.leadingAnchor, constant: -16),
        bubbleBackgroundView.bottomAnchor.constraint(equalTo: messageLabel.bottomAnchor, constant: 16),
        bubbleBackgroundView.trailingAnchor.constraint(equalTo: messageLabel.trailingAnchor, constant: 16),
        
        whoChatLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
        timeChat.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
        decor.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        leadingConstraint = messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32)
        trailingConstraint = messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -32)
        leadingConstraintSender = whoChatLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        trailingConstraintSender = whoChatLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        leadingConstraintTime = timeChat.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        trailingConstraintTime = timeChat.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
