//
//  UIColor+Extension.swift
//  Crypt Market Cap
//
//  Created by Prajwal Lobo on 12/03/18.
//  Copyright © 2018 Prajwal Lobo. All rights reserved.
//

import Foundation
import UIKit

extension Double {
    func formattedAmount() -> String {
        
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 2
        formatter.numberStyle = .currency
        formatter.currencySymbol = "₹"
        guard let amountString = formatter.string(from: NSNumber(value: self))
            else {
                return "0.00"
        }
        return amountString
    }
}

extension UIColor{
    class var greenColor: UIColor{
        get{
            return UIColor(red: 0/255, green: 255/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    class var redColor: UIColor{
        get{
            return UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1.0)
        }
    }
    
    class var navBar: UIColor{
        get{
            return UIColor(red: 0/255, green: 60/255, blue: 121/255, alpha: 1.0)
        }
    }
}
