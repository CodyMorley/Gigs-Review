//
//  AuthenticationController.swift
//  Gigs
//
//  Created by Cody Morley on 8/5/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import Foundation

class AuthenticationController {
    //MARK: - Properties -
    var delegate: AuthenticationControllerDelegate?
    var bearer: Bearer? {
        didSet {
            delegate?.setBearer()
        }
    }
    private var baseURL = URL(string: "https://lambdagigapi.herokuapp.com/api")!
    
    
    //MARK: - Actions -
    func signUp(_ user: User) {
        let url = baseURL.appendingPathComponent("/users/signup")
        var request = getRequest(url)
        
        do {
            let loginData = try JSONEncoder().encode(user)
            request.httpBody = loginData
        } catch {
            NSLog("Error encoding: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                NSLog("Something has gone wrong during signup. Here's some info: \(error) \(error.localizedDescription)")
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    NSLog("Bad or no response from host on signup.")
                    return
            }
            print("SUCCESS!")
        }.resume()
    }
    
    func logIn(_ user: User) {
        let url = baseURL.appendingPathComponent("/users/login")
        var request = getRequest(url)
        
        do {
            let loginData = try JSONEncoder().encode(user)
            request.httpBody = loginData
        } catch {
            NSLog("Error encoding: \(error)")
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                NSLog("Something has gone wrong during login. Here's some info: \(error) \(error.localizedDescription)")
            }
            
            guard let response = response as? HTTPURLResponse,
                response.statusCode == 200 else {
                    NSLog("Bad or no response from host on signup.")
                    return
            }
            
            guard let data = data else {
                NSLog("No data returned on login.")
                return
            }
            
            do {
                let result = try JSONDecoder().decode(Bearer.self,
                                                      from: data)
                self.bearer = result
                print("SUCCESS!")
            } catch {
                NSLog("Something happened decoding your bearer token, here's some info: \(error)")
                return
            }
        }.resume()
    }
    
    
    //MARK: - Methods -
    private func getRequest(_ url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        return request
    }
}
