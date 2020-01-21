//
//  MainViewController.swift
//  OnlyHelp
//
//  Created by VEERA NARAYANA GUTTI on 28/10/19.
//  Copyright © 2019 VEERA NARAYANA GUTTI. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var logoutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            let manager = LoginManager()
            AccessToken.current = nil
            Profile.current = nil
            manager.logOut()
            GIDSignIn.sharedInstance()?.signOut()
            
            let signupvc = storyboard?.instantiateViewController(withIdentifier: "signup") as! SignUpViewController
            UIApplication.shared.keyWindow?.rootViewController = signupvc

        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
}
