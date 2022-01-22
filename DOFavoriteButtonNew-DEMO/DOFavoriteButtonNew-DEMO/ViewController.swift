//
//  ViewController.swift
//  DOFavoriteButton-DEMO
//
//  Created by Daiki Okumura on 2015/07/09.
//  Copyright (c) 2015 Daiki Okumura. All rights reserved.
//

import UIKit
import DOFavoriteButtonNew
class ViewController: UIViewController {

    @IBOutlet var heartButton: DOFavoriteButtonNew!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let width = (self.view.frame.width - 44) / 4
        var x = width / 2
        let y = 100.0
        
        // star button
        let starButton = DOFavoriteButtonNew(frame: CGRect(x: x, y: y, width: 44, height: 44), image: UIImage(named: "star"))
        starButton.addTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        self.view.addSubview(starButton)
        x += width
        
        // heart button
        let heartButton = DOFavoriteButtonNew(frame: CGRect(x: x, y: y, width: 44, height: 44), image: UIImage(named: "heart"))
        heartButton.imageColorOn = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        heartButton.circleColor = UIColor(red: 254/255, green: 110/255, blue: 111/255, alpha: 1.0)
        heartButton.lineColor = UIColor(red: 226/255, green: 96/255, blue: 96/255, alpha: 1.0)
        heartButton.addTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        self.view.addSubview(heartButton)
        x += width
        
        // like button
        let likeButton = DOFavoriteButtonNew(frame: CGRect(x: x, y: y, width: 44, height: 44), image: UIImage(named: "like"))
        likeButton.imageColorOn = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        likeButton.circleColor = UIColor(red: 52/255, green: 152/255, blue: 219/255, alpha: 1.0)
        likeButton.lineColor = UIColor(red: 41/255, green: 128/255, blue: 185/255, alpha: 1.0)
        likeButton.addTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        self.view.addSubview(likeButton)
        x += width
        
        // smile button
        let smileButton = DOFavoriteButtonNew(frame: CGRect(x: x, y: y, width: 44, height: 44), image: UIImage(named: "smile"))
        smileButton.imageColorOn = UIColor(red: 45/255, green: 204/255, blue: 112/255, alpha: 1.0)
        smileButton.circleColor = UIColor(red: 45/255, green: 204/255, blue: 112/255, alpha: 1.0)
        smileButton.lineColor = UIColor(red: 45/255, green: 195/255, blue: 106/255, alpha: 1.0)
        smileButton.addTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        self.view.addSubview(smileButton)
        
        self.heartButton.addTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        
        
        // star button
        let bigStarButton = DOFavoriteButtonNew(frame: CGRect(x: (self.view.frame.width - 100.0) / 2.0, y: (self.view.frame.height - 100.0)/2.0 , width: 100, height: 100), image: UIImage(named: "star"))
        bigStarButton.addTarget(self, action: #selector(self.tappedButton), for: .touchUpInside)
        self.view.addSubview(bigStarButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func tappedButton(sender: DOFavoriteButtonNew) {
        if sender.isSelected {
            sender.deselect()
        } else {
            sender.select()
        }
    }
}

