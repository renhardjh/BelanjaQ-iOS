//
//  EUITextField.swift
//  BelanjaQ
//
//  Created by RenhardJH on 24/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit

@IBDesignable
class EUITextField: UITextField {
    
//-------------------------------------Enable Left Drawable--------------------------------------------------
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftPadding: CGFloat = 0 {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if leftPadding > 0 {
            leftViewMode = UITextField.ViewMode.always
            leftView    = UIView(frame: CGRect(x: 0, y: 0, width: leftPadding, height: leftPadding))
        } else {
            leftViewMode = .never
            leftView = nil
        }
    }
//----------------------------------------Enable Left Drawable--------------------------------------------------
    
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
}
