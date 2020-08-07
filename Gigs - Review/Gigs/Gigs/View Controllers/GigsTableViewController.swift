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
    var dateFormatter = DateFormatter()
    
    
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
        return gigController.gigs.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GigCell", for: indexPath)
        
        cell.textLabel?.text = gigController.gigs[indexPath.row].title
        let dueDate = dateFormatter.string(from: gigController.gigs[indexPath.row].dueDate)
        cell.detailTextLabel?.text = dueDate
        
        return cell
    }


    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "LoginSegue" {
            if let loginVC = segue.destination as? LoginViewController {
                loginVC.authenticationController = authenticationController
            }
        } else if segue.identifier == "AddGig" {
            if let addVC = segue.destination as? GigDetailViewController {
                addVC.gigController = gigController
            }
        } else if segue.identifier == "GigDetail" {
            if let detailVC = segue.destination as? GigDetailViewController {
                let indexPath = IndexPath(indexes: tableView.indexPathForSelectedRow!)
                detailVC.gigController = gigController
                detailVC.gig = gigController.gigs[indexPath.row]
            }
        }
    }

}

extension GigsTableViewController: AuthenticationControllerDelegate {
    func setBearer() {
        gigController.bearer = authenticationController.bearer
    }
}
