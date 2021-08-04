//
//  ViewController.swift
//  GoogleSignin
//
//  Created by CV on 4/23/21.
//

import UIKit
import GoogleSignIn

class ViewController: UIViewController{
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var profileImg: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self

    }

    @IBAction func signInClicked(_ sender: Any) {
        GIDSignIn.sharedInstance().signIn()
    
    }
    
}
extension ViewController : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {

                let vc = storyboard?.instantiateViewController(identifier: "ProfileVC")as! ProfileViewController
                self.navigationController?.pushViewController(vc, animated: true)
       
    }
}

