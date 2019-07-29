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
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startGameButton.backgroundColor = .clear
        startGameButton.layer.cornerRadius = 5
        startGameButton.layer.borderWidth = 1
        startGameButton.layer.borderColor = UIColor.black.cgColor
    }


}

