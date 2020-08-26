//
//  SearchViewController.swift
//  BelanjaQ
//
//  Created by RenhardJH on 25/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tfSearch: EUITextField!
    
    var delegate: SearchDelegate?
    var searchViewModel: SearchViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOnTouchHideKeyboard()
        tableView.delegate = self
        tfSearch.delegate = self
        
        let _ = searchViewModel.product.bind(to: tableView.rx.items(cellIdentifier: "SearchViewCell", cellType: SearchViewCell.self)) { row, product, cell in
            
            if let imageUrl = URL(string: product.imageUrl) {
                cell.ivPicture.af.setImage(withURL: imageUrl)
            }
            cell.lbTitle.text = product.title
            cell.lbPrice.text = product.price
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if let selectionIndexPath = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    private func setOnTouchHideKeyboard() {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @IBAction func onCloseClick(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchViewController: UITableViewDelegate, UITextFieldDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = searchViewModel.productResults[indexPath.row]
        self.dismiss(animated: true, completion: nil)
        delegate?.onSearchResultClicked(product: product)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var searchText = "\(textField.text ?? "")"
        if range.length > 0 {
            if let index = searchText.index(searchText.startIndex, offsetBy: range.location, limitedBy: searchText.endIndex) {
                searchText.remove(at: index)
            }
        } else {
            if let index = searchText.index(searchText.startIndex, offsetBy: range.location, limitedBy: searchText.endIndex) {
                searchText.insert(contentsOf: string, at: index)
            }
        }
        
        searchViewModel.searchProducts(keyword: searchText)
        return true
    }
}

protocol SearchDelegate {
    func onSearchResultClicked(product: Product)
}

