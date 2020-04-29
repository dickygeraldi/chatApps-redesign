//
//  GlobalViewVariable.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 27/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setUpView() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: self.frame.height))

        self.leftView = paddingView
        self.leftViewMode = .always
        
        self.layer.borderColor = #colorLiteral(red: 0.6571614146, green: 0.6571771502, blue: 0.6571686864, alpha: 1)
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 16
    }
}

extension UIButton {
    func roundCorners(){
        layer.cornerRadius = 16
        layer.masksToBounds = true
    }
    
    func nonClickingButton() {
        self.backgroundColor = #colorLiteral(red: 0.07450980392, green: 0.7490196078, blue: 0.9450980392, alpha: 0.786922089)
        self.isEnabled = false
        self.setTitleColor(#colorLiteral(red: 0.832910176, green: 1, blue: 1, alpha: 1), for: .normal)
    }
    
    func canClicking() {
        self.backgroundColor = #colorLiteral(red: 0, green: 0.7628183961, blue: 0.9661516547, alpha: 1)
        self.isEnabled = true
        self.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
    }
}

extension UIImageView {
    
  public func circleImage(anyImage: UIImage) {

    self.contentMode = UIView.ContentMode.scaleAspectFill
    self.layer.cornerRadius = self.frame.height / 2
    self.layer.masksToBounds = false
    self.clipsToBounds = true

    self.image = anyImage
    
  }
}
