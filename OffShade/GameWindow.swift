//
//  GameWindow.swift
//  OffShade
//
//  Created by Timothy Yang on 7/29/19.
//  Copyright © 2019 Timothy Yang. All rights reserved.
//

import UIKit

class GameWindow: UIViewController {

    
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var quitButton: UIButton!
    @IBOutlet weak var pointLabel: UILabel!
    
    var points = 0
    var countdownTimer: Timer!
    var totalTime = 60
    var timerLabel: UITextView!
    var buttons: [Int:UIButton] = [:]
    let colors: [UIColor:UIColor] =
        [UIColor(displayP3Red: 191.0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0) : UIColor(displayP3Red: 200.0/255.0, green: 51.0/255.0, blue: 255.0/255.0, alpha: 1.0),
         UIColor(displayP3Red: 255.0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0) : UIColor(displayP3Red: 255.0/255.0, green: 75.0/255.0, blue: 255/255.0, alpha: 1.0),
         UIColor(displayP3Red: 255.0/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0) : UIColor(displayP3Red: 255.0/255.0, green: 35.0/255.0, blue: 67.0/255.0, alpha: 1.0),
         UIColor(displayP3Red: 0/255.0, green: 0/255.0, blue: 255.0/255.0, alpha: 1.0) : UIColor(displayP3Red: 25.0/255.0, green: 25.0/255.0, blue: 255/255.0, alpha: 1.0),
         UIColor(displayP3Red: 0/255.0, green: 255.0/255.0, blue: 0/255.0, alpha: 1.0) : UIColor(displayP3Red: 120.0/255.0, green: 255.0/255.0, blue: 120.0/255.0, alpha: 1.0),
         UIColor(displayP3Red: 153.0/255.0, green: 204/255.0, blue: 255/255.0, alpha: 1.0) : UIColor(displayP3Red: 170/255.0, green: 210/255.0, blue: 255.0/255.0, alpha: 1.0),
         UIColor(displayP3Red: 153.0/255.0, green: 102/255.0, blue: 51/255.0, alpha: 1.0) : UIColor(displayP3Red: 170/255.0, green: 115/255.0, blue: 51/255.0, alpha: 1.0),
         UIColor(displayP3Red: 255/255.0, green: 255/255.0, blue: 204/255.0, alpha: 1.0) : UIColor(displayP3Red: 255/255.0, green: 255/255.0, blue: 218/255.0, alpha: 1.0),
         UIColor(displayP3Red: 20/255.0, green: 20/255.0, blue: 20/255.0, alpha: 1.0) : UIColor(displayP3Red: 25/255.0, green: 25/255.0, blue: 25/255.0, alpha: 1.0)
        ]
    var mainColor: UIColor!
    var offColor: UIColor!
    
    
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
        
        timerLabel = UITextView(frame: CGRect(x: (screenWidth-50)/2, y: 75, width: 50, height: 50))
        timerLabel.font = UIFont.init(name: "Marker Felt", size: 25)
        timerLabel.backgroundColor = .darkGray
        timerLabel.textColor = .white
        
        timerLabel.text = "\(totalTime)"
        timerLabel.textAlignment = .center
        self.view.addSubview(timerLabel)
        generateButtons(screenHeight, screenWidth)
        
        playAgainButton.layer.cornerRadius = 5
        playAgainButton.layer.borderWidth = 1
        playAgainButton.layer.borderColor = UIColor.gray.cgColor
        
        quitButton.layer.cornerRadius = 5
        quitButton.layer.borderWidth = 2
        quitButton.layer.borderColor = UIColor.gray.cgColor
        
        
        
        playAgainButton.isHidden = true
        
        
        
        startTimer()

        
    }
    
    @objc func buttonAction() {
        updateTime()
    }
    
    @objc func rightButton() {
        deleteButtons()
        generateButtons(screenHeight, screenWidth)
        points += 1
        pointLabel.text = "\(points)"
        
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
                //print(index)
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
        
        
        if totalTime != 0 {
            totalTime -= 1
        } else {
            deleteButtons()
            endTimer()
        }
        timerLabel.text = "\(totalTime)"
    }
    
    func endTimer() {
        self.countdownTimer.invalidate()
   
        let alert = UIAlertController(title: "Game Over!", message: "You scored \(points) point(s)!", preferredStyle: .alert)
        alert.setBackgroundColor()
        alert.setMessage(font: UIFont.init(name: "Marker Felt", size: 22),color: UIColor.white)
        alert.setTitle(font: UIFont.init(name: "Marker Felt", size: 22),color: UIColor.white)
        alert.addAction(UIAlertAction(title: "Play Again", style: .default, handler: { action in
            self.totalTime = 60
            self.points = 0
            self.pointLabel.text = "\(self.points)"
            self.deleteButtons()
            self.generateButtons(self.screenHeight, self.screenWidth)
            self.startTimer()
            
        }))
        alert.addAction(UIAlertAction(title: "Quit", style: .default, handler: { action in
            self.quitGame(self.quitButton)
        }))
        
        self.present(alert, animated: true)

        

        
    }
    
    func deleteButtons() {
        
        for index in 1...100 {
            let button = buttons[index]
            button?.removeFromSuperview()
        }
        //print("delete")
    }
    
    @IBAction func playAgain(_ sender: UIButton) {
        
        quitButton.isHidden = true
        playAgainButton.isHidden = true
        
    }
    
    @IBAction func quitGame(_ sender: UIButton) {
        performSegue(withIdentifier: "quitGame", sender: self)
    }
    
    

    
}
extension UIAlertController{
    open override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.view.tintColor = .white
    }
    open func setBackgroundColor() {
        if let bgView = self.view.subviews.first, let groupView = bgView.subviews.first, let contentView = groupView.subviews.first {
            contentView.backgroundColor = .darkGray
        }
    }
    func setMessage(font: UIFont?, color: UIColor?) {
        guard let message = self.message else { return }
        let attributeString = NSMutableAttributedString(string: message)
        if let messageFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : messageFont],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        
        if let messageColorColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : messageColorColor],
                                          range: NSMakeRange(0, message.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedMessage")
    }
    func setTitle(font: UIFont?, color: UIColor?) {
        guard let title = self.title else { return }
        let attributeString = NSMutableAttributedString(string: title)//1
        if let titleFont = font {
            attributeString.addAttributes([NSAttributedString.Key.font : titleFont],//2
                range: NSMakeRange(0, title.utf8.count))
        }
        
        if let titleColor = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor : titleColor],//3
                range: NSMakeRange(0, title.utf8.count))
        }
        self.setValue(attributeString, forKey: "attributedTitle")//4
    }
}
