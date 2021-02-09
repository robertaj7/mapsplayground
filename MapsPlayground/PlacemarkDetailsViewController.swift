//
//  PlacemarkDetailsViewController.swift
//  MapsPlayground
//
//  Created by Roberta Jorgo on 3.2.21.
//

import UIKit

class PlacemarkDetailsViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var website: UILabel!
    @IBOutlet weak var telephone: UITextView!
    
    @IBAction func backButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    let phoneLink = "tel://1234567"
    
    @IBOutlet weak var dynamicPopoverButton: UIButton!
    @IBAction func popoverButtonPressed(_ sender: Any) {
        if let popoverViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopoverViewController") as? PopoverViewController {
            popoverViewController.modalPresentationStyle = .popover
            popoverViewController.popoverPresentationController?.sourceView = dynamicPopoverButton
   
        self.present(popoverViewController, animated: true)
        }
    }
    
    @IBAction func popupButtonPressed(_ sender: Any) {
        PopupViewController.showPopup(parentVC: self) {
            print("test")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        name.text = "Bashkia"
        website.text = "http://google.com"
    
        /// website
        let recogniser = UITapGestureRecognizer(target: self, action: #selector(PlacemarkDetailsViewController.tapWebsite))
        website.addGestureRecognizer(recogniser)
        
        /// phone
        let originalText = "Call this number for more information."
        let attributedOriginalText = NSMutableAttributedString(string: originalText)
        
        let linkRange = attributedOriginalText.mutableString.range(of: "this number")
        attributedOriginalText.addAttribute(.link, value: phoneLink, range: linkRange)
        
        telephone.attributedText = attributedOriginalText
        telephone.delegate = self
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        if (URL.absoluteString == phoneLink) {
            UIApplication.shared.open(URL)
        }
        return false
    }
    
    @objc func tapWebsite(sender: UITapGestureRecognizer) {
        let urlString = "https://google.com"
        
        guard let url = URL(string: urlString) else { return }

        UIApplication.shared.open(url)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopover" {
            print("test")
        }
    }
}
