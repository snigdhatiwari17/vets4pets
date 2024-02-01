//
//  SignUpViewController.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 01/02/24.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var usernameTextfield: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func signUpPressed(_ sender: Any) {
        
        if let email = usernameTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let e = error {
                    print(e)
                } else {
                    //Navigate to the ChatViewController
                    self.performSegue(withIdentifier: K.moreDetailsSegue, sender: self)
                }
            }
        }
        
    }
    
    }
    


