# DOFavoriteButton

Cute Animated Button written in Swift.
It could be just right for favorite buttons!
![Demo](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOFavoriteButton/demo.gif)

## Requirements
* iOS 7.0+

## Installation
#### CocoaPods
Add the following line to your Podfile:
```
pod 'DOFavoriteButton'
```

#### Manual
Just drag DOFavoriteButton.swift to your project.

## How to use
#### 1. Add a flat icon image
![Flat Icon Image](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOFavoriteButton/flatIconImage.png)

#### 2. Create a button
```swift
let button = DOFavoriteButton(
    frame: CGRectMake(0, 0, 44, 44), // frame of button(tappable area) (blue frame in the picture below)
    image: UIImage(named: "star.png"),
    imageFrame: CGRectMake(12, 12, 20, 20) // frame of icon image (red frame in the picture below)
)
self.view.addSubview(button)
```
![Frames](https://raw.githubusercontent.com/okmr-d/okmr-d.github.io/master/img/DOFavoriteButton/frames.png)

#### 3. Add tapped function
```swift
button.addTarget(self, action: Selector("tapped:"), forControlEvents: .TouchUpInside)
```
```swift
func tapped(sender: DOFavoriteButton) {
    if sender.selected {
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

## License
This software is released under the MIT License.
