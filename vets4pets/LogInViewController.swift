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
        self.performSegue(withIdentifier: K.moreDetailsSegue, sender: self)
        }
    }
    

    

