

import UIKit
import FBSDKLoginKit

class LoginViewController: UIViewController {

    var name:String = ""
    var imageUrl:String = ""

 
    @IBOutlet weak var btnFacebook: FBLoginButton!
    @IBOutlet weak var profileimgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let loginButton = FBLoginButton()
//               loginButton.center = view.center
//               view.addSubview(loginButton)

        if let token = AccessToken.current,
                !token.isExpired {
            let token = token.tokenString
            let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email,name,picture"], tokenString: token, version: nil, httpMethod: .get)
            request.start { (connection,result,error) in
                print("\(String(describing: result))")
            }
        }else {
            btnFacebook.permissions = ["public_profile", "email"]
            btnFacebook.delegate = self
        }
    }

    @IBAction func fbClicked(_ sender: Any) {
        print("test")
    }


}
extension LoginViewController : LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        let token = result?.token?.tokenString
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me", parameters: ["fields": "email,name,picture"], tokenString: token, version: nil, httpMethod: .get)
        request.start { (connection,result,error) -> Void in
        
            if token != nil {
                self.naviG()
            }
        }



    }

    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("Logout")
    }
    func naviG(){
        let vc = storyboard?.instantiateViewController(identifier: "ProfileViewController")as! ProfileViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

