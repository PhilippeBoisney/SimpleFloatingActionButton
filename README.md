# Floating Action Button (Material Design)

[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)
[![License](http://img.shields.io/badge/license-MIT-lightgrey.svg?style=flat
)](http://mit-license.org)

Floating Action Button (inspired by [Google Material Design](https://www.google.com/design/spec/components/buttons-floating-action-button.html#)) for iOS written in Swift 2.0

Please feel free to make pull requests :)

![alt tag](https://raw.githubusercontent.com/Phil69/Simple-Floating-Action-Button/master/application.gif)

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
## Version
1.1

## Requirements

- iOS >= 7.0

## Author

Philippe BOISNEY (phil.boisney(@)gmail.com)

## Credit

This library is based on Zoonooz (Amornchai Kanokpullwad) work (https://github.com/zoonooz/ZFRippleButton). Thanks a lot to him !
