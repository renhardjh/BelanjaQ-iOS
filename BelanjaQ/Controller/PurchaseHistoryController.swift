//
//  PurchaseHistoryController.swift
//  BelanjaQ
//
//  Created by RenhardJH on 26/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit

class PurchaseHistoryController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lbNoData: UILabel!
    
    var viewModel = PurchaseHistoryViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        
        let _ = viewModel.history.bind(to: tableView.rx.items(cellIdentifier: "PurchasedHistoryCell", cellType: PurchasedHistoryCell.self)) { row, history, cell in
            
            if let imageUrl = URL(string: history.imageUrl) {
                cell.ivPicture.af.setImage(withURL: imageUrl)
            }
            cell.lbDate.text = history.date
            cell.lbTitle.text = history.title
            cell.lbPrice.text = history.price
            
            self.lbNoData.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let tabVC = self.parent {
            tabVC.navigationItem.title = "Purchased History"
        }
        
        viewModel.loadHistory()
        lbNoData.isHidden = false
    }
}

extension PurchaseHistoryController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.getProduct(at: indexPath.row)
        if let detailProductVC = storyboard?.instantiateViewController(withIdentifier: "DetailProductController") as? DetailProductController {
            detailProductVC.modalPresentationStyle = .fullScreen
            detailProductVC.viewModel = DetailProductViewModel(product: product)
            if let tabVC = self.parent {
                tabVC.navigationController?.pushViewController(detailProductVC, animated: true)
            }
        }
    }
}
