//
//  ProfileViewController.swift
//  GoogleSignin
//
//  Created by CV on 4/23/21.
//

import UIKit
import GoogleSignIn

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().restorePreviousSignIn()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapSignOut(_ sender: AnyObject) {
        GIDSignIn.sharedInstance().signOut()
        let vc = storyboard?.instantiateViewController(identifier: "ProfileVC")as! ProfileViewController
        self.navigationController?.popViewController(animated: true)
      
    }
    

}
extension ProfileViewController : GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//           if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
//             print("The user has not signed in before or they have since signed out.")
//           } else {
//             print("\(error.localizedDescription)")
//           }
//           return
//         }
    
   
        let userId = user.userID                  // For client-side use only!
        let idToken = user.authentication.idToken // Safe to send to the server
        let fullName = user.profile.name
        let givenName = user.profile.givenName
        let familyName = user.profile.familyName
        let email = user.profile.email
       let profileUrl = user.profile.imageURL(withDimension: .min)
       print("fullName:\(fullName)")
       print("userId:\(userId)")
       print("email:\(email)")
       userNameLabel.text = fullName
       emailLabel.text = email
       
       let imgData = try? Data(contentsOf: profileUrl!)
       if let ImageData = imgData {
           profileImg.image = UIImage(data: ImageData)
       }
       
          
    }
}
