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
public class SimpleFloatingActionButton: UIButton {
    
    //PROPERTIES RIPPLE EFFECT - USAGE PROGRAMMATICALY
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
    
    //PROPERTIES RIPPLE EFFECT - USAGE INTERFACE BUILDER
    @IBInspectable var rippleOverBounds: Bool = false
    @IBInspectable var shadowRippleRadius: Float = 1
    @IBInspectable var shadowRippleEnable: Bool = true
    @IBInspectable var trackTouchLocation: Bool = false
    @IBInspectable var buttonBackgroundColor: UIColor = UIColor(red:0.96, green:0.26, blue:0.21, alpha:1.0) //Red Color Material Design
    
    //FOR DESIGN
    private let rippleView = UIView()
    private let rippleBackgroundView = UIView()
    
    //FOR DATA
    private var tempShadowRadius: CGFloat = 0
    private var tempShadowOpacity: Float = 0
    
    //MARK: INITIALISERS
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
    
    //MARK: LIFE OF VIEW
    override func layoutSubviews() {
        super.layoutSubviews()
        
        setupViewFrame()
        setupRippleView()
        
        let oldCenter = rippleView.center
        
        rippleView.center = oldCenter
        
        rippleBackgroundView.layer.frame = bounds
        rippleBackgroundView.layer.mask = rippleMask
        
    }
    
    //MARK: SETUP SimpleFloatingButton
    
    //General setup of the view
    private func setup() {
        setupViewFrame()
        setupRippleView()
        rippleBackgroundView.backgroundColor = rippleBackgroundColor
        rippleBackgroundView.frame = bounds
        layer.addSublayer(rippleBackgroundView.layer)
        
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        
        rippleBackgroundView.layer.addSublayer(rippleView.layer)
        rippleBackgroundView.alpha = 0
    }
    
    //Setup the frame view
    private func setupViewFrame(){
        
        var dim: CGFloat = 0.0
        var y: CGFloat = 0.0
        var x: CGFloat = 0.0
        
        if(UIDeviceOrientationIsLandscape(UIDevice.currentDevice().orientation)) {
            print("landscape")
            dim = UIScreen.mainScreen().bounds.height / 6
            y = UIScreen.mainScreen().bounds.height - dim - 20
            x = UIScreen.mainScreen().bounds.width - dim - 20
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.currentDevice().orientation)) {
            print("Portrait")
            dim = UIScreen.mainScreen().bounds.height / 8
            y = UIScreen.mainScreen().bounds.height - dim - 20
            x = UIScreen.mainScreen().bounds.width - dim - 20
        }
        
        let newFrame: CGRect = CGRectMake(0, 0, dim, dim)
        
        self.frame = newFrame
        self.frame = CGRectMake(x, y, self.frame.height, self.frame.height)
        self.layer.cornerRadius = 0.5 * self.frame.height
    }
    
    //Setup the ripple effect
    private func setupRippleView() {
        let size: CGFloat = CGRectGetWidth(bounds) * CGFloat(ripplePercent)
        let x: CGFloat = (CGRectGetWidth(bounds)/2) - (size/2)
        let y: CGFloat = (CGRectGetHeight(bounds)/2) - (size/2)
        let corner: CGFloat = size/2
        
        rippleView.backgroundColor = rippleColor
        rippleView.frame = CGRectMake(x, y, size, size)
        rippleView.layer.cornerRadius = corner
    }
    
    //Draw the cross on button
    override func drawRect(rect: CGRect) {
        
        let path = UIBezierPath(ovalInRect: rect)
        buttonBackgroundColor.setFill()
        path.fill()
        
        //set up the width and height variables
        //for the horizontal stroke
        let plusHeight: CGFloat = 1.0
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
        //move to the start of the vertical stroke
        plusPath.moveToPoint(CGPoint(
            x:bounds.width/2 + 0.5,
            y:bounds.height/2 - plusWidth/2 + 0.5))
        
        //add the end point to the vertical stroke
        plusPath.addLineToPoint(CGPoint(
            x:bounds.width/2 + 0.5,
            y:bounds.height/2 + plusWidth/2 + 0.5))
        
        
        //set the stroke color
        UIColor.whiteColor().setStroke()
        
        //draw the stroke
        plusPath.stroke()
        
    }

    //MARK: Handles Touch Tracking and Animations
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
    
}