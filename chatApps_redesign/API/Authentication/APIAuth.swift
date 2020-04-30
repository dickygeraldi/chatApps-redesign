//
//  APIAuth.swift
//  chatApps_redesign
//
//  Created by Dicky Geraldi on 28/04/20.
//  Copyright © 2020 Dicky Geraldi. All rights reserved.
//

import Foundation

class APIAuth {
    
    func Registration(username: String, password: String) -> ResponseAuth {
        let semaphore = DispatchSemaphore (value: 0)
        
        var response: ResponseAuth
        
        var code: String = ""
        var message: String = ""

        let parameters = [
            "api": "V1",
            "username": username,
            "password": password
        ]
        
        var request = URLRequest(url: URL(string: "https://proto-user-services.herokuapp.com/v1/user-services/register-account-harvesting")!,timeoutInterval: Double.infinity)
        
        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])
        
        request.httpMethod = "POST"
        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            do {
                let jsonData = try JSONDecoder().decode(RegisterUsers.self, from: data)
                
                code = jsonData.code
                message = jsonData.message
                
            } catch let parsingError {
                print("Error", parsingError)
            }
            
            semaphore.signal()
        }
        
        
        task.resume()
        semaphore.wait()
        
        response = ResponseAuth.init(code: code, token: "", message: message)
        
        return response
    }
    
    func LoginNow(username: String, password: String) -> ResponseAuth {
        let semaphore = DispatchSemaphore (value: 0)
        
        var response: ResponseAuth
        
        var code: String = ""
        var message: String = ""
        var token: String = ""

        let parameters = [
            "api": "V1",
            "username": username,
            "password": password
        ]
        
        var request = URLRequest(url: URL(string: "https://proto-user-services.herokuapp.com/v1/user-services/login-account-harvesting")!,timeoutInterval: Double.infinity)

        let jsonData = try! JSONSerialization.data(withJSONObject: parameters, options: [])

        request.httpMethod = "POST"
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
          guard let data = data else {
            print(String(describing: error))
            return
          }
            do {
                let jsonData = try JSONDecoder().decode(LoginUsers.self, from: data)
                
                code = jsonData.code
                message = jsonData.message
                token = jsonData.data.token

            } catch let parsingError {
                print("Error", parsingError)
            }
            semaphore.signal()
        }

        task.resume()
        semaphore.wait()
        
        response = ResponseAuth.init(code: code, token: token, message: message)
        
        return response
    }
}
