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
    
    var animalsDict = [String: [String]]()
    var animalSectionTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        Generate the animal dictionary
        createAnimalDict()
        
        // Populate data
        tableView.dataSource = dataSource
        tableView.separatorStyle = .none
        
        updateSnapshot()
    }

}

extension AnimalTableViewController {
    func configureDataSource() -> AnimalTableDataSource {

         let dataSource = AnimalTableDataSource(tableView: tableView) { (tableView, indexPath, animalName) -> UITableViewCell? in
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "animalcell", for: indexPath)
            
            // Configure the cell...
            cell.textLabel?.text = animalName
            
            // Convert the animal name to lower case and
            // then replace all occurences of a space with an underscore
            let imageFileName = animalName.lowercased().replacingOccurrences(of: " ", with: "_")
            cell.imageView?.image = UIImage(named: imageFileName)
             
             let view = UIView()
             view.backgroundColor = .systemGray
             cell.selectedBackgroundView = view
            
            
            return cell
        }

        return dataSource
    }
    
    func updateSnapshot(animatingChange: Bool = false) {

        // Create a snapshot and populate the data
        var snapshot = NSDiffableDataSourceSnapshot<String, String>()
        snapshot.appendSections(animalSectionTitles)
        animalSectionTitles.forEach { section in
            if let animals = animalsDict[section] {
                snapshot.appendItems(animals, toSection: section)
            }
        }

        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    private func createAnimalDict() {
        for animal in animals {
//            Get the first letter of the animal name and build the dictionary
            let firstLetterIndex = animal.index(animal.startIndex, offsetBy: 1)
            let animalKey = String(animal[..<firstLetterIndex])
            
            if var animalValues = animalsDict[animalKey] {
                animalValues.append(animal)
                animalsDict[animalKey] = animalValues
            } else {
                animalsDict[animalKey] = [animal]
            }
            
//            Get the section titles from the dictionary's keys and sort them in ascending order
            animalSectionTitles = [String](animalsDict.keys)
            animalSectionTitles.sort(by: { $0 < $1})
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.backgroundView?.backgroundColor = UIColor(red: 236.0/255.0, green: 240.0/255.0, blue: 241.0/255.0, alpha: 1.0)
        headerView.textLabel?.textColor = UIColor(red: 231.0/255.0, green: 76.0/255.0, blue: 60.0/255.0, alpha: 1.0)
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
