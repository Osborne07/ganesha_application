//
//  MandalDisplay.swift
//  Ganesha Application P1
//
//  Created by Jon Snow on 21/12/23.
//

import UIKit
import SDWebImage

struct Images : Codable{
    var images : String
}

class MandalDisplay: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var TopImage: UIImageView!
    @IBOutlet weak var TitleLabel: UILabel!
    
    var FMandalData : FamousMandals?
    var ImageData : [Images] = 
    [
        Images(images: "address ICON"),
        Images(images: "route ICON")
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "DMCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "DMCollectionViewCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
        let url = URL(string: FMandalData?.image ?? "")
        self.TopImage.sd_setImage(with: url)
        self.TitleLabel.text = FMandalData?.title ?? ""
        
    }
}
extension MandalDisplay: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DMCollectionViewCell", for: indexPath) as! DMCollectionViewCell
            cell.MDLabel.text = FMandalData?.location ?? ""
            cell.MDImage.image = UIImage(named: ImageData[indexPath.row].images)
            print(FMandalData?.title ?? "")
            
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DMCollectionViewCell", for: indexPath) as! DMCollectionViewCell
            cell.MDLabel.text = FMandalData?.how_to_reach ?? ""
            cell.MDImage.image = UIImage(named: ImageData[indexPath.row].images)
            print(FMandalData?.title ?? "")
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
}

//------------------------------------------------------ Cell Design --------------------------------------------------

extension MandalDisplay: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 35, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 40
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 25
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 20)/1)
        let height = width / 5
        return CGSize(width: width, height: height)
    }
}
