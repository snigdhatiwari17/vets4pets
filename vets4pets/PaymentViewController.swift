//
//  PaymentViewController.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 02/02/24.
//

import Foundation
import UIKit
import Razorpay


class PaymentViewController: UIViewController{
    
    @IBOutlet weak var paymentTextfield: UITextField!
    private var razorpay: RazorpayCheckout?
    

    
    @IBOutlet weak var paymentbutton: UIButton!
    
    
    
    @IBAction func paymentClicked(_ sender: Any) {
        
        let options: [String:Any] = [
            "amount" : paymentTextfield.text, //mandatory in paise like:- 1000 paise ==  10 rs
                       "description": "purchase description",
                       "image": "https://url-to-image.png",
                       "name": "vets4pets",
                       "prefill": [
                           "contact": "9797979797",
                           "email": "Rahul@Vets4Pets.com"
                       ],
                       "theme": [
                           "color": "#F37254"
                         ]
                   ]
        razorpay?.open(options)
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
           razorpay = RazorpayCheckout.initWithKey("rzp_test_FYCQAsmKTFF8FR", andDelegate: self)
        }
            
            
            
            
            
            
}

extension PaymentViewController: RazorpayPaymentCompletionProtocol {
            func onPaymentSuccess(_ payment_id: String) {
                let alert = UIAlertController(title: "Paid", message: "Payment Success", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
    
            func onPaymentError(_ code: Int32, description str: String) {
                let alert = UIAlertController(title: "Error", message: "\(code)\n\(str)", preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(action)
                self.present(alert, animated: true, completion: nil)
            }
    }
