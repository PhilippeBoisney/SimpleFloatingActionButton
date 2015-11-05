//
//  ViewController.swift
//  SimpleFloatingActionButton
//
//  Created by Phil on 14/08/2015.
//  Copyright © 2015 CookMinute. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Simply, Call Button
        let plusButton: SimpleFloatingActionButton = SimpleFloatingActionButton()
        
        //Add action event
        plusButton.addTarget(self, action: "touchUpInsidePlusButton", forControlEvents: .TouchUpInside)
        
        //Change ripple effect design
        plusButton.ripplePercent = 2 //Default is '2' and I don't recommand to change it (Simply because I love it like that)
        plusButton.rippleBackgroundColor = UIColor.greenColor()
        plusButton.rippleColor = UIColor.redColor()
        
        //Add to the view
        self.view.addSubview(plusButton)
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK:
    
    // Push Action Sender for plusButton
    func touchUpInsidePlusButton() {
      print("You touched it !")
    }

}

