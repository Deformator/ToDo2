/*
 * File name: CustomTextView.swift
 * App Name: ToDo2
 * Authors: Andrii Damm, Tarun Singh
 * Student IDs: 300966307, 300967393
 * Date: December 29, 2017
 * Version: 1.0 - Internal documentation added.
 * Description: Custom rounded UITextView for our app.
 * Copyright © 2017 Andrii Damm. All rights reserved.
 */

import UIKit

@IBDesignable
class CustomTextView: UITextView {

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor = UIColor.clear{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
    
}
