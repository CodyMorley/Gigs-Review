//
//  GigsTableViewController.swift
//  Gigs
//
//  Created by Cody Morley on 8/5/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import UIKit

class GigsTableViewController: UITableViewController {
    //MARK: = Properties -
    var authenticationController = AuthenticationController()
    var gigController = GigController()
    
    
    //MARK: - Life Cycles -
    override func viewDidLoad() {
        super.viewDidLoad()
        authenticationController.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if authenticationController.bearer == nil {
            performSegue(withIdentifier: "LoginSegue",
                         sender: self)
        }
        
        //TODO: -fetch gigs here
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "", for: indexPath)

        return cell
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.authenticationController = authenticationController
            }
        }
    }

}

extension GigsTableViewController: AuthenticationControllerDelegate {
    func setBearer() {
        gigController.bearer = authenticationController.bearer
    }
}
