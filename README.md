# DOFavoriteButtonNew
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/DOFavoriteButtonNew.svg?style=flat)](http://cocoapods.org/pods/DOFavoriteButtonNew)
[![Platform](https://img.shields.io/cocoapods/p/DOFavoriteButtonNew.svg?style=flat)](http://cocoapods.org/pods/DOFavoriteButtonNew)
[![License](https://img.shields.io/cocoapods/l/DOFavoriteButtonNew.svg?style=flat)](https://github.com/ghostlordstar/DOFavoriteButton/blob/master/LICENSE)

Cute Animated Button written in Swift.
It could be just right for favorite buttons!
![Demo](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOFavoriteButton/demo.gif)

## Statement
DOFavoriteButton-new is based on the [DOFavoriteButton](https://github.com/okmr-d/DOFavoriteButton).

## Requirements
* iOS 8.0+
* Swift 5.0

## Installation
#### Carthage
Add the following line to your `Cartfile`:
```
github "ghostlordstar/DOFavoriteButtonNew"
```

#### CocoaPods
Add the following line to your `Podfile`:
```
pod 'DOFavoriteButtonNew'
```

#### Manual
Just drag DOFavoriteButtonNew.swift to your project.

## How to use
#### 1. Add a flat icon image
![Flat Icon Image](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOFavoriteButton/flatIconImage.png)

#### 2. Create a button
##### ・By coding
```swift
let button = DOFavoriteButtonNew(frame: CGRect(x: 100, y:100, width: 44, height: 44), image: UIImage(named: "star.png"))
self.view.addSubview(button)
```

##### ・By using Storyboard or XIB
1. Add Button object and set Custom Class `DOFavoriteButtonNew`  
![via Storyboard](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOFavoriteButton/storyboard.png)

2. Connect Outlet  
![connect outlet](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOFavoriteButton/connect.png)

#### 3. Add tapped function
```swift
button.addTarget(self, action: Selector("tapped:"), forControlEvents: .TouchUpInside)
```
```swift
func tapped(sender: DOFavoriteButtonNew) {
    if sender.isSelected {
        // deselect
        sender.deselect()
    } else {
        // select with animation
        sender.select()
    }
}
```

## Customize
You can change button color & animation duration:
```swift
button.imageColorOff = UIColor.brownColor()
button.imageColorOn = UIColor.redColor()
button.circleColor = UIColor.greenColor()
button.lineColor = UIColor.blueColor()
button.duration = 3.0 // default: 1.0
```
Result:  
![Customize](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOFavoriteButton/changeColor.gif)

## DEMO
There is a demo project added to this repository, so you can see how it works.

## Credit/Inspiration
DOFavoriteButtonNew was inspired by [Twitter's iOS App](https://itunes.apple.com/us/app/twitter/id333903271).

## License
This software is released under the MIT License.
