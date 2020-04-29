//
//  ActivityLoading.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 28/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import UIKit

class LoadingView {
    
    func customActivityIndicatory(_ viewContainer: UIView, startAnimate:Bool? = true) -> UIActivityIndicatorView {
          let mainContainer: UIView = UIView(frame: viewContainer.frame)
          mainContainer.center = viewContainer.center
          mainContainer.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
          mainContainer.alpha = 0.5
          mainContainer.tag = 789456123
          mainContainer.isUserInteractionEnabled = false
      
          let viewBackgroundLoading: UIView = UIView(frame: CGRect(x:0,y: 0,width: 100,height: 100))
          viewBackgroundLoading.center = viewContainer.center
          viewBackgroundLoading.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
          viewBackgroundLoading.alpha = 0.5
          viewBackgroundLoading.clipsToBounds = true
          viewBackgroundLoading.layer.cornerRadius = 15
      
          let activityIndicatorView: UIActivityIndicatorView = UIActivityIndicatorView()
          activityIndicatorView.frame = CGRect(x:0.0,y: 0.0,width: 50.0, height: 50.0)
          activityIndicatorView.style = .medium
          activityIndicatorView.center = CGPoint(x: viewBackgroundLoading.frame.size.width / 2, y: viewBackgroundLoading.frame.size.height / 2)

          if startAnimate! {
            viewBackgroundLoading.addSubview(activityIndicatorView)
            mainContainer.addSubview(viewBackgroundLoading)
            viewContainer.addSubview(mainContainer)
            activityIndicatorView.startAnimating()
            
          } else {
             for subview in viewContainer.subviews{
                  if subview.tag == 789456123{
                    subview.removeFromSuperview()
                  }
              }
          }
          return activityIndicatorView
    }
    
    func showAlert(message: String) -> UIAlertController {
        let alert = UIAlertController(title: "Error Dialog", message: message, preferredStyle: .alert)
                
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        return alert
    }
}
