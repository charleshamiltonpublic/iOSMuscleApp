//
//  ViewController.swift
//  MuscleApp
//
//  Created by Hamilton, Charles Scott on 11/29/21.
//

import UIKit
import Firebase
import GoogleSignIn
class SignInViewController: UIViewController {
    let signInConfig = GIDConfiguration.init(clientID: "190230034-p8odjonuln3gh9rurg14pridphrkntcs.apps.googleusercontent.com")
    //MARK: Outlets and Actions
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBAction func signIn(_ sender: Any) {
        print("sign in!")
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) {
            user, error in
            guard error == nil else {return}
            guard let user = user else {return}
            print(user.profile?.email)
            print(user.userID)
            
            self.performSegue(withIdentifier: "showTasks", sender: nil)
        }
        
    }
    @IBAction func signOut(_ sender: Any) {
        print("sign out!")
        GIDSignIn.sharedInstance.signOut()
        
    }
    
    //MARK: View Lifecycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = GIDSignIn.sharedInstance.currentUser {
            self.performSegue(withIdentifier: "showTasks", sender: nil)
        }
    }
}

