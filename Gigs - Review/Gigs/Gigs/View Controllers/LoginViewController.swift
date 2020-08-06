//
//  LoginViewController.swift
//  Gigs
//
//  Created by Cody Morley on 8/5/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    //MARK: - Types -
    enum AuthType: CaseIterable {
        case login
        case signup
    }
    
    
    //MARK: - Properties -
    ///Outlets
    @IBOutlet weak var authControl: UISegmentedControl!
    @IBOutlet weak var authButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    ///Dependencies
    var authenticationController: AuthenticationController?
    ///Computed Properties
    var authType: AuthType {
        return AuthType.allCases[self.authControl.selectedSegmentIndex]
    }

    
    //MARK: - Life Cycles -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Actions -
    @IBAction func toggleAuth(_ sender: Any) {
        print("I did this somewhere else ;)")
    }
    
    @IBAction func authenticate(_ sender: Any) {
        guard let username = usernameField.text,
            let password = passwordField.text,
            !username.isEmpty,
            username != "",
            !password.isEmpty,
            password != "" else {
                NSLog("Must have text in both name and password fields.")
                return
        }
        
        let user = User(username: username,
                        password: password)
        
        
        switch authType {
        case .login:
            authenticationController?.logIn(user)
            guard authenticationController?.bearer != nil else {
                presentFailureAlert()
                return
            }
            presentLoginSuccessAlert()
        case .signup:
            authenticationController?.signUp(user)
            presentSignUpSuccessAlert()
        }
    }
    
    
    // MARK: - Methods -
    private func presentSignUpSuccessAlert() {
        let alert = UIAlertController(title: "Signed up successfully",
                                      message: "Login to continue",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .cancel,
                                     handler: nil)
        alert.addAction(okAction)
        present(alert,
                animated: true,
                completion: nil)
    }
    
    private func presentLoginSuccessAlert() {
        let alert = UIAlertController(title: "Login Success!",
                                      message: "Tap 'OK' to move on to gigs:",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK",
                                     style: .default) { action in
            self.dismiss(animated: true) {
                DispatchQueue.main.async {
                    self.authenticationController?.delegate?.setBearer()
                }
            }
            print("Successfully passed login flow.")
        }
        alert.addAction(okAction)
        present(alert,
                animated: true,
                completion: nil)
    }
    
    private func presentFailureAlert() {
        let alert = UIAlertController(title: "Something went wrong.",
                                      message: "Tap 'OK' to retry",
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK",
                                     style: .cancel,
                                     handler: nil)
        alert.addAction(okAction)
        present(alert,
                animated: true,
                completion: nil)
    }
}
