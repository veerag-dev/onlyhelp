//
//  SignUpViewController.swift
//  OnlyHelp
//
//  Created by VEERA NARAYANA GUTTI on 28/10/19.
//  Copyright © 2019 VEERA NARAYANA GUTTI. All rights reserved.
//

import UIKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class SignUpViewController: UIViewController, LoginButtonDelegate, GIDSignInDelegate {
    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var fbSignUpButton: UIButton!
    @IBOutlet weak var gSingUpButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.isHidden = true
        GIDSignIn.sharedInstance().delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        welcomeLabel.adjustsFontSizeToFitWidth = true
        if AccessToken.isCurrentAccessTokenActive || (GIDSignIn.sharedInstance()?.hasPreviousSignIn())! {
            print("your session is active : FB \(AccessToken.isCurrentAccessTokenActive) G \(String(describing: GIDSignIn.sharedInstance()!.hasPreviousSignIn())) \n Firebase User Exists :\(Auth.auth().currentUser != nil ? true : false)")
            let mainvc = self.storyboard?.instantiateViewController(withIdentifier: "sidemenu")
            UIApplication.shared.keyWindow?.rootViewController = mainvc
        } else {
            print("your session is inactive : FB \(AccessToken.isCurrentAccessTokenActive) G \(String(describing: GIDSignIn.sharedInstance()!.hasPreviousSignIn())) \n Firebase User Exists :\(Auth.auth().currentUser != nil ? true : false)")
        }
        
    }
    

    @IBAction func fbSignUpButtonPressed(_ sender: Any) {
        let fbLoginManager = LoginManager()

        fbLoginManager.logIn(permissions: ["public_profile", "email"], from: self) { (result, error) in
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
            if let error = error {
                print("Failed to login: \(error.localizedDescription)")
                self.activityIndicator.stopAnimating()
                return
            }
            
            guard let accessToken = AccessToken.current else {
                print("Failed to get access token")
                self.activityIndicator.stopAnimating()
                self.activityIndicator.isHidden = true
                return
            }
            
            let credential = FacebookAuthProvider.credential(withAccessToken: accessToken.tokenString)
            
            self.showUserDetails()
            // Perform login by calling Firebase APIs
            Auth.auth().signIn(with: credential, completion: { (user, error) in
                if let error = error {
                    print("Login error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Login Error", message: error.localizedDescription, preferredStyle: .alert)
                    let okayAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(okayAction)
                    self.present(alertController, animated: true, completion: nil)
                    
                    return
                }
                self.activityIndicator.stopAnimating()
                print(user!.user.email!)
                defaults.set(user!.user.displayName!, forKey: userFullname)
                defaults.set(user!.user.email!, forKey: userEmail)
                defaults.set(user!.user.uid, forKey: userID)
                let mainvc = self.storyboard?.instantiateViewController(withIdentifier: "sidemenu")
                UIApplication.shared.keyWindow?.rootViewController = mainvc
                
            })
            
        }
    }
    
    @IBAction func gSignUpButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance()?.signIn()
    }
    
    
    //MARK:Google SignIn Delegate
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
        // myActivityIndicator.stopAnimating()
    }
    // Present a view that prompts the user to sign in with Google
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }

    // Dismiss the "Sign in with Google" view
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }

    //completed sign In
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()

        if (error != nil) {
            print("\(error.localizedDescription)")
            self.activityIndicator.isHidden = true
            self.activityIndicator.stopAnimating()

        } else {
            
            guard let authentication = user.authentication else { return }
            let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                           accessToken: authentication.accessToken)
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if let error = error {
                    print("Google sign in erro : \(error.localizedDescription)")
                    return
                }
                
                print("Google User : \(String(describing: user))")
                defaults.set(user.profile.name, forKey: userFullname)
                defaults.set(user!.profile!.imageURL(withDimension: 100)!.absoluteString, forKey: userPictureUrl)
                defaults.set(user!.profile!.email, forKey: userEmail)
                defaults.set(authResult?.user.uid, forKey: userID)
                self.activityIndicator.stopAnimating()
                let mainvc = self.storyboard?.instantiateViewController(withIdentifier: "sidemenu")
                UIApplication.shared.keyWindow?.rootViewController = mainvc

                // Perform any operations on signed in user here.
                let userId = user.userID                  // For client-side use only!
                let idToken = user.authentication.idToken // Safe to send to the server
                let fullName = user.profile.name
                let givenName = user.profile.givenName
                let familyName = user.profile.familyName
                let email = user.profile.email
                // ...
                
            }
        }
    }
    
    func showUserDetails(){
        GraphRequest(graphPath: "me", parameters: ["fields": "id, name, email, picture.width(500).height(500)"]).start { (connection, result, error) in
            if error != nil{
                print("Failed to start graph request: \(String(describing: error))")
                return
            }
            print("Graph result :\(String(describing: result))")
            
            guard let userDict = result as? [String:Any] else { return }
            if let picture = userDict["picture"] as? [String:Any] ,
               let imgData = picture["data"] as? [String:Any] ,
               let imgUrl = imgData["url"] as? String {
                defaults.set(imgUrl, forKey: userPictureUrl)
                print("FB User image data:\(imgUrl)")
            }
        }

    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil{
            print("Login error : \(error.debugDescription)")
            return
        }
        print("Successfully logged in with facebook")
        showUserDetails()
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Did log out of facebook")
    }
    deinit {
        self.view = nil
    }
}
