//
//  WelcomeViewController.swift
//  Flash Chat iOS13
//
//  Created by Angela Yu on 21/10/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit
import CLTypingLabel

class WelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: CLTypingLabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        var charIndex = 0;
//        titleLabel.text = ""
//        let titleText = "⚡️FlashChat"
//        for text in titleText {
//            Timer.scheduledTimer(withTimeInterval: 0.1 * Double(charIndex), repeats: false, block: {(timer) in
//                self.titleLabel.text?.append(text)
//            })
//            charIndex += 1
//        }
        titleLabel.text = K.appName
       
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    

}
