//
//  SearchViewCell.swift
//  BelanjaQ
//
//  Created by RenhardJH on 25/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit

class SearchViewCell: UITableViewCell {
    @IBOutlet weak var ivPicture: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    
    private var isLiked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivPicture.layer.cornerRadius = 4
        ivPicture.layer.shadowColor = UIColor.black.cgColor
    }
}
