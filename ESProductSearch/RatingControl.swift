//
//  RatingControl.swift
//  ESProductSearch
//
//  Created by Jolly Crisostomo on 2019/05/06.
//  Copyright © 2019 Jolly Crisostomo. All rights reserved.
//

import UIKit

@IBDesignable class RatingControl: UIStackView {
    
    //MARK: Properties
    private var ratingButtons = [UIButton]()
    @IBInspectable var starSize: CGSize = CGSize(width: 32.0, height: 32.0) {
        didSet {
            setupButtons()
        }
    }
    @IBInspectable var starCount: Int = 5 {
        didSet {
            setupButtons()
        }
    }
    
    var rating: Float = 4.0 {
        didSet {
            updateButtonSelectionStates()
        }
    }
    
    //MARK: Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    
    required init(coder: NSCoder){
        super.init(coder: coder)
        setupButtons()
    }

    //MARK: Private Methods
    private func setupButtons() {
        
        // Load button images
        let bundle = Bundle(for: type(of:self))
        let emptyStar = UIImage(named: "emptyStar", in: bundle, compatibleWith: self.traitCollection)
        
        // clear any existing buttons
        for button in ratingButtons {
            removeArrangedSubview(button)
            button.removeFromSuperview()
        }
        
        ratingButtons.removeAll()
        
        for _ in 0..<5 {
            // Create the button
            let button = UIButton()
            // Set the buttons images
            button.setImage(emptyStar, for: .normal)
            
            // Add constraints
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: starSize.height).isActive = true
            button.widthAnchor.constraint(equalToConstant: starSize.width).isActive = true
            
            // Setup the button action
            
            // Add the new button to the stack
            addArrangedSubview(button)
            
            ratingButtons.append(button)
        }
        
        updateButtonSelectionStates()
    }
    
    private func updateButtonSelectionStates() {
        // Load button images
        let bundle = Bundle(for: type(of:self))
        let filledStar = UIImage(named: "filledStar", in: bundle, compatibleWith: self.traitCollection)
        let halfStar = UIImage(named: "halfStar", in: bundle, compatibleWith: self.traitCollection)
        
        for(index, button) in ratingButtons.enumerated() {
            // If the index of a button is less than the rating, that button should be selected
            let r: Int = Int(ceil(rating))
            button.isSelected = index < r
            print(index)
            if rating >= Float(index+1) {
                button.setImage(filledStar, for: .selected)
            } else {
                button.setImage(halfStar, for: .selected)
            }
        }
    }
}
