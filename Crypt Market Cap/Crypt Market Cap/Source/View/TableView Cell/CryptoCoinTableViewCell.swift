//
//  CryptoCoinTableViewCell.swift
//  Crypt Market Cap
//
//  Created by Prajwal Lobo on 12/03/18.
//  Copyright © 2018 Prajwal Lobo. All rights reserved.
//

import UIKit

class CryptoCoinTableViewCell: UITableViewCell {
    
    //IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var price1HLabel: UILabel!
    @IBOutlet weak var price24hLabel: UILabel!
    @IBOutlet weak var price7dLabel: UILabel!
    @IBOutlet weak var coinImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func cellNib() -> UINib
    {
        return UINib(nibName: "CryptoCoinTableViewCell", bundle: nil)
    }
    
    var coin : Coin?{
        didSet{
            if let symbol = coin?.symbol.lowercased(){
                if let image = UIImage(named : "\(symbol).png"){
                    coinImageView.image = image
                }
            }
            nameLabel.text = (coin?.name)!+" (\(coin?.symbol ?? ""))"
            let value = Double(coin!.priceINR!) //Price will be present for sure
            priceLabel.text = value?.formattedAmount()
            if let price1h = coin?.percentChange1Hour{
                if price1h.hasPrefix("-"){
                    price1HLabel.textColor = .redColor
                }else{
                    price1HLabel.textColor = .greenColor

                }
                price1HLabel.text = coin?.percentChange1Hour
            }
            
            if let price24h = coin?.percentChange24Hour{
                if (price24h.hasPrefix("-")){
                    price24hLabel.textColor = .redColor
                }else{
                    price24hLabel.textColor = .greenColor
                    
                }
                price24hLabel.text = coin?.percentChange24Hour
            }
 
            
            if let price7d = coin?.percentChange7Days{
            if price7d.hasPrefix("-"){
                price7dLabel.textColor = .redColor
            }else{
                price7dLabel.textColor = .greenColor
                
                }
                price7dLabel.text = coin?.percentChange7Days
            }
            price7dLabel.text = coin?.percentChange7Days
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
