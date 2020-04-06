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
public class SimpleButton: UIButton {
    
    //PROPERTIES RIPPLE EFFECT - USAGE PROGRAMMATICALY
    public var ripplePercent: Float = 2.0 {
        didSet {
            setupRippleView()
        }
    }
    
    public var rippleColor: UIColor = UIColor(white: 0.9, alpha: 1) {
        didSet {
            rippleView.backgroundColor = rippleColor
        }
    }
    
    public var rippleBackgroundColor: UIColor = UIColor(white: 0.95, alpha: 1) {
        didSet {
            rippleBackgroundView.backgroundColor = rippleBackgroundColor
        }
    }
    
    private var rippleMask: CAShapeLayer? {
        get {
            if !rippleOverBounds {
                let maskLayer = CAShapeLayer()
                maskLayer.path = UIBezierPath(roundedRect: bounds,
                cornerRadius: layer.cornerRadius).cgPath
                return maskLayer
            } else {
                return nil
            }
        }
    }
    
    //PROPERTIES RIPPLE EFFECT - USAGE INTERFACE BUILDER
    @IBInspectable public var rippleOverBounds: Bool = false
    @IBInspectable public var shadowRippleRadius: Float = 1
    @IBInspectable public var shadowRippleEnable: Bool = true
    @IBInspectable public var trackTouchLocation: Bool = false
    @IBInspectable public var buttonBackgroundColor: UIColor = UIColor(red:0.96, green:0.26, blue:0.21, alpha:1.0) //Red Color Material Design
    
    //FOR DESIGN
    private let rippleView = UIView()
    private let rippleBackgroundView = UIView()
    
    //FOR DATA
    private var tempShadowRadius: CGFloat = 0
    private var tempShadowOpacity: Float = 0
    
    //MARK: INITIALISERS
    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    init () {
        super.init(frame: CGRect())
        setup()
    }
    
    //MARK: LIFE OF VIEW
    override public func layoutSubviews() {
        super.layoutSubviews()
        
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
        
        //Defaull Value
        var dim: CGFloat = UIScreen.main.bounds.height / 8
        var y: CGFloat = UIScreen.main.bounds.height - dim - 20
        var x: CGFloat = UIScreen.main.bounds.width - dim - 20
        
        if(UIDevice.current.orientation.isLandscape) {
            dim = UIScreen.main.bounds.height / 6
            y = UIScreen.main.bounds.height - dim - 20
            x = UIScreen.main.bounds.width - dim - 20
        }
        
        
        let newFrame: CGRect = CGRect(x: 0, y: 0, width: dim, height: dim)
        
        self.frame = newFrame
        self.frame = CGRect(x: x, y: y, width: self.frame.height, height: self.frame.height)
        self.layer.cornerRadius = 0.5 * self.frame.height
    }
    
    //Setup the ripple effect
    private func setupRippleView() {
        let size: CGFloat = bounds.width * CGFloat(ripplePercent)
        let x: CGFloat = (bounds.width/2) - (size/2)
        let y: CGFloat = (bounds.height/2) - (size/2)
        let corner: CGFloat = size/2
        
        rippleView.backgroundColor = rippleColor
        rippleView.frame = CGRect(x: x, y: y, width: size, height: size)
        rippleView.layer.cornerRadius = corner
    }
    
    //Draw the cross on button
    override public func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(ovalIn: rect)
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
        plusPath.move(to: CGPoint(
            x:bounds.width/2 - plusWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        //add a point to the path at the end of the stroke
        plusPath.addLine(to: CGPoint(
            x:bounds.width/2 + plusWidth/2 + 0.5,
            y:bounds.height/2 + 0.5))
        
        //Vertical Line
        //move to the start of the vertical stroke
        plusPath.move(to: CGPoint(
            x:bounds.width/2 + 0.5,
            y:bounds.height/2 - plusWidth/2 + 0.5))
        
        //add the end point to the vertical stroke
        plusPath.addLine(to: CGPoint(
            x:bounds.width/2 + 0.5,
            y:bounds.height/2 + plusWidth/2 + 0.5))
        
        
        //set the stroke color
        UIColor.white.setStroke()
        
        //draw the stroke
        plusPath.stroke()
        
    }
    
    //MARK: Handles Touch Tracking and Animations
    override public func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        if trackTouchLocation {
            rippleView.center = touch.location(in: self)
        }
        
        UIView.animate(withDuration: 0.1,
            animations: {
                self.rippleBackgroundView.alpha = 1
            }, completion: nil)
        
        rippleView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseOut, animations: {self.rippleView.transform = CGAffineTransform()}, completion: nil)
        
        
        if shadowRippleEnable {
            tempShadowRadius = layer.shadowRadius
            tempShadowOpacity = layer.shadowOpacity
            
            let shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
            shadowAnim.toValue = shadowRippleRadius
            
            let opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
            opacityAnim.toValue = 1
            
            let groupAnim = CAAnimationGroup()
            groupAnim.duration = 0.7
            groupAnim.fillMode = CAMediaTimingFillMode.forwards
            groupAnim.isRemovedOnCompletion = false
            groupAnim.animations = [shadowAnim, opacityAnim]
            
            layer.add(groupAnim, forKey:"shadow")
        }
        return super.beginTracking(touch, with: event)
    }
    
    override public func cancelTracking(with event: UIEvent?) {
        super.cancelTracking(with: event)
        animateToNormal()
    }
    
    override public func endTracking(_ touch: UITouch?, with event: UIEvent?) {
        super.endTracking(touch, with: event)
        animateToNormal()
    }
    
    private func animateToNormal(){
        UIView.animate(withDuration: 0.1,
            animations: {
                self.rippleBackgroundView.alpha = 1
            },
            completion: {(success: Bool) -> () in
                UIView.animate(withDuration: 0.6 ,
                    animations: {
                        self.rippleBackgroundView.alpha = 0
                    }, completion: nil)
            }
        )
        
        UIView.animate(withDuration: 0.7, delay: 0,
            options: .curveEaseOut,
            animations: {
                self.rippleView.transform = CGAffineTransform()
                
                let shadowAnim = CABasicAnimation(keyPath:"shadowRadius")
                shadowAnim.toValue = self.tempShadowRadius
                
                let opacityAnim = CABasicAnimation(keyPath:"shadowOpacity")
                opacityAnim.toValue = self.tempShadowOpacity
                
                let groupAnim = CAAnimationGroup()
                groupAnim.duration = 0.7
                groupAnim.fillMode = CAMediaTimingFillMode.forwards
                groupAnim.isRemovedOnCompletion = false
                groupAnim.animations = [shadowAnim, opacityAnim]
                
                self.layer.add(groupAnim, forKey:"shadowBack")
            }, completion: nil)
    }
    
}
