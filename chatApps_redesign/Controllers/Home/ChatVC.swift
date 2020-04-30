//
//  ChatVC.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 29/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var dataChat: UITableView!
    @IBOutlet weak var message: UITextView!
    @IBOutlet weak var sendingMessage: UIButton!
    
    var username: String = ""
    var dataTopic: String = ""
    var topicId: String = ""
    
    var chatMessage: [ChatModels] = []
    var homeCore = HomeDataCore()
    
    private func initView() {
        dataChat.delegate = self
        dataChat.dataSource = self
        
        message.delegate = self
        message.textColor = UIColor.lightGray
        message.text = "Kirim Pesan?"
        message.clipsToBounds = true
        message.layer.borderWidth = 1.0
        message.layer.borderColor = UIColor.gray.cgColor
        message.textContainerInset = UIEdgeInsets(top: 10, left: 10, bottom: 5, right: 10)
        message.textColor = UIColor.lightGray
        
        dataChat.register(ChatMessageCell.self, forCellReuseIdentifier: "dataChat")
        dataChat.separatorStyle = .none
        
        navigationItem.title = dataTopic
        
        chatMessage = checkingMessage()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ChatVC.backgroundTap))
        self.dataChat.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
        // go through all of the textfield inside the view, and end editing thus resigning first responder
        // ie. it will trigger a keyboardWillHide notification
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= (40 + keyboardSize.height)
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    func checkingMessage() -> [ChatModels] {
        let temp = homeCore.checkingMessage(topicId: topicId)
        
        return temp
    }
    
    @IBAction func sendingMessage(_ sender: Any) {
        let data = message.text
        
        if data == "" {
            print("Pesan harus diisi")
        } else {
            let messageNya = ChatModels.init(message: data!, isIncoming: 0, sender: username, time: getDate())
            
            homeCore.storeDataMessage(messageData: messageNya, topicId: topicId)
//            updateCoreData(message: data!, time: messageNya.time)
            
            chatMessage.append(messageNya)
            let indexPath = IndexPath(row: chatMessage.count - 1, section: 0)
            
            dataChat.beginUpdates()
            dataChat.insertRows(at: [indexPath], with: .bottom)
            dataChat.endUpdates()
            dataChat.scrollToRow(at: indexPath, at: .bottom, animated: true)
            
            message.delegate = self
            message.textColor = UIColor.lightGray
            message.text = "Kirim Pesan?"
            textViewDidEndEditing(message)
            textViewDidBeginEditing(message)
            
            homeCore.updateTopic(message: data!, Sending: getDate(), idTopic: topicId)
        }
    }
}

extension ChatVC: UITableViewDataSource, UITableViewDelegate, UITextViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dataChat", for: indexPath) as! ChatMessageCell
        
        let messaging = chatMessage[indexPath.row]
        cell.chatMessage = messaging
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Kirim Pesan?"
            textView.textColor = UIColor.lightGray
        }
    }
}
