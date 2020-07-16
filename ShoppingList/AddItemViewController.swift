//
//  AddItemViewController.swift
//  ShoppingList
//
//  Created by casandra grullon on 7/16/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

protocol AddItemViewControllerDelegate {
    func didAddItem(item: Item)
}

class AddItemViewController: UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemCategoryPickerView: UIPickerView!
    @IBOutlet weak var itemPriceTextFIeld: UITextField!
    @IBOutlet weak var addToCartButton: UIButton!
    
    //var delegate: AddItemViewControllerDelegate?
    private var pickerCatergories = [Category]()
    private var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemCategoryPickerView.dataSource = self
        itemCategoryPickerView.delegate = self
    }

    @IBAction func addToCartButtonPressed(_ sender: UIButton) {
        //guard let itemName = itemNameTextField.text,
       // let newItem = Item(name: itemNameTextField.text, price: <#T##Double#>, category: <#T##Category#>)
    }
    
}
extension AddItemViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerCatergories[component].rawValue
    }
}
extension AddItemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return pickerCatergories.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 1
    }
}

