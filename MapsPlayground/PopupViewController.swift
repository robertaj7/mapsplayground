//
//  PopupViewController.swift
//  MapsPlayground
//
//  Created by Roberta Jorgo on 5.2.21.
//

import UIKit

class PopupViewController: UIViewController {

    @IBOutlet weak var dialogBoxView: UIView!
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var data1: UILabel!
    @IBOutlet weak var data2: UILabel!
    @IBOutlet weak var data3: UILabel!
    
    @IBOutlet weak var okayButton: UIButton!
    @IBAction func okayPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    lazy var completionFunction: (() -> Void)? = {}
    
    @IBAction func completionPressed(_ sender: Any) {
        completionFunction?()
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.black.withAlphaComponent(0.50)
        //customizing the dialog box view
        dialogBoxView.layer.cornerRadius = 6.0
        dialogBoxView.layer.borderWidth = 1.2
        dialogBoxView.layer.borderColor = UIColor.gray.cgColor
            //customizing the okay button
        okayButton.backgroundColor = UIColor.darkGray.withAlphaComponent(0.85)
        okayButton.setTitleColor(UIColor.white, for: .normal)
        okayButton.layer.cornerRadius = 4.0
        okayButton.layer.borderWidth = 1.2
        okayButton.layer.borderColor = UIColor.darkGray.cgColor
    }

    static func showPopup(parentVC: UIViewController, completion: (() -> Void)?) {
        //creating a reference for the dialogView controller
        if let popupViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopupViewController") as? PopupViewController {
        popupViewController.modalPresentationStyle = .custom
        popupViewController.modalTransitionStyle = .crossDissolve
        //presenting the pop up viewController from the parent viewController
            
        popupViewController.completionFunction = completion
            
        parentVC.present(popupViewController, animated: true)
        }
    }
}
