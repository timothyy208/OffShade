//
//  GameWindow.swift
//  OffShade
//
//  Created by Timothy Yang on 7/29/19.
//  Copyright © 2019 Timothy Yang. All rights reserved.
//

import UIKit

class GameWindow: UIViewController {

    
    var countdownTimer: Timer!
    var totalTime = 60
    var timerLabel: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let screenHeight = screenSize.height
        
        timerLabel = UITextView(frame: CGRect(x: (screenWidth-50)/2, y: 100, width: 100, height: 100))
        timerLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(timerLabel)
        generateButtons()
        
    }
    
    @objc func buttonAction() {
        startTimer()
    }
 
    func generateButtons() {
        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 50))

        button.setTitle("Test Button", for: [])
        button.backgroundColor = .clear
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        timerLabel.text = "\(totalTime)"
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
        print("you lost")
    }
}
