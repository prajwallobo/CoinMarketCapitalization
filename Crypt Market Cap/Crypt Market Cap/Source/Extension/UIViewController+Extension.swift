//
//  UIViewController+Extension.swift
//  Crypt Market Cap
//
//  Created by Prajwal Lobo on 12/03/18.
//  Copyright © 2018 Prajwal Lobo. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

extension UIViewController{

    func showHUD(with message : String? = ""){
        SVProgressHUD.show(withStatus: message)
    }
    func dismissHUD(with message : String? = ""){
        SVProgressHUD.dismiss()
    }
    func showSuccess(with message : String? = ""){
        SVProgressHUD.showSuccess(withStatus: message)
    }
}
