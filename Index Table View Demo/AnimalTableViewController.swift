//
//  AnimalTableViewController.swift
//  Index Table View Demo
//
//  Created by Sorfian on 25/03/23.
//

import UIKit

class AnimalTableViewController: UITableViewController {
    
    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    lazy var dataSource = configureDataSource()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Populate data
        tableView.dataSource = dataSource
        
        updateSnapshot()

    }

}

extension AnimalTableViewController {
    func configureDataSource() -> UITableViewDiffableDataSource<String, String> {

         let dataSource = UITableViewDiffableDataSource<String, String>(tableView: tableView) { (tableView, indexPath, animalName) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            
            // Configure the cell...
            cell.textLabel?.text = animalName
            
            // Convert the animal name to lower case and
            // then replace all occurences of a space with an underscore
            let imageFileName = animalName.lowercased().replacingOccurrences(of: " ", with: "_")
            cell.imageView?.image = UIImage(named: imageFileName)
            
            
            return cell
        }

        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {

        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(["all"])
        snapshot.appendItems(animals, toSection: "all")

        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
