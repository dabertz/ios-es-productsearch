//
//  ProductViewController.swift
//  ESProductSearch
//
//  Created by Jolly Crisostomo on 2019/05/01.
//  Copyright © 2019 Jolly Crisostomo. All rights reserved.
//

import UIKit

class ProductViewController: UIViewController {

    //MARK: Properties
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var ratingControl: RatingControl!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var product: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        if let product = product {
            titleLabel.text = product.title
            photoImageView.image = product.photo
            priceLabel.text = product.price
            categoryLabel.text = product.categories
        }

    }
    
    //MARK: Navigation
   @IBAction func cancel(_ sender: UIBarButtonItem) {
        // Depending on style of presentation (modal or push presentation), this view controller needs to be dismissed in two different ways.
        let isPresentingInAddMealMode = presentingViewController is UINavigationController
        if isPresentingInAddMealMode {
            dismiss(animated: true, completion: nil)
        }
        else if let owningNavigationController = navigationController{
            owningNavigationController.popViewController(animated: true)
        }
        else {
            fatalError("The MealViewController is not inside a navigation controller.")
        }
    }


}

