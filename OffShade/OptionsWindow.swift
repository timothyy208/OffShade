//
//  OptionsWindow.swift
//  OffShade
//
//  Created by Timothy Yang on 8/8/19.
//  Copyright © 2019 Timothy Yang. All rights reserved.
//

import UIKit

class OptionsWindow: UIViewController {
    @IBOutlet weak var soundButton: UISwitch!
    @IBOutlet weak var vibrateButton: UISwitch!
    var muted = false
    var vibrate = true
    override func viewDidLoad() {
        super.viewDidLoad()
        soundButton.isOn = !muted
        vibrateButton.isOn = vibrate
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func soundButtonPressed(_ sender: UISwitch) {
        muted = !muted
    }
    @IBAction func vibrationButtonPressed(_ sender: UISwitch) {
        vibrate = !vibrate
    }
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DoneSettings" {
            let destination = segue.destination as! ViewController
            destination.muted = muted
            destination.vibrate = vibrate
        }
    }
    
}
