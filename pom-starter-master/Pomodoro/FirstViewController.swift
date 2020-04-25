//
//  FirstViewController.swift
//  Pomodoro
//
//  Created by Adriana González Martínez on 1/16/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//  Initial app found here www.globalnerdy.com/2017/06/28/the-code-for-tampa-ios-meetups-pomodoro-timer-exercise

import UIKit

class FirstViewController: UIViewController {

    var completedCycles = 0
    @IBOutlet weak var messageLabel: UILabel!
    
    deinit {
        //ACTION: Remove observers
        NotificationCenter.default.removeObserver(self, name: Notification.Name("receivedNotification"), object: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //ACTION: Add observers
        NotificationCenter.default.addObserver(self, selector: #selector(receivedNotification), name: Notification.Name("receivedNotification"), object: nil)
        
    }
    
    @objc func receivedNotification(_ notification:Notification) {
        // ACTION: Update value of completed cycles
        completedCycles += 1
        // ACTION: Update message label
        messageLabel.text = "\(completedCycles) pomodoro cycles completed today"
        
    }
}

