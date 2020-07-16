//
//  AddItemViewController.swift
//  ShoppingList
//
//  Created by casandra grullon on 7/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemCategoryPickerView: UIPickerView!
    @IBOutlet weak var itemPriceTextFIeld: UITextField!
    @IBOutlet weak var addToCartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func addToCartButtonPressed(_ sender: UIButton) {
    }
    
}
