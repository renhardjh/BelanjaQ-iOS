//
//  LoginController.swift
//  BelanjaQ
//
//  Created by RenhardJH on 24/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit
import GoogleSignIn
import FBSDKLoginKit

class LoginController: UIViewController, GIDSignInDelegate {
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var btnGIDLogin: GIDSignInButton!
    @IBOutlet weak var etUsername: EUITextField!
    @IBOutlet weak var etPassword: EUITextField!
    @IBOutlet weak var checkbox: Checkbox!
    @IBOutlet weak var labelRemember: UILabel!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initiallizeUI()
        observerGoogleLogin()
        observerFBLogin()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let exist = viewModel.checkUserExist()
        if exist {
            gotoHomePage()
        }
    }
    
    private func initiallizeUI() {
        checkbox.borderStyle                = .circle
        checkbox.checkedBorderColor         = .gray
        checkbox.uncheckedBorderColor       = .systemBlue
        checkbox.checkboxBackgroundColor    = .clear
        checkbox.checkmarkColor             = .white
        checkbox.checkmarkStyle             = .tick
        checkbox.addTarget(self, action: #selector(checkboxValueChanged(sender:)), for: .valueChanged)
        let hasRemember     = UserDefaults.standard.object(forKey: "username") != nil
        checkbox.isChecked  = hasRemember
        checkboxValueChanged(sender: checkbox)
        if hasRemember {
            etUsername.text     = viewModel.pref.object(forKey: "username") as? String
        }
    }
    
    private func observerGoogleLogin() {
        GIDSignIn.sharedInstance()?.clientID = "276687654918-vgkv2tb1jogk9c8kckiqfm51rso8c3qj.apps.googleusercontent.com"
        GIDSignIn.sharedInstance()?.delegate = self
        GIDSignIn.sharedInstance()?.presentingViewController = self
    }
    
    private func observerFBLogin() {
        NotificationCenter.default.addObserver(forName: .AccessTokenDidChange, object: nil, queue: OperationQueue.main) { (notification) in
            GraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, email"]).start(completionHandler: { (connection, result, error) -> Void in
                if (error == nil){
                    let fbDetails = result as! NSDictionary
                    self.viewModel.storeUser(data: fbDetails)
                    self.gotoHomePage()
                } else{
                    print(error?.localizedDescription ?? "Not found")
                }
            })
        }
    }
    
    @objc func checkboxValueChanged(sender: Checkbox) {
        checkbox.checkboxBackgroundColor    = sender.isChecked ? .systemBlue : .clear
        checkbox.checkedBorderColor         = sender.isChecked ? .systemBlue : .gray
        labelRemember.textColor             = sender.isChecked ? .systemBlue : .gray
    }
    
    @IBAction func onLoginClick(_ button: UIButton) {
        let result = viewModel.standardLogin(etUsername.text, pswd: etPassword.text, remember: checkbox.isChecked)
        if result {
            gotoHomePage()
        } else {
            let alert = UIAlertController(title: "Oops", message: "Field cannot be empty", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
          if (error as NSError).code == GIDSignInErrorCode.hasNoAuthInKeychain.rawValue {
            print("The user has not signed in before or they have since signed out.")
          } else {
            print("\(error.localizedDescription)")
          }
          return
        }
        
        let user = User(id: user.userID, name: user.profile.name, email: user.profile.email)
        viewModel.storeUser(user: user)
    }
    
    private func gotoHomePage() {
        self.dismiss(animated: false, completion: nil)
        if let home = storyboard?.instantiateViewController(withIdentifier: "NavController") as? NavController {
            home.modalPresentationStyle             = .fullScreen
            self.present(home, animated: true, completion: nil)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

