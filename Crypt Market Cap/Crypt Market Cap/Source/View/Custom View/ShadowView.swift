//
//  ShadowView.swift
//  Kardia
//
//  Created by Prajwal Lobo on 12/02/18.
//  Copyright © 2018 Hashtaag. All rights reserved.
//

import UIKit

class ShadowView: UIView {
    
    @IBInspectable var shadowColor: UIColor = .black {
        didSet {
            self.updateShadow()
        }
    }
    
    @IBInspectable var shadowOffset:CGSize = CGSize(width: 0, height: 2) {
        didSet {
            self.updateShadow()
        }
    }
    
    @IBInspectable var shadowBlur:CGFloat = 1.0 {
        didSet {
            self.updateShadow()
        }
    }
    
    @IBInspectable var shadowOpacity:Float = 1.0 {
        didSet {
            self.updateShadow()
        }
    }
    
    @IBInspectable var cornerRadius:CGFloat = 0.0 {
        didSet {
            self.updateShadow()
        }
    }
    
    
    func updateShadow() {
        self.clipsToBounds = false
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowBlur
        self.layer.shadowOpacity = shadowOpacity
        
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        
        self.layer.shadowPath = path.cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let path = UIBezierPath(roundedRect: self.bounds, cornerRadius: cornerRadius)
        self.layer.shadowPath = path.cgPath
    }


}
