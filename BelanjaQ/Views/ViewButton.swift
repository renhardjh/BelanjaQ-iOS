//
//  ViewButton.swift
//  BelanjaQ
//
//  Created by RenhardJH on 25/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit

protocol ClickHandler {
    func onClick(view: UIView)
}

class ViewButton: UIView {
    var clickHandler: ClickHandler!             //Click handler required protocol
    var clickAction: ((_ view: UIView)->Void)?
    var gestureLongPress: UILongPressGestureRecognizer = UILongPressGestureRecognizer()
    private var isShrinking: Bool = false
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.isUserInteractionEnabled = true
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.isUserInteractionEnabled = true
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with:event)
        if !self.isShrinking {
            self.doAnimateViewShrink()
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        if !self.isShrinking {
            self.doAnimateViewShrink()
        }
        //print("TouchMoved")
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.doAnimateViewDefault()
        if clickHandler != nil {
            clickHandler.onClick(view: self)
        }
        if let handler = self.clickAction {
            handler(self)
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        self.doAnimateViewDefault()
    }
    
    func setOnCLickHandler(handler: ClickHandler) {
        clickHandler = handler
    }
    
    private func setupGesture() {
        self.gestureLongPress = UILongPressGestureRecognizer(target: self, action: #selector(actionLongPressGesture(sender:)))
        self.gestureLongPress.numberOfTouchesRequired = 1
        self.gestureLongPress.numberOfTapsRequired = 1
        self.gestureLongPress.minimumPressDuration = 0.3
        self.gestureLongPress.delaysTouchesBegan = true
        self.addGestureRecognizer(gestureLongPress)
        
    }
    
    @objc func actionLongPressGesture(sender: UILongPressGestureRecognizer) {
        self.doAnimateViewShrink()
    }
    private func doAnimateViewShrink() {
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(0.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
        },
                       completion: { Void in()  }
        )
    }
    
    func doAnimateViewDefault() {
        UIView.animate(withDuration: 2.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.20),
                       initialSpringVelocity: CGFloat(0.0),
                       options: UIView.AnimationOptions.allowUserInteraction,
                       animations: {
                        self.transform = CGAffineTransform(scaleX: 1, y: 1)
        },
                       completion: { Void in()
                        self.isShrinking = false
        }
            
        )
    }
}
