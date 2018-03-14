//
//  CoinLoadMoreTableViewCell.swift
//  Crypt Market Cap
//
//  Created by Prajwal Lobo on 13/03/18.
//  Copyright © 2018 Prajwal Lobo. All rights reserved.
//

import UIKit

class CoinLoadMoreTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    class func cellNib() -> UINib{
        return UINib(nibName: "CoinLoadMoreTableViewCell", bundle: nil)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
