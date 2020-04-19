//
//  ViewController.swift
//  Pomodoro
//
//  Created by Adriana González Martínez on 1/16/19.
//  Copyright © 2019 Adriana González Martínez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // There are two types of time intervals:
    //   1. Pomodoro: working on a task for 25 minutes without interruptions
    //   2. Break: 5 minutes
    
    enum IntervalType {
        case Pomodoro
        case Break
    }
    
    // Array of intervals that make up one session specifying if it's a break or pomodoro
    let intervals: [IntervalType] = [.Pomodoro,.Break,.Pomodoro,.Break,.Pomodoro,.Break,.Pomodoro]
    
    // Keeps track of where we are in the intervals
    var currentInterval = 0
    
    // Setting the duration of each type of interval in seconds, for testing purposes they are short.
    let pomodoroDuration = 10 // Real: 25 * 60
    let breakDuration = 5 //Real:  5 * 60
    
    var timeRemaining = 0
    
    // Timer
    var timer = Timer()
    
    //UI
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet var tomatoImages: [UIImageView]!
    @IBOutlet weak var startPauseButton: UIButton!
    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        //ACTION: Set button actions for startPauseButton, resetButton and closeButton
       

        resetAll()
        
    }
    
    // MARK: Update UI

    func updateTomatoes(to tomatoes: Int) {
        var currentTomato = 1
        for tomatoIcon in tomatoImages {
            tomatoIcon.alpha = currentTomato <= tomatoes ? 1.0 : 0.2
            currentTomato += 1
        }
    }
    
    func updateTime() {
        let (minutes, seconds) = minutesAndSeconds(from: timeRemaining)
        let min = formatNumber(minutes)
        let sec = formatNumber(seconds)
        timeLabel.text = "\(min) : \(sec)"
    }
    
    // MARK: Button Actions
    
    @objc func startPauseButtonPressed(_ sender: UIButton) {
        if timer.isValid {
         // Timer running
         // ACTION: Change the button’s title to “Continue”
         // ACTION: Enable the reset button
         // ACTION: Pause the timer, call the method pauseTimer
            
           
        } else {
         // Timer stopped or hasn't started
         // ACTION: Change the button’s title to “Pause”
         // ACTION: Disable the Reset button
            
           
            
            if currentInterval == 0 && timeRemaining == pomodoroDuration {
                // We are at the start of a cycle
                // ACTION: begin the cycle of intervals
                
            } else {
                // We are in the middle of a cycle
                // ACTION: Resume the timer.
                
            }
        }
    }
    
    @objc func resetButtonPressed(_ sender: UIButton) {
        
        if timer.isValid {
            timer.invalidate()
        }
        
        //ACTION: call the reset method
        
    }

    //ACTION: add the method to dismiss the view controller
    
    
    // MARK: Time Manipulation
    
    func startTimer() {
        //ACTION: create the timer, selector should be runTimer()
        
    }
    
    @objc func runTimer() {
        if timeRemaining > 0 {
            timeRemaining -= 1
            updateTime()
        } else {
            timer.invalidate()
            startNextInterval()
        }
    }
    
    func pauseTimer() {
        timer.invalidate()
        messageLabel.text = "Paused"
    }
    
    func resetAll() {
        currentInterval = 0
        updateTomatoes(to: 1)
        messageLabel.text = "Ready to work"
        startPauseButton.setTitle("Start", for: .normal)
        resetButton.isEnabled = false
        timeRemaining = pomodoroDuration
        updateTime()
    }
    
    func startNextInterval() {
        if currentInterval < intervals.count {
            // If not done with all pomodoros and breaks, do the next one.
            if intervals[currentInterval] == .Pomodoro {
                // Pomodoro interval
                timeRemaining = pomodoroDuration
                messageLabel.text = "Pomodoro session. Do not disturb."
                let tomatoes = (currentInterval + 2) / 2
                print("\(tomatoes) tomatoes")
                updateTomatoes(to: tomatoes)
            } else {
                // Rest break interval
                timeRemaining = breakDuration
                messageLabel.text = "Taking a break"
            }
            updateTime()
            startTimer()
            currentInterval += 1
        } else {
            // If all intervals are complete, reset all.
            // ACTION: Post Notification
            resetAll()
        }
    }
    
    // MARK: Formatters
    
    // Input: number of seconds, returns it as (minutes, seconds).
    func minutesAndSeconds(from seconds: Int) -> (Int, Int) {
        return (seconds / 60, seconds % 60)
    }

    // Input: number, returns a string of 2 digits with leading zero if needed
    func formatNumber(_ number: Int) -> String {
        return String(format: "%02d", number)
    }
}


@IBDesignable extension UIButton {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        }
        get {
            return layer.cornerRadius
        }
    }
}
