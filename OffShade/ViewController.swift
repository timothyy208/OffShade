//
//  ViewController.swift
//  OffShade
//
//  Created by Timothy Yang on 7/29/19.
//  Copyright © 2019 Timothy Yang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var startGameButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    var muted = false
    var vibrate = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startGameButton.backgroundColor = .gray
        startGameButton.setTitleColor(.white, for: .normal)
        startGameButton.layer.cornerRadius = 5
        startGameButton.layer.borderWidth = 1
        startGameButton.layer.borderColor = UIColor.gray.cgColor
        
        settingsButton.backgroundColor = .gray
        settingsButton.setTitleColor(.white, for: .normal)
        settingsButton.layer.cornerRadius = 5
        settingsButton.layer.borderWidth = 1
        settingsButton.layer.borderColor = UIColor.gray.cgColor
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "StartGame" {
            let destination = segue.destination as! GameWindow
            destination.muted = muted
            destination.vibrate = vibrate
        } else if (segue.identifier == "ShowOptions") {
            let destination = segue.destination as! OptionsWindow
            destination.muted = muted
            destination.vibrate = vibrate
        }
    }
}

