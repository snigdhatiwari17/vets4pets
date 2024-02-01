//
//  LogInViewController.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 01/02/24.
//

import UIKit
import FirebaseAuth

class LogInViewController: UIViewController {
    
    
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func logInPressed(_ sender: Any) {
        if let email = usernameTextfield.text, let password = passwordTextfield.text {
            Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                
               
                
            }
            }
        self.performSegue(withIdentifier: "toCustomerHome", sender: self)
       
         Auth.auth().addStateDidChangeListener { auth, user in
            
            if let user = user {
                // The user's ID, unique to the Firebase project.
                // Do NOT use this value to authenticate with your backend server,
                // if you have one. Use getTokenWithCompletion:completion: instead.
                let uid = user.uid
                
                if uid == "encPD3KvYBVogm1ByZ0p8qkvpqo1"{
                    self.performSegue(withIdentifier: "toAdminHome", sender: self)
                }
                //sends user to admin home page, if id matches admin user
                
                // ...
            }
        }
        }
    
   
    
   
    
    
    }
    

    

