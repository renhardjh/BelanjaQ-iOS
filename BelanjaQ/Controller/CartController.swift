//
//  CartController.swift
//  BelanjaQ
//
//  Created by RenhardJH on 25/08/20.
//  Copyright © 2020 RenhardJH. All rights reserved.
//

import UIKit

class CartController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let tabVC = self.parent {
            tabVC.navigationItem.title = "Cart"
        }
    }
}
