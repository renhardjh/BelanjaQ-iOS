//
//  ProductViewModel.swift
//  BelanjaQ
//
//  Created by RenhardJH on 25/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON

public final class HomeViewModel {
    
    var category = BehaviorRelay<[CategoryProduct]>(value: [])
    var product = BehaviorRelay<[Product]>(value: [])
    var categoryProductList = [CategoryProduct]()
    var productList = [Product]()
    
    func getData(){
        guard let url = URL(string: "https://private-4639ce-ecommerce56.apiary-mock.com/home") else {return}
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                if let data = data {
                    let json = try JSON(data: data)
                    let categoryData = try json[0]["data"]["category"].rawData()
                    let productData = try json[0]["data"]["productPromo"].rawData()
                    self.categoryProductList = try JSONDecoder().decode([CategoryProduct].self, from: categoryData)
                    self.productList = try JSONDecoder().decode([Product].self, from: productData)
                    self.category.accept(self.categoryProductList)
                    self.product.accept(self.productList)
                }
            } catch let err{
                print(err)
            }
        }.resume()
        
    }
}
