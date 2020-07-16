//
//  ViewController.swift
//  ShoppingList
//
//  Created by casandra grullon on 7/15/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var tableView: UITableView!
    private var dataSource: DataSource! // subclass we created
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configureNavBar()
        configureTableView()
        configureTableViewDataSource()
    }
    
    private func configureNavBar() {
        navigationItem.title = "Shopping List"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(toggleEditState))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(presentAddVC))
    }

    private func configureTableView() {
        tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.backgroundColor = .systemGroupedBackground
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.addSubview(tableView)
    }
    
    private func configureTableViewDataSource() {
        dataSource = DataSource(tableView: tableView, cellProvider: { (tableView, indexPath, item) -> UITableViewCell? in
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = "\(item.name)"
            cell.detailTextLabel?.text = "\(item.price)"
            return cell
        })
        
        //setup animation type
        dataSource.defaultRowAnimation = .middle
        
        //setup initial snapshot
        var snapshot = NSDiffableDataSourceSnapshot<Category, Item>()
        
        //populate snapshot with sections and items for each section
        for category in Category.allCases {
            //filter the testData() items for that category
            let items = Item.testData().filter {$0.category == category}
            snapshot.appendSections([category])
            snapshot.appendItems(items)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
    
    @objc private func toggleEditState() {
        
    }
    
    @objc private func presentAddVC() {
        //TODO:
        //1. create a AddItemViewController file & storyboard object
        //2. add 2 textfields -> name, price
        //3. add picker to manage categories
        //4. user can add new item to a category by pressing submit button
        //5. persist new object to first vc (delegation, KVO, notification center, unwind segue)
    }
}

//extension ViewController: AddItemViewControllerDelegate {
//    func didAddItem(item: Item) {
//        var snapshot = dataSource.snapshot()
//
//        snapshot.appendItems([item], toSection: item.category)
//
//        dataSource.apply(snapshot, animatingDifferences: true)
//    }
//}
