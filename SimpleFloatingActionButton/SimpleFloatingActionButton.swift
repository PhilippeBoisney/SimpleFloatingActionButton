//
//  SimpleFloatingActionButton.swift
//  SimpleFloatingActionButton
//
//  Created by Phil on 14/08/2015.
//  Copyright © 2015 CookMinute. All rights reserved.
//

import UIKit
import QuartzCore

@IBDesignable
class SimpleFloatingActionButton: UIButton {   
    
    var ripplePercent: Float = 2.0 {
        didSet {
            setupRippleView()
        }
    }
    
    var rippleColor: UIColor = UIColor(white: 0.9, alpha: 1) {
        didSet {
            rippleView.backgroundColor = rippleColor
        }
    }
    
    var rippleBackgroundColor: UIColor = UIColor(white: 0.95, alpha: 1) {
        didSet {
            rippleBackgroundView.backgroundColor = rippleBackgroundColor
        }
    }
    
    var buttonCornerRadius: Float = 0 {
        didSet{
            layer.cornerRadius = CGFloat(buttonCornerRadius)
        }
    }
    
    @IBInspectable var rippleOverBounds: Bool = false
    @IBInspectable var shadowRippleRadius: Float = 1
    @IBInspectable var shadowRippleEnable: Bool = true
    @IBInspectable var trackTouchLocation: Bool = false
    @IBInspectable var buttonBackgroundColor: UIColor = UIColor(red:0.96, green:0.26, blue:0.21, alpha:1.0) //Red Color Material Design
    @IBInspectable var isAddButton: Bool = true
    
    let rippleView = UIView()
    let rippleBackgroundView = UIView()
    
    private var tempShadowRadius: CGFloat = 0
    private var tempShadowOpacity: Float = 0
    
    private var rippleMask: CAShapeLayer? {
        get {
            if !rippleOverBounds {
                let maskLayer = CAShapeLayer()
                maskLayer.path = UIBezierPath(roundedRect: bounds,
                    cornerRadius: layer.cornerRadius).CGPath
                return maskLayer
            } else {
                return nil
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init () {
        super.init(frame: CGRectZero)
        setup()
    }
    private func setup() {
        setupView()
        setupRippleView()
        rippleBackgroundView.backgroundColor = rippleBackgroundColor
        rippleBackgroundView.frame = bounds
        layer.addSublayer(rippleBackgroundView.layer)
        
        
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
        rippleBackgroundView.layer.addSublayer(rippleView.layer)
        rippleBackgroundView.alpha = 0
    }
    
    private func setupView(){
        
        let dim = UIScreen.mainScreen().bounds.height / 8
        let y = UIScreen.mainScreen().bounds.height * 0.8
        let x = UIScreen.mainScreen().bounds.width * 0.73
        
        let newFrame: CGRect = CGRectMake(0, 0, dim, dim)
        
        self.frame = newFrame
        self.frame = CGRectMake(x, y, self.frame.height, self.frame.height)
        self.layer.cornerRadius = 0.5 * self.frame.height
        
        
    }
    
    private func setupRippleView() {
        let size: CGFloat = CGRectGetWidth(bounds) * CGFloat(ripplePercent)
        let x: CGFloat = (CGRectGetWidth(bounds)/2) - (size/2)
        let y: CGFloat = (CGRectGetHeight(bounds)/2) - (size/2)
        let corner: CGFloat = size/2
        
        rippleView.backgroundColor = rippleColor
        rippleView.frame = CGRectMake(x, y, size, size)
        rippleView.layer.cornerRadius = corner
    }
    
    override func drawRect(rect: CGRect) {
        
        let path = UIBezierPath(ovalInRect: rect)
        buttonBackgroundColor.setFill()
        path.fill()
        
        //set up the width and height variables
        //for the horizontal stroke
        let plusHeight: CGFloat = 3.0
        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.3
        
        //create the path
        let plusPath = UIBezierPath()
        
        //set the path's line width to the height of the stroke
        plusPath.lineWidth = plusHeight
        
        //move the initial point of the path
        //to the start of the horizontal stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 - plusWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        //add a point to the path at the end of the stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + plusWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        //Vertical Line
        if isAddButton {
            //move to the start of the vertical stroke
            plusPath.moveToPoint(CGPoint(
                x:bounds.width/2 + 0.5,
                y:bounds.height/2 - plusWidth/2 + 0.5))
            
            //add the end point to the vertical stroke
            plusPath.addLineToPoint(CGPoint(
                x:bounds.width/2 + 0.5,
                y:bounds.height/2 + plusWidth/2 + 0.5))
        }
        
        //set the stroke color
        UIColor.whiteColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
        
    }

    
    override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        if trackTouchLocation {
            rippleView.center = touch.locationInView(self)
        }
        
        UIView.animateWithDuration(0.1,
            animations: {
                self.rippleBackgroundView.alpha = 1
            }, completion: nil)
        
        rippleView.transform = CGAffineTransformMakeScale(0.1, 0.1)
        
        UIView.animateWithDuration(0.7, delay: 0, options: .CurveEaseOut,
            animations: {
                self.rippleView.transform = CGAffineTransformIdentity
            }, completion: nil)
        
        if shadowRippleEnable {
            tempShadowRadius = layer.shadowRadius
            tempShadowOpacity = layer.shadowOpacity
            
            let shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
            shadowAnim.toValue = shadowRippleRadius
            
            let opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
            opacityAnim.toValue = 1
            
            let groupAnim = CAAnimationGroup()
            groupAnim.duration = 0.7
            groupAnim.fillMode = kCAFillModeForwards
            groupAnim.removedOnCompletion = false
            groupAnim.animations = [shadowAnim, opacityAnim]
            
            layer.addAnimation(groupAnim, forKey:"shadow")
        }
        return super.beginTrackingWithTouch(touch, withEvent: event)
    }
    
    override func cancelTrackingWithEvent(event: UIEvent?) {
        super.cancelTrackingWithEvent(event)
        animateToNormal()
    }
    
    override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
        animateToNormal()
    }
    
    private func animateToNormal(){
        UIView.animateWithDuration(0.1,
            animations: {
                self.rippleBackgroundView.alpha = 1
            },
            completion: {(success: Bool) -> () in
                UIView.animateWithDuration(0.6 ,
                    animations: {
                        self.rippleBackgroundView.alpha = 0
                    }, completion: nil)
            }
        )
        
        UIView.animateWithDuration(0.7, delay: 0,
            options: .CurveEaseOut,
            animations: {
                self.rippleView.transform = CGAffineTransformIdentity
                
                let shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
                shadowAnim.toValue = self.tempShadowRadius
                
                let opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
                opacityAnim.toValue = self.tempShadowOpacity
                
                let groupAnim = CAAnimationGroup()
                groupAnim.duration = 0.7
                groupAnim.fillMode = kCAFillModeForwards
                groupAnim.removedOnCompletion = false
                groupAnim.animations = [shadowAnim, opacityAnim]
                
                self.layer.addAnimation(groupAnim, forKey:"shadowBack")
            }, completion: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupView()
        
        let oldCenter = rippleView.center
        setupRippleView()
        rippleView.center = oldCenter
        
        rippleBackgroundView.layer.frame = bounds
        rippleBackgroundView.layer.mask = rippleMask
        
    }
    
}