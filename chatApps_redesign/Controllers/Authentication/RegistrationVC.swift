//
//  RegistrationVC.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 27/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit

class RegistrationVC: UIViewController {
    
    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var gabungButton: UIButton!
    @IBOutlet weak var contentView: UIView!
    
    let loadingView = LoadingView()
    let ApiAuthentication = APIAuth()
    
    private func initView() {
        let backButton = UIBarButtonItem()
        backButton.title = "Yuk Login"
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        usernameTF.delegate = self
        passwordTF.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(RegistrationVC.backgroundTap))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)
        
        usernameTF.setUpView()
        passwordTF.setUpView()
        
        gabungButton.roundCorners()
        gabungButton.nonClickingButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
    }
    
    
    @IBAction func gabungButton(_ sender: Any) {
        var data = loadingView.customActivityIndicatory(self.view, startAnimate: true)
        
        data.startAnimating()
        
        guard let username = usernameTF.text else { return }
        guard let password = passwordTF.text else { return }
        
        let response = ApiAuthentication.Registration(username: username, password: password)
        
        if response.code == "HV-00" {
            let alert = loadingView.showAlert(message: "Pendaftaran Berhasil")
            self.present(alert, animated: true, completion: nil)
        } else {
            
            let alert = loadingView.showAlert(message: response.message)
            self.present(alert, animated: true, completion: nil)
        }
        
        data = loadingView.customActivityIndicatory(self.view, startAnimate: false)
        
        data.stopAnimating()
    }
    
    @objc func backgroundTap(_ sender: UITapGestureRecognizer) {
        // go through all of the textfield inside the view, and end editing thus resigning first responder
        // ie. it will trigger a keyboardWillHide notification
        self.view.endEditing(true)
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 6
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}

extension RegistrationVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if reason == .committed {
            textFieldDidChange()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let username = usernameTF.text else { return true }
        guard let password = passwordTF.text else { return true }
        
        if (username != "" && password != "") {
            gabungButton.canClicking()
        }
        
        return true
    }
    
    func textFieldDidChange() {
        guard let username = usernameTF.text, !username.isEmpty, let password = passwordTF.text, !password.isEmpty else {
            gabungButton.nonClickingButton()
            return
        }
        
        gabungButton.canClicking()
    }
}
