//
//  PurchasedHistoryCell.swift
//  BelanjaQ
//
//  Created by RenhardJH on 26/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit

class PurchasedHistoryCell: UITableViewCell {
    @IBOutlet weak var ivPicture: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbDate: UILabel!
    
    private var isLiked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivPicture.layer.cornerRadius = 4
        ivPicture.layer.shadowColor = UIColor.black.cgColor
    }
}
