//
//  MyProfileViewController.swift
//  OnlyHelp
//
//  Created by VEERA NARAYANA GUTTI on 29/10/19.
//  Copyright © 2019 VEERA NARAYANA GUTTI. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn
 

class MyProfileViewController: UIViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var userFullnameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userFullnameLabel.text = defaults.value(forKey: userFullname) as? String
        userEmailLabel.adjustsFontSizeToFitWidth = true
        loadUserData(with: defaults.value(forKey: userPictureUrl) as! String, and: defaults.value(forKey: userEmail) as! String)
    }
    
    func loadUserData(with url : String, and mail: String){
        userImageView.setRounded()
        userImageView.layer.borderWidth = 4
        userImageView.layer.borderColor = UIColor.white.cgColor
        userImageView.image = UIImage(named: "blank-profile-picture")
        userEmailLabel.text = mail
        let url = URL(string: url)

        DispatchQueue.global().async {
            guard let data = try? Data(contentsOf: url!) else {return}//make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
            DispatchQueue.main.async {
                self.userImageView.image = UIImage(data: data)
            }
        }

    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        let deletepermission = GraphRequest(graphPath: "me/permissions/", parameters: [:], httpMethod: HTTPMethod(rawValue: "DELETE"))
        deletepermission.start(completionHandler: {(connection,result,error)-> Void in
            print("the delete permission is \(String(describing: result))")

        })
        defaults.set(nil, forKey: userFullname)
        defaults.set(nil, forKey: userPictureUrl)
        defaults.set(nil, forKey: userEmail)
        defaults.set(nil, forKey: userID)
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
