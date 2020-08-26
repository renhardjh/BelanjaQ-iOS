//
//  DetailProductController.swift
//  BelanjaQ
//
//  Created by RenhardJH on 26/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit

class DetailProductController: UIViewController {
    @IBOutlet weak var ivPicture: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbPrice: UILabel!
    @IBOutlet weak var lbDescription: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    
    var viewModel: DetailProductViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let imageUrl = URL(string: viewModel.product.imageUrl) {
            ivPicture.af.setImage(withURL: imageUrl)
        }
        lbTitle.text = viewModel.product.title
        lbPrice.text = viewModel.product.price
        lbDescription.text = viewModel.product.description
        setLike(isLike: viewModel.product.loved == 1)
    }
    
    @IBAction func onButtonClick(_ button: UIButton) {
        switch button.accessibilityIdentifier {
        case "btnLike":
            setLike(isLike: viewModel.product.loved  != 1)
            break
        case "btnBuy":
            viewModel.saveProductHistory()
            
            let alert = UIAlertController(title: "Success", message: "Product Purchased.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
            break;
        default:
            break
        }
    }
    
    func setLike(isLike: Bool) {
        let image = isLike ? UIImage(named: "ic_fav") :  UIImage(named: "ic_unfav")
        let imageTint = image?.withRenderingMode(.alwaysTemplate)
        btnLike.setImage(imageTint, for: .normal)
        btnLike.tintColor = .red
        viewModel.product.loved = isLike ? 1 : 0
    }
}
