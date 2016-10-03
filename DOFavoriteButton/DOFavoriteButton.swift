//
//  DOFavoriteButton.swift
//  DOFavoriteButton
//
//  Created by Daiki Okumura on 2015/07/09.
//  Copyright (c) 2015 Daiki Okumura. All rights reserved.
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit

@IBDesignable
open class DOFavoriteButton: UIButton {

    fileprivate var imageShape: CAShapeLayer!
    @IBInspectable open var image: UIImage! {
        didSet {
            createLayers(image: image)
        }
    }
    @IBInspectable open var imageColorOn: UIColor! = UIColor(red: 255/255, green: 172/255, blue: 51/255, alpha: 1.0) {
        didSet {
            if (isSelected) {
                imageShape.fillColor = imageColorOn.cgColor
            }
        }
    }
    @IBInspectable open var imageColorOff: UIColor! = UIColor(red: 136/255, green: 153/255, blue: 166/255, alpha: 1.0) {
        didSet {
            if (!isSelected) {
                imageShape.fillColor = imageColorOff.cgColor
            }
        }
    }

    fileprivate var circleShape: CAShapeLayer!
    fileprivate var circleMask: CAShapeLayer!
    @IBInspectable open var circleColor: UIColor! = UIColor(red: 255/255, green: 172/255, blue: 51/255, alpha: 1.0) {
        didSet {
            circleShape.fillColor = circleColor.cgColor
        }
    }

    fileprivate var lines: [CAShapeLayer]!
    @IBInspectable open var lineColor: UIColor! = UIColor(red: 250/255, green: 120/255, blue: 68/255, alpha: 1.0) {
        didSet {
            for line in lines {
                line.strokeColor = lineColor.cgColor
            }
        }
    }

    fileprivate let circleTransform = CAKeyframeAnimation(keyPath: "transform")
    fileprivate let circleMaskTransform = CAKeyframeAnimation(keyPath: "transform")
    fileprivate let lineStrokeStart = CAKeyframeAnimation(keyPath: "strokeStart")
    fileprivate let lineStrokeEnd = CAKeyframeAnimation(keyPath: "strokeEnd")
    fileprivate let lineOpacity = CAKeyframeAnimation(keyPath: "opacity")
    fileprivate let imageTransform = CAKeyframeAnimation(keyPath: "transform")

    @IBInspectable open var duration: Double = 1.0 {
        didSet {
            circleTransform.duration = 0.333 * duration // 0.0333 * 10
            circleMaskTransform.duration = 0.333 * duration // 0.0333 * 10
            lineStrokeStart.duration = 0.6 * duration //0.0333 * 18
            lineStrokeEnd.duration = 0.6 * duration //0.0333 * 18
            lineOpacity.duration = 1.0 * duration //0.0333 * 30
            imageTransform.duration = 1.0 * duration //0.0333 * 30
        }
    }

    override open var isSelected : Bool {
        didSet {
            if (isSelected != oldValue) {
                if isSelected {
                    imageShape.fillColor = imageColorOn.cgColor
                } else {
                    deselect()
                }
            }
        }
    }

    public convenience init() {
        self.init(frame: CGRect.zero)
    }

    public override convenience init(frame: CGRect) {
        self.init(frame: frame, image: UIImage())
    }

    public init(frame: CGRect, image: UIImage!) {
        super.init(frame: frame)
        self.image = image
        createLayers(image: image)
        addTargets()
    }

    public required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        createLayers(image: UIImage())
        addTargets()
    }

    fileprivate func createLayers(image: UIImage!) {
        self.layer.sublayers = nil

        let imageFrame = CGRect(x: frame.size.width / 2 - frame.size.width / 4, y: frame.size.height / 2 - frame.size.height / 4, width: frame.size.width / 2, height: frame.size.height / 2)
        let imgCenterPoint = CGPoint(x: imageFrame.midX, y: imageFrame.midY)
        let lineFrame = CGRect(x: imageFrame.origin.x - imageFrame.width / 4, y: imageFrame.origin.y - imageFrame.height / 4 , width: imageFrame.width * 1.5, height: imageFrame.height * 1.5)

        //===============
        // circle layer
        //===============
        circleShape = CAShapeLayer()
        circleShape.bounds = imageFrame
        circleShape.position = imgCenterPoint
        circleShape.path = UIBezierPath(ovalIn: imageFrame).cgPath
        circleShape.fillColor = circleColor.cgColor
        circleShape.transform = CATransform3DMakeScale(0.0, 0.0, 1.0)
        self.layer.addSublayer(circleShape)

        circleMask = CAShapeLayer()
        circleMask.bounds = imageFrame
        circleMask.position = imgCenterPoint
        circleMask.fillRule = kCAFillRuleEvenOdd
        circleShape.mask = circleMask

        let maskPath = UIBezierPath(rect: imageFrame)
        maskPath.addArc(withCenter: imgCenterPoint, radius: 0.1, startAngle: CGFloat(0.0), endAngle: CGFloat(M_PI * 2), clockwise: true)
        circleMask.path = maskPath.cgPath

        //===============
        // line layer
        //===============
        lines = []
        for i in 0 ..< 5 {
            let line = CAShapeLayer()
            line.bounds = lineFrame
            line.position = imgCenterPoint
            line.masksToBounds = true
            line.actions = ["strokeStart": NSNull(), "strokeEnd": NSNull()]
            line.strokeColor = lineColor.cgColor
            line.lineWidth = 1.25
            line.miterLimit = 1.25
            line.path = {
                let path = CGMutablePath()
                path.move(to: CGPoint(x: lineFrame.midX, y: lineFrame.midY))
                path.addLine(to: CGPoint(x: lineFrame.origin.x + lineFrame.width / 2, y: lineFrame.origin.y))
                return path
                }()
            line.lineCap = kCALineCapRound
            line.lineJoin = kCALineJoinRound
            line.strokeStart = 0.0
            line.strokeEnd = 0.0
            line.opacity = 0.0
            line.transform = CATransform3DMakeRotation(CGFloat(M_PI) / 5 * (CGFloat(i) * 2 + 1), 0.0, 0.0, 1.0)
            self.layer.addSublayer(line)
            lines.append(line)
        }

        //===============
        // image layer
        //===============
        imageShape = CAShapeLayer()
        imageShape.bounds = imageFrame
        imageShape.position = imgCenterPoint
        imageShape.path = UIBezierPath(rect: imageFrame).cgPath
        imageShape.fillColor = imageColorOff.cgColor
        imageShape.actions = ["fillColor": NSNull()]
        self.layer.addSublayer(imageShape)

        imageShape.mask = CALayer()
        imageShape.mask!.contents = image.cgImage
        imageShape.mask!.bounds = imageFrame
        imageShape.mask!.position = imgCenterPoint

        //==============================
        // circle transform animation
        //==============================
        circleTransform.duration = 0.333 // 0.0333 * 10
        circleTransform.values = [
            NSValue(caTransform3D: CATransform3DMakeScale(0.0,  0.0,  1.0)),    //  0/10
            NSValue(caTransform3D: CATransform3DMakeScale(0.5,  0.5,  1.0)),    //  1/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.0,  1.0,  1.0)),    //  2/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.2,  1.2,  1.0)),    //  3/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.3,  1.3,  1.0)),    //  4/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.37, 1.37, 1.0)),    //  5/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.4,  1.4,  1.0)),    //  6/10
            NSValue(caTransform3D: CATransform3DMakeScale(1.4,  1.4,  1.0))     // 10/10
        ]
        circleTransform.keyTimes = [
            0.0,    //  0/10
            0.1,    //  1/10
            0.2,    //  2/10
            0.3,    //  3/10
            0.4,    //  4/10
            0.5,    //  5/10
            0.6,    //  6/10
            1.0     // 10/10
        ]

        circleMaskTransform.duration = 0.333 // 0.0333 * 10
        circleMaskTransform.values = [
            NSValue(caTransform3D: CATransform3DIdentity),                                                              //  0/10
            NSValue(caTransform3D: CATransform3DIdentity),                                                              //  2/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageFrame.width * 1.25,  imageFrame.height * 1.25,  1.0)),   //  3/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageFrame.width * 2.688, imageFrame.height * 2.688, 1.0)),   //  4/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageFrame.width * 3.923, imageFrame.height * 3.923, 1.0)),   //  5/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageFrame.width * 4.375, imageFrame.height * 4.375, 1.0)),   //  6/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageFrame.width * 4.731, imageFrame.height * 4.731, 1.0)),   //  7/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageFrame.width * 5.0,   imageFrame.height * 5.0,   1.0)),   //  9/10
            NSValue(caTransform3D: CATransform3DMakeScale(imageFrame.width * 5.0,   imageFrame.height * 5.0,   1.0))    // 10/10
        ]
        circleMaskTransform.keyTimes = [
            0.0,    //  0/10
            0.2,    //  2/10
            0.3,    //  3/10
            0.4,    //  4/10
            0.5,    //  5/10
            0.6,    //  6/10
            0.7,    //  7/10
            0.9,    //  9/10
            1.0     // 10/10
        ]

        //==============================
        // line stroke animation
        //==============================
        lineStrokeStart.duration = 0.6 //0.0333 * 18
        lineStrokeStart.values = [
            0.0,    //  0/18
            0.0,    //  1/18
            0.18,   //  2/18
            0.2,    //  3/18
            0.26,   //  4/18
            0.32,   //  5/18
            0.4,    //  6/18
            0.6,    //  7/18
            0.71,   //  8/18
            0.89,   // 17/18
            0.92    // 18/18
        ]
        lineStrokeStart.keyTimes = [
            0.0,    //  0/18
            0.056,  //  1/18
            0.111,  //  2/18
            0.167,  //  3/18
            0.222,  //  4/18
            0.278,  //  5/18
            0.333,  //  6/18
            0.389,  //  7/18
            0.444,  //  8/18
            0.944,  // 17/18
            1.0,    // 18/18
        ]

        lineStrokeEnd.duration = 0.6 //0.0333 * 18
        lineStrokeEnd.values = [
            0.0,    //  0/18
            0.0,    //  1/18
            0.32,   //  2/18
            0.48,   //  3/18
            0.64,   //  4/18
            0.68,   //  5/18
            0.92,   // 17/18
            0.92    // 18/18
        ]
        lineStrokeEnd.keyTimes = [
            0.0,    //  0/18
            0.056,  //  1/18
            0.111,  //  2/18
            0.167,  //  3/18
            0.222,  //  4/18
            0.278,  //  5/18
            0.944,  // 17/18
            1.0,    // 18/18
        ]

        lineOpacity.duration = 1.0 //0.0333 * 30
        lineOpacity.values = [
            1.0,    //  0/30
            1.0,    // 12/30
            0.0     // 17/30
        ]
        lineOpacity.keyTimes = [
            0.0,    //  0/30
            0.4,    // 12/30
            0.567   // 17/30
        ]

        //==============================
        // image transform animation
        //==============================
        imageTransform.duration = 1.0 //0.0333 * 30
        imageTransform.values = [
            NSValue(caTransform3D: CATransform3DMakeScale(0.0,   0.0,   1.0)),  //  0/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.0,   0.0,   1.0)),  //  3/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.2,   1.2,   1.0)),  //  9/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.25,  1.25,  1.0)),  // 10/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.2,   1.2,   1.0)),  // 11/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.9,   0.9,   1.0)),  // 14/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.875, 0.875, 1.0)),  // 15/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.875, 0.875, 1.0)),  // 16/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.9,   0.9,   1.0)),  // 17/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.013, 1.013, 1.0)),  // 20/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.025, 1.025, 1.0)),  // 21/30
            NSValue(caTransform3D: CATransform3DMakeScale(1.013, 1.013, 1.0)),  // 22/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.96,  0.96,  1.0)),  // 25/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.95,  0.95,  1.0)),  // 26/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.96,  0.96,  1.0)),  // 27/30
            NSValue(caTransform3D: CATransform3DMakeScale(0.99,  0.99,  1.0)),  // 29/30
            NSValue(caTransform3D: CATransform3DIdentity)                       // 30/30
        ]
        imageTransform.keyTimes = [
            0.0,    //  0/30
            0.1,    //  3/30
            0.3,    //  9/30
            0.333,  // 10/30
            0.367,  // 11/30
            0.467,  // 14/30
            0.5,    // 15/30
            0.533,  // 16/30
            0.567,  // 17/30
            0.667,  // 20/30
            0.7,    // 21/30
            0.733,  // 22/30
            0.833,  // 25/30
            0.867,  // 26/30
            0.9,    // 27/30
            0.967,  // 29/30
            1.0     // 30/30
        ]
    }

    fileprivate func addTargets() {
        //===============
        // add target
        //===============
        self.addTarget(self, action: #selector(DOFavoriteButton.touchDown(_:)), for: UIControlEvents.touchDown)
        self.addTarget(self, action: #selector(DOFavoriteButton.touchUpInside(_:)), for: UIControlEvents.touchUpInside)
        self.addTarget(self, action: #selector(DOFavoriteButton.touchDragExit(_:)), for: UIControlEvents.touchDragExit)
        self.addTarget(self, action: #selector(DOFavoriteButton.touchDragEnter(_:)), for: UIControlEvents.touchDragEnter)
        self.addTarget(self, action: #selector(DOFavoriteButton.touchCancel(_:)), for: UIControlEvents.touchCancel)
    }

    func touchDown(_ sender: DOFavoriteButton) {
        self.layer.opacity = 0.4
    }
    func touchUpInside(_ sender: DOFavoriteButton) {
        self.layer.opacity = 1.0
    }
    func touchDragExit(_ sender: DOFavoriteButton) {
        self.layer.opacity = 1.0
    }
    func touchDragEnter(_ sender: DOFavoriteButton) {
        self.layer.opacity = 0.4
    }
    func touchCancel(_ sender: DOFavoriteButton) {
        self.layer.opacity = 1.0
    }

    open func select() {
        isSelected = true
        imageShape.fillColor = imageColorOn.cgColor

        CATransaction.begin()

        circleShape.add(circleTransform, forKey: "transform")
        circleMask.add(circleMaskTransform, forKey: "transform")
        imageShape.add(imageTransform, forKey: "transform")

        for i in 0 ..< 5 {
            lines[i].add(lineStrokeStart, forKey: "strokeStart")
            lines[i].add(lineStrokeEnd, forKey: "strokeEnd")
            lines[i].add(lineOpacity, forKey: "opacity")
        }

        CATransaction.commit()
    }

    open func deselect() {
        isSelected = false
        imageShape.fillColor = imageColorOff.cgColor

        // remove all animations
        circleShape.removeAllAnimations()
        circleMask.removeAllAnimations()
        imageShape.removeAllAnimations()
        lines[0].removeAllAnimations()
        lines[1].removeAllAnimations()
        lines[2].removeAllAnimations()
        lines[3].removeAllAnimations()
        lines[4].removeAllAnimations()
    }
}
