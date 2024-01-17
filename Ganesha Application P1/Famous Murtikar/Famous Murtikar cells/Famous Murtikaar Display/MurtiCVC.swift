//
//  MurtiCVC.swift
//  Ganesha Application P1
//
//  Created by Jon Snow on 26/12/23.
//

import UIKit
import SDWebImage

struct image : Codable {
    var images : String?
}



class MurtiCVC: UIViewController {
    
    @IBOutlet weak var HeadImg: UIImageView!
    @IBOutlet weak var HeadLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var FMurtiData : Murtikar?
    
    var  ImageData : [image] =
    [
        image(images: "address ICON"),
        image(images: "phone ICON")
    ]
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "MurtiDispCVC", bundle: .main), forCellWithReuseIdentifier: "MurtiDispCVC")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.reloadData()
        let url = URL(string: FMurtiData?.image ?? "")
        self.HeadImg.sd_setImage(with: url)
        self.HeadLabel.text = FMurtiData?.name ?? ""
    }
}

extension MurtiCVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.row == 0){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MurtiDispCVC", for: indexPath) as! MurtiDispCVC
            cell.imgDisp.image = UIImage(named: ImageData[indexPath.row].images ?? "")
            cell.LabelDisp.text = FMurtiData?.location
            return cell
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MurtiDispCVC", for: indexPath) as! MurtiDispCVC
            cell.imgDisp.image = UIImage(named: ImageData[indexPath.row].images ?? "")
            cell.LabelDisp.text = FMurtiData?.contact
            return cell
        }
    }
}
extension MurtiCVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 20)/1)
        let height = width / 3
        return CGSize(width: width, height: height)
    }
}

