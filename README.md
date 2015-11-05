# Floating Action Button (Material Design)

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

Floating Action Button (inspired by [Google Material Design](https://www.google.com/design/spec/components/buttons-floating-action-button.html#)) for iOS written in Swift 2.0

Please feel free to make pull requests :)

![alt tag](https://github.com/PhilippeBoisney/Simple-Floating-Action-Button/blob/master/demo.gif)

## INSTALLATION
Simply add **SimpleFloatingActionButton.swift** file on your project.

## USAGE
```swift
//Simply, Call Button
let plusButton: SimpleFloatingActionButton = SimpleFloatingActionButton()

//Add action event
plusButton.addTarget(self, action: "touchUpInsidePlusButton", forControlEvents: .TouchUpInside)

//Add to the view
self.view.addSubview(plusButton)
```

**OPTIONS**
```swift
//Change background color of SimpleFloatingActionButton
plusButton.buttonBackgroundColor = UIColor(red:0.96, green:0.26, blue:0.21, alpha:1.0) // Default is red from Material Design color
//Change ripple effect design
plusButton.ripplePercent = 2 //Default is '2' and I don't recommend to change it (Simply because It's beautiful like that)
plusButton.rippleBackgroundColor = UIColor.greenColor()
plusButton.rippleColor = UIColor.redColor()
```

## FEATURES

- [x] Multi-Device Full Support
- [x] Rotation Support
- [x] Material Design Effect

## Version
1.3

## Requirements

- iOS >= 7.0

## Author

Philippe BOISNEY (phil.boisney(@)gmail.com)

## Credit

Ripple effect is based on Zoonooz (Amornchai Kanokpullwad) work (https://github.com/zoonooz/ZFRippleButton). Thanks a lot to him !
