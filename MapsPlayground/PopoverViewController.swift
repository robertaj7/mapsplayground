//
//  PopoverViewController.swift
//  MapsPlayground
//
//  Created by Roberta Jorgo on 5.2.21.
//

import UIKit

class PopoverViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // Now for making work scrollView from storyboard you should:
    
//    1. Put a scroll view into the view controller and set constraints (leading, top, trailing, bottom - all 0)
//    2. Put a view(contentView) inside the scroll view and set constraints (leading, top, trailing, bottom - all 0)
//    3. In views hierarchy, do ctrl drag from new View(contentView) to Content Layout guide of scrollView and in the appeared context menu choose all constraints (leading, top, trailing, bottom - all 0)
//    4. If we want to make the scrollview scroll only vertically, create an equal width constraint between the view and the scrollview's Frame Layout guide (for horizontally create equal height constraint)
//    5. Place all your content view elements inside it and create all vertical constraints in the way that the top and the bottom of the contentView must be connected by constraints inside it.

}
