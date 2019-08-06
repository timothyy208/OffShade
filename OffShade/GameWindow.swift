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
    var buttons: [Int:UIButton] = [:]
    let colors: [UIColor:UIColor] =
        [UIColor(displayP3Red: 191.0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0) : UIColor(displayP3Red: 204.0/255.0, green: 51.0/255.0, blue: 255.0/255.0, alpha: 1.0),
         UIColor(displayP3Red: 255.0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0) : UIColor(displayP3Red: 255.0/255.0, green: 90.0/255.0, blue: 255/255.0, alpha: 1.0),
         UIColor(displayP3Red: 255.0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0) : UIColor(displayP3Red: 255.0/255.0, green: 45.0/255.0, blue: 77.0/255.0, alpha: 1.0),
         UIColor(displayP3Red: 0/255.0, green: 0/255.0, blue: 255.0/255.0, alpha: 1.0) : UIColor(displayP3Red: 40.0/255.0, green: 40.0/255.0, blue: 255/255.0, alpha: 1.0),
         UIColor(displayP3Red: 0/255.0, green: 255.0/255.0, blue: 0/255.0, alpha: 1.0) : UIColor(displayP3Red: 120.0/255.0, green: 255.0/255.0, blue: 120.0/255.0, alpha: 1.0)
    
    ]
    var mainColor = UIColor(displayP3Red: 191.0/255.0, green: 0.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    var offColor = UIColor(displayP3Red: 204.0/255.0, green: 51.0/255.0, blue: 255.0/255.0, alpha: 1.0)
    
    
    var screenWidth: Double!
    var screenHeight: Double!
    override func viewDidLoad() {
        super.viewDidLoad()
        //generate array of ui buttons
        for index in 1...100 {
            let button = UIButton()
            buttons[index] = button
            
        }
        
        let screenSize: CGRect = UIScreen.main.bounds
        screenWidth = Double(screenSize.width)
        screenHeight = Double(screenSize.height)
        //print(screenWidth)
        //print(screenHeight)
        timerLabel = UITextView(frame: CGRect(x: (screenWidth-50)/2, y: 100, width: 100, height: 100))
        timerLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(timerLabel)
        generateButtons(screenHeight, screenWidth)

        
    }
    
    @objc func buttonAction() {
        //wrong button
        
    }
    
    @objc func rightButton() {
        deleteButtons()
        generateButtons(screenHeight, screenWidth)
        
    }
 
    func generateButtons(_ height : Double,  _ width : Double) {
        
        
        let width = Int(width)
        //let height = Int(height)
        var widthWhole = 0
        //var heightWhole = 0
        var widthDiff = 0
        //var heightDiff = 0
        //calculations for button placement
        for index in stride(from: width, to: 0, by: -1) {
            if (index%100 == 0) {
                widthWhole = index
                widthDiff = width - widthWhole
                break
            }
        }
        

        
        let buttonWidth = widthWhole/10
        let buttonHeight = buttonWidth
        let widthMargin = widthDiff/2
        //set color & which button is correct
        let colorPair = colors.randomElement()!
        mainColor = colorPair.key
        offColor = colorPair.value
        let offShadeButton = Int.random(in: 1...100)
        
        
        //create buttons - need to make for loop
        var currXPos = widthMargin
        var currYPos = 250
        
        for index in 1...100 {
            //print(index)
            
            
            var currButton = buttons[index]
            currButton = UIButton(frame: CGRect(x: currXPos, y: currYPos, width: buttonWidth, height: buttonHeight))
            if (index == offShadeButton) {
                print(index)
                currButton!.backgroundColor = offColor
                currButton!.addTarget(self, action: #selector(rightButton), for: .touchUpInside)
            }
            if (index != offShadeButton) {
                currButton!.backgroundColor = mainColor
                currButton!.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            }
            currButton!.layer.cornerRadius = 5
            currButton!.layer.borderWidth = 1
            currButton!.layer.borderColor = UIColor.black.cgColor
            
            self.view.addSubview(currButton!)
            if (index%10 == 1) {
                currXPos += buttonWidth
            } else if (index%10 == 0) {
                currXPos = widthMargin
                currYPos += buttonHeight
            } else {
                currXPos += buttonWidth
            }
            
        }
        
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
    
    func deleteButtons() {
        for index in 1...100 {
            let button = buttons[index]
            button?.removeFromSuperview()
        }
    }
 
}
