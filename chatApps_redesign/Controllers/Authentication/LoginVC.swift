//
//  ViewController.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 27/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var usernameTF: UITextField!
    @IBOutlet weak var passwordVC: UITextField!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var loginButton: UIButton!
    
    let loadingView = LoadingView()
    let ApiAuthentication = APIAuth()
    let CoreData = AuthDataCore()
    
    private func initUI() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginVC.backgroundTap))
        self.contentView.addGestureRecognizer(tapGestureRecognizer)
        
        usernameTF.delegate = self
        passwordVC.delegate = self
        
        usernameTF.setUpView()
        passwordVC.setUpView()
        
        loginButton.roundCorners()
        loginButton.nonClickingButton()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initUI()
    }
    
    @IBAction func loginTap(_ sender: Any) {
        var data = loadingView.customActivityIndicatory(self.view, startAnimate: true)
        var dataUsers: UserAuth
        
        data.startAnimating()
        
        guard let username = usernameTF.text else { return }
        guard let password = passwordVC.text else { return }
        
        let response = ApiAuthentication.LoginNow(username: username, password: password)
        if (response.code == "00") {
            
            dataUsers = UserAuth.init(phoneNumber: "", token: response.token, username: username)
            let responseCore = CoreData.storeData(entity: "Users", userAuth: dataUsers)
            
            if (responseCore == "00") {
                
            } else {
                let alert = loadingView.showAlert(message: "Gagal mengambil data, silahkan coba kembali")
                self.present(alert, animated: true, completion: nil)
            }
            
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

extension LoginVC: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        if reason == .committed {
            textFieldDidChange()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let username = usernameTF.text else { return true }
        guard let password = passwordVC.text else { return true }
        
        if (username != "" && password != "") {
            loginButton.canClicking()
        }
        
        return true
    }
    
    func textFieldDidChange() {
        guard let username = usernameTF.text, !username.isEmpty, let password = passwordVC.text, !password.isEmpty else {
            loginButton.nonClickingButton()
            return
        }
        
        loginButton.canClicking()
    }
}
