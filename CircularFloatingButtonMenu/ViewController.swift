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
    
    // TODO: End This !
    func plusButtonRotation () {
        let duration = 0.6
        let delay = 0.0
        let options = UIViewKeyframeAnimationOptions.CalculationModeLinear
        let fullRotation = CGFloat(M_PI * 2)
        
        UIView.animateKeyframesWithDuration(duration, delay: delay, options: options, animations: {
            // each keyframe needs to be added here
            // within each keyframe the relativeStartTime and relativeDuration need to be values between 0.0 and 1.0
            
            UIView.addKeyframeWithRelativeStartTime(0, relativeDuration: 1/3, animations: {
                // start at 0.00s (5s × 0)
                // duration 1.67s (5s × 1/3)
                // end at   1.67s (0.00s + 1.67s)
                self.plusButton.transform = CGAffineTransformMakeRotation(1/3 * fullRotation)
            })
            UIView.addKeyframeWithRelativeStartTime(1/3, relativeDuration: 1/3, animations: {
                self.plusButton.transform = CGAffineTransformMakeRotation(2/3 * fullRotation)
            })
            UIView.addKeyframeWithRelativeStartTime(2/3, relativeDuration: 1/3, animations: {
                self.plusButton.transform = CGAffineTransformMakeRotation(3/3 * fullRotation)
            })
            
            }, completion: {finished in
                // any code entered here will be applied
                // once the animation has completed
                
        })

    }





    // MARK: - Action Methods
    func whenIsPushed() {
        plusButtonRotation()
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
        plusButtonRotation()
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

