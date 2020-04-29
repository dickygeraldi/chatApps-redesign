//
//  TopicVC.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 29/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit

class AddTopicVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var topicImage: UIImageView!
    @IBOutlet weak var topicName: UITextField!
    @IBOutlet weak var getSegment: UISegmentedControl!
    @IBOutlet weak var contentView: UIView!
    
    var alert = LoadingView()
    
    var dataImage: UIImage = #imageLiteral(resourceName: "addImages")
    var homeCoreData = HomeDataCore()
    
    func initView() {
        topicName.setUpView()
        topicImage.circleImage(anyImage: dataImage)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.backgroundTap))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
        // go through all of the textfield inside the view, and end editing thus resigning first responder
        // ie. it will trigger a keyboardWillHide notification
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 8
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func checkMandatory() -> Bool {
        
        if topicName.text == "" {
            return false
        } else {
            return true
        }
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if checkMandatory() == false {
            let alertDialog = alert.showAlert(message: "Nama topik harus diisi")
            self.present(alertDialog, animated: true, completion: nil)
            
            return false
        }
        
        return true
    }
    
    @IBAction func tambahkanFoto(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        
        image.sourceType = UIImagePickerController.SourceType.photoLibrary
        
        image.allowsEditing = false
        
        self.present(image, animated: true)
    }
    
    func GetSegment() -> String {
        
        var category: String = ""
        
        switch getSegment.selectedSegmentIndex {
        case 0:
            category = TopicList.Tekno.rawValue
            break
        case 1:
            category = TopicList.Desain.rawValue
            break
        case 2:
            category = TopicList.Bisnis.rawValue
            break
        default:
            category = TopicList.Tekno.rawValue
            break
        }
            
        return category
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            dataImage = image
            topicImage.circleImage(anyImage: image)
            
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dateNow = getDate()
        let category = GetSegment()
        
        let destination = segue.destination as! HomeVC
        
        let topic = Topic.init(image: dataImage, headline: topicName.text ?? "", topicLastMessage: "Kamu telah membuat topic", sendingTime: dateNow, category: category, idData: randomString(length: 6))
        
        homeCoreData.storeDataToTopic(topic: topic)
        
        destination.initUI()
    }
}
