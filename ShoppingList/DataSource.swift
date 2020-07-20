//
//  DataSource.swift
//  ShoppingList
//
//  Created by casandra grullon on 7/15/20.
//  Copyright © 2020 casandra grullon. All rights reserved.
//

import UIKit

// conforms to UITableViewDataSource
class DataSource: UITableViewDiffableDataSource<Category, Item> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if Category.allCases[section] == .shoppingCart {
            return "🛒 " + Category.allCases[section].rawValue
        } else {
            return Category.allCases[section].rawValue
        }
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            var snapshot = self.snapshot()
            if let item = itemIdentifier(for: indexPath) {
                snapshot.deleteItems([item])
                apply(snapshot, animatingDifferences: true)
            }
        }
    }
    //MARK:- Reordering tableview cells
    //Can move cell function: gives us the ui but not functionality
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    //Setting row to new index path: this function will prevent the app from crashing by removing and replacing objects from rows/sections to new rows/sections in the snapshot
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        //Get the indexpath of the Source -> Item being dragged
        guard let sourceItem = itemIdentifier(for: sourceIndexPath) else {
            return
        }
        // Scenerio 1: attempting to move to same spot
        guard sourceIndexPath != destinationIndexPath else { return }
        //1b. get the Destination item -> location of new spot
        let destinationItem = itemIdentifier(for: destinationIndexPath)
        //1c. get the current Snapshot
        var snapshot = self.snapshot()
        
        //SCENERIO 2/3: moving source after/before destination
        if let destinationItem = destinationItem {
            //2/3a. get the index (indexpath is both row and section) of both the source and destination
            if let sourceIndex = snapshot.indexOfItem(sourceItem), let destinationIndex = snapshot.indexOfItem(destinationItem) {
                
                //2/3b. check which section the object is being moved
                let isAfter = destinationIndex > sourceIndex && snapshot.sectionIdentifier(containingItem: sourceItem) == snapshot.sectionIdentifier(containingItem: destinationItem)
                //2/3c. delete the source item from the snapshot
                snapshot.deleteItems([sourceItem])
                if isAfter { //2d. insert after
                    snapshot.insertItems([sourceItem], afterItem: destinationItem)
                } else { //3d. insert before
                    snapshot.insertItems([sourceItem], beforeItem: destinationItem)
                }
            }
        } else { // SCENERIO 4: no indexpath at destination section
            //4a. get the section
            let destinationSection = snapshot.sectionIdentifiers[destinationIndexPath.section]
            //4b. delete the source item from snapshot
            snapshot.deleteItems([sourceItem])
            //4c. append source item to the new section
            snapshot.appendItems([sourceItem], toSection: destinationSection)
        }
        
        apply(snapshot, animatingDifferences: false)
    }
}
