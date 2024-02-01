//
//  CustomerHomeViewController.swift
//  vets4pets
//
//  Created by Snigdha Tiwari  on 01/02/24.
//

import UIKit
import UserNotifications

class CustomerHomeViewController: UIViewController {
    
    private let notificationPublisher = NotificationPublisher()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        notificationPublisher.sendNotifications(title: "Vaccination Reminder", subtitle: "Get your dog vaccinated soon!", body: "Book a vaccination now!!!", badge: 1, delayInterval: nil)
    }
    
}

