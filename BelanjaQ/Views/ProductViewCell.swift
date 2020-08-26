//
//  ProductViewCell.swift
//  BelanjaQ
//
//  Created by RenhardJH on 25/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit

class ProductViewCell: UITableViewCell {
    @IBOutlet weak var ivPicture: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    private var isLiked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ivPicture.layer.cornerRadius = 4
        ivPicture.layer.shadowColor = UIColor.black.cgColor
    }
    
    func setLike(isLike: Bool) {
        let image = isLike ? UIImage(named: "ic_fav") :  UIImage(named: "ic_unfav")
        let imageTint = image?.withRenderingMode(.alwaysTemplate)
        btnLike.setImage(imageTint, for: .normal)
        btnLike.tintColor = .red
        self.isLiked = isLike
    }
    
    @IBAction func onLikeClick(_ button: UIButton) {
        setLike(isLike: !isLiked)
    }
}
