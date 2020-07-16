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
    
    var delegate: AddItemViewControllerDelegate?
    private var pickerCatergories = Category.allCases
    private var selectedCategory: Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemCategoryPickerView.delegate = self
        itemCategoryPickerView.dataSource = self
    }

    @IBAction func addToCartButtonPressed(_ sender: UIButton) {
        guard let itemName = itemNameTextField.text, let itemCategory = selectedCategory, let itemPrice = itemPriceTextFIeld.text else {
            addToCartButton.backgroundColor = .gray
            addToCartButton.isEnabled = false
            return
        }
        addToCartButton.backgroundColor = .blue
        addToCartButton.isEnabled = true
        guard let priceAsDouble = Double(itemPrice) else {return}
        let newItem = Item(name: itemName, price: priceAsDouble, category: itemCategory)
        delegate?.didAddItem(item: newItem)
        dismiss(animated: true)
    }
    
}
extension AddItemViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerCatergories.count
    }
}
extension AddItemViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerCatergories[row].rawValue
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedCategory = pickerCatergories[row]
    }
}
