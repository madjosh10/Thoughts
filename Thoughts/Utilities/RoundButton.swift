//
//  RoundButton.swift
//  ExactPrice
//
//  Created by Joshua Madrigal on 4/13/18.
//  Copyright © 2018 Joshua Madrigal. All rights reserved.
//

import UIKit

/*
 Three separate initializer functions are called based on what context the RoundButton is created in:
 
 init(frame:) is for programmatically created buttons
 init?(coder:) is for Storyboard/.xib created buttons
 prepareForInterfaceBuilder() is called within the Storyboard editor itself for rendering @IBDesignable controls
 */

@IBDesignable class RoundButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        refreshCorners(value: cornerRadius)
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
        
    }
    
    @IBInspectable var cornerRadius: CGFloat = 15 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
} // end RoundButton class

