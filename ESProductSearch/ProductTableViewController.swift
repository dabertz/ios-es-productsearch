//
//  ProductTableViewController.swift
//  ESProductSearch
//
//  Created by Jolly Crisostomo on 2019/05/06.
//  Copyright © 2019 Jolly Crisostomo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ProductTableViewController: UITableViewController, UISearchBarDelegate {

    //MARK: Properties
    var products = [Product]()
    var host = "http://localhost:9200"

    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadProducts(keyword: nil)
        
        searchBar.delegate = self
        tableView.tableHeaderView = searchBar
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
        cell.priceLabel.text = product.price
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "ShowDetail":
            guard let productDetailViewController = segue.destination as? ProductViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedProductCell = sender as? ProductTableViewCell else {
                fatalError("Unexpected sender: \(sender)")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedProductCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedProduct = products[indexPath.row]
            productDetailViewController.product = selectedProduct
        default:
            fatalError("Unexpected Segue Identifier; \(segue.identifier)")
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        searchBar.showsCancelButton = true
        let keyword = searchBar.text!.lowercased()
        print(keyword)
        loadProducts(keyword: searchBar.text!.lowercased())
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = false
        self.view.endEditing(true)
        searchBar.text = ""
        loadProducts(keyword: nil)
    }

    //MARK: Actions
    @IBAction func unwindToProductList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ProductViewController, let product = sourceViewController.product {
            
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                // Update an existing product.
                products[selectedIndexPath.row] = product
                tableView.reloadRows(at: [selectedIndexPath], with: .none)
            }
            else {
                // Add a new produc.
                let newIndexPath = IndexPath(row: products.count, section: 0)
                
                products.append(product)
                tableView.insertRows(at: [newIndexPath], with: .automatic)
            }
            
        }
    }
    
    //MARK: Private Methods
    private func loadProducts(keyword: String?) {
        products = []
        
        let url = "\(host)/amazon/products/_search"
        let size = 10000
        var parameters: Parameters = [
            "size": size
        ]

        if keyword != nil  {
            parameters["q"] = keyword
        }
        
        Alamofire.request(url, method: .get, parameters: parameters)
            .validate()
            .responseJSON { response in
                guard response.result.isSuccess,
                    let value = response.result.value else {
                        print("Error while fetching tags:\(String(describing: response.result.error))")
                        return
                }
                
                let records = JSON(value)["hits"]["hits"]
                for item in records {
                    let(_, v) = item
                    let title = v["_source"]["title"].stringValue

                    var image: UIImage?
                    let urlString = v["_source"]["image_url"].stringValue
                    let rate = v["_source"]["review_rate"].floatValue
                    let price = v["_source"]["price"].stringValue
                    let categories = v["_source"]["categories"].arrayValue.map {$0.stringValue}
                    let catString = categories.joined(separator: " > ")
        
                    let url = NSURL(string: urlString)! as URL
                    if let imageData: NSData = NSData(contentsOf: url) {
                        image = UIImage(data: imageData as Data)
                    }
                    
                    guard let product = Product(title: title, photo: image, rating: rate, price: price, categories: catString) else {
                        fatalError("Unable to instantiate Product")
                    }

                    self.products += [product]
                }
                
                self.tableView.reloadData()
                
        }
    }

}
