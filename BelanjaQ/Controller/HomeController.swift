//
//  HomeController.swift
//  BelanjaQ
//
//  Created by RenhardJH on 24/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.tableHeaderView = CategoryView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 120))
        
        if let userStr = UserDefaults.standard.object(forKey: "user") as? String {
            if let user = CodableObject.decodeToObject(type: User.self, data: userStr) {
                print("HomeController: \(user)")
            }
        }
        
        viewModel.getData()
        
        if let categoryView = tableView.tableHeaderView as? CategoryView {
            let _ = viewModel.category.bind(to: categoryView.collectionView.rx.items(cellIdentifier: "CategoryViewCell", cellType: CategoryViewCell.self)) { row, category, cell in
                
                if let imageUrl = URL(string: category.imageUrl) {
                    cell.ivPicture.af.setImage(withURL: imageUrl)
                }
                cell.lbName.text = category.name
            }
        }
        
        let _ = viewModel.product.bind(to: tableView.rx.items(cellIdentifier: "ProductViewCell", cellType: ProductViewCell.self)) { row, product, cell in
            
            if let imageUrl = URL(string: product.imageUrl) {
                cell.ivPicture.af.setImage(withURL: imageUrl)
            }
            cell.lbTitle.text = product.title
            cell.lbPrice.text = product.price
            cell.setLike(isLike: product.loved == 1)
            
            self.indicator.isHidden = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let tabVC = self.parent {
            tabVC.navigationItem.title = "Home"
        }
        
        if let selectionIndexPath = tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: selectionIndexPath, animated: animated)
        }
    }
    
    @IBAction func onButtonClick(_ button: UIButton) {
        switch button.accessibilityIdentifier {
        case "btnSearch":
            if let searchVC = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController {
                searchVC.modalPresentationStyle = .fullScreen
                searchVC.delegate = self
                searchVC.searchViewModel = SearchViewModel(products: viewModel.productList)
                self.present(searchVC, animated: true, completion: nil)
            }
            break
        default:
            break
        }
    }
}

extension HomeController: UITableViewDelegate, SearchDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let product = viewModel.productList[indexPath.row]
        openProductDetail(product)
    }
    
    func onSearchResultClicked(product: Product) {
        openProductDetail(product)
    }
    
    private func openProductDetail(_ product: Product) {
        if let detailProductVC = storyboard?.instantiateViewController(withIdentifier: "DetailProductController") as? DetailProductController {
            detailProductVC.modalPresentationStyle = .fullScreen
            detailProductVC.viewModel = DetailProductViewModel(product: product)
            if let tabVC = self.parent {
                tabVC.navigationController?.pushViewController(detailProductVC, animated: true)
            }
        }
    }
}
