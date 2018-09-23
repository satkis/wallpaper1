//
//  FloatingSettingsButton.swift
//  wallpaper
//
//  Created by satkis on 9/23/18.
//  Copyright © 2018 satkis. All rights reserved.
//

import UIKit

class FloatingSettingsButton: UIButtonX {
    
    override func beginTracking(_ touch: UITouch, with event: UIEvent?) -> Bool {
        
        UIView.animate(withDuration: 0.3, animations: {
            if self.transform == .identity {
                self.transform = CGAffineTransform(rotationAngle: 90 * (.pi / 180))
            } else {
                self.transform = .identity
            }
        })
        
        return super.beginTracking(touch, with: event)
    }
    
    
}
