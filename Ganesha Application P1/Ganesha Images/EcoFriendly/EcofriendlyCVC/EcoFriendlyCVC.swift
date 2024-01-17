//
//  EcoFriendlyCVC.swift
//  Ganesha Application P1
//
//  Created by Student on 15/12/23.
//

import UIKit

class EcoFriendlyCVC: UICollectionViewCell {

    @IBOutlet weak var ShareTapped: UIButton!
    @IBOutlet weak var EcoImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ShareTapped.addTarget(self, action: #selector(shareBtnTapped), for: .touchUpInside)
    }

    @objc func shareBtnTapped () {
        if let ImagesToShare = EcoImage.image {
            let items : [Any] = [ImagesToShare]
            let activityController = UIActivityViewController(activityItems: items, applicationActivities: nil)
            
            if let ViewController = UIApplication.shared.keyWindow?.rootViewController {
                ViewController.present(activityController, animated: true)            }
        }
    }
    
    @IBAction func downloadTapped(_ sender: UIButton) {
        
    }
    
    
}
