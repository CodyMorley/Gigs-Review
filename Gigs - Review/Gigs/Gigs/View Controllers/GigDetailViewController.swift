//
//  GigDetailViewController.swift
//  Gigs
//
//  Created by Cody Morley on 8/6/20.
//  Copyright © 2020 Cody Morley. All rights reserved.
//

import UIKit

class GigDetailViewController: UIViewController {
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var descriptionView: UITextView!
    
    var gigController: GigController!
    var gig: Gig?
    
    
    
    //MARK: - Life Cycles -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    //MARK: - Actions -
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleField.text,
            let description = descriptionView.text,
            !title.isEmpty,
            !description.isEmpty,
            title != "",
            description != "" else {
                NSLog("Must have title and descirption to post a gig.")
                return
        }
        
        let gigToPost = Gig(title: title,
                            description: description,
                            dueDate: datePicker.date)
        gigController.postGig(gigToPost)
        
        for gig in gigController.gigs {
            if gigToPost == gig {
                NSLog("Gig already exists in database.")
                presentDuplicateGigAlert()
            }
        }
        
        DispatchQueue.main.async {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    //MARK: - Methods -
    private func updateViews() {
        if let gig = gig {
            titleField.text = gig.title
            datePicker.date = gig.dueDate
            descriptionView.text = gig.description
        } else {
            self.navigationController?.title = "Add Gig"
        }
    }
    
    private func presentDuplicateGigAlert() {
        let alert = UIAlertController(title: "Duplicate Gig",
                                      message: "Gig already exists in database, try again.",
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
