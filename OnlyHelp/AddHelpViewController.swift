//
//  AddHelpViewController.swift
//  OnlyHelp
//
//  Created by VEERA NARAYANA GUTTI on 07/11/19.
//  Copyright © 2019 VEERA NARAYANA GUTTI. All rights reserved.
//

import UIKit
import Firebase

class AddHelpViewController: UIViewController {

    @IBOutlet weak var helpDescrTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var submitButton: UIButton!
    

    @IBAction func submitButtonPressed(_ sender: Any) {
        var ref: DatabaseReference!
        
        ref = Database.database().reference()
        let userId = defaults.value(forKey: userID) as! String
        let uuid = UUID().uuidString.lowercased()
        ref.child(users).child(userId).child(userHelp).child(uuid).setValue(helpDescrTextView.text)
        
    }
}
