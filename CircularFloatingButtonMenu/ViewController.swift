//
//  ViewController.swift
//  CircularFloatingButtonMenu
//
//  Created by Phil on 14/08/2015.
//  Copyright © 2015 CookMinute. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var editButton: CircularFloatingButton!
    @IBOutlet weak var messageButton: CircularFloatingButton!
    @IBOutlet weak var callButton: CircularFloatingButton!
    @IBOutlet weak var plusButton: CircularFloatingButton!
    
    var isPushed = false
    var scale = CGAffineTransformMakeScale(0.0, 0.0)
    var translate = CGAffineTransformMakeTranslation(0.0, 50)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        editButton.transform = CGAffineTransformConcat(scale, translate)
        messageButton.transform = CGAffineTransformConcat(scale, translate)
        callButton.transform = CGAffineTransformConcat(scale, translate)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - @IBActions
    
    // Push Action Sender for CallButton
    @IBAction func pushOnCallButton(sender: AnyObject) {
        print("You pushed on Call Button !")
    }
    
    // Push Action Sender for MessageButton
    @IBAction func pushOnMessageButton(sender: AnyObject) {
        print("You pushed on Message Button !")
    }
    
    // Push Action Sender for editButton
    @IBAction func pushOnEditButton(sender: AnyObject) {
        print("You pushed on Edit Button !")
    }
    
    // Push Action Sender for plusButton
    @IBAction func pushOnPlusButton(sender: AnyObject) {
        if isPushed {
            whenIsPushed()
        } else {
            whenIsUnPushed()
        }
    }

    
    // MARK: - Action Methods
    func whenIsPushed() {
        self.plusButton.setTitle("+", forState: .Normal)
        scale = CGAffineTransformMakeScale(0, 0)
        translate = CGAffineTransformMakeTranslation(0.0, 0.0)
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2,options: .CurveEaseIn, animations: {
            self.editButton.transform = CGAffineTransformConcat(self.scale, self.translate)
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2,options: .CurveEaseIn, animations: {
            self.messageButton.transform = CGAffineTransformConcat(self.scale, self.translate)
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.6, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2,options: .CurveEaseIn, animations: {
            self.callButton.transform = CGAffineTransformConcat(self.scale, self.translate)
            }, completion: nil)
        
        scale = CGAffineTransformMakeScale(0.0, 0.0)
        translate = CGAffineTransformMakeTranslation(0.0, 50)
        isPushed = false
    }
    
    func whenIsUnPushed(){
        
        self.plusButton.setTitle("×", forState: .Normal)
        scale = CGAffineTransformMakeScale(1, 1)
        translate = CGAffineTransformMakeTranslation(0, 0)
        
        UIView.animateWithDuration(0.7, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2,options: .CurveEaseOut, animations: {
            self.editButton.transform = CGAffineTransformConcat(self.scale, self.translate)
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.3, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2,options: .CurveEaseOut, animations: {
            self.messageButton.transform = CGAffineTransformConcat(self.scale, self.translate)
            }, completion: nil)
        
        UIView.animateWithDuration(0.7, delay: 0.6, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.2,options: .CurveEaseOut, animations: {
            self.callButton.transform = CGAffineTransformConcat(self.scale, self.translate)
            }, completion: nil)
        
        isPushed = true
    }
}

