//
//  ProductTableViewController.swift
//  ESProductSearch
//
//  Created by Jolly Crisostomo on 2019/05/06.
//  Copyright © 2019 Jolly Crisostomo. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController {

    //MARK: Properties
    
    var products = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleProducts()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIndentifier = "ProductTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIndentifier, for: indexPath) as? ProductTableViewCell else {
            fatalError("The dequeued cell is not an instance of ProductTableViewCell")
        }
        
        // Fetches the approriate meal for the data source layout
        let product = products[indexPath.row]
        
        cell.titleLabel.text = product.title
        cell.photoImageView.image = product.photo
        cell.ratingControl.rating = product.rating
        
        return cell
    }


    
    //MARK: Private Methods
    private func loadSampleProducts() {
        let photo1 = UIImage(named: "product1")
        
        for _ in 0..<10 {
            guard let product1 = Product(title: "Nike Shoe", photo: photo1, rating: 3.5, price: "", categories: "Shoes > Men") else {
                fatalError("Unable to instantiate meal1")
            }
            
            products += [product1]
        }
    }

}
