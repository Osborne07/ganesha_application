//
//  GimgVC.swift
//  Ganesha Application P1
//
//  Created by Student on 08/12/23.
//

import UIKit

struct TypesOfImages : Codable{
    var image : String
    var name : String
}


class GimgVC: UIViewController {
    
    let GaneshaImages : [TypesOfImages] =
    [
        TypesOfImages(image: "ECO FRIENDLY", name: "Eco Friendly"),
        TypesOfImages(image: "REGULAR RECTANGLE", name: "Regular"),
        TypesOfImages(image: "CUSTOMISED", name: "Customised"),
        TypesOfImages(image: "AKSHAR", name: "Akshar Ganesh")
        
    ]
    
    
    @IBOutlet weak var CollectionView1: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CollectionView1.register(UINib(nibName: "GaneshaimgCVC", bundle: .main), forCellWithReuseIdentifier: "GaneshaimgCVC")
        CollectionView1.delegate =  self
        CollectionView1.dataSource = self
    }
}

extension GimgVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return GaneshaImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GaneshaimgCVC", for: indexPath) as! GaneshaimgCVC
        cell.Gimages.image = UIImage(named: GaneshaImages[indexPath.row].image)
        cell.Label1.text = GaneshaImages[indexPath.row].name
//        cell.layer.cornerRadius = 35
//        cell.layer.masksToBounds = true
        cell.roundCorners(corners: [.topRight, .bottomLeft], radius: 12)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 40, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 30)/2)
        return CGSize(width: width, height: width + 10)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "EcoFriendlyVC") as! EcoFriendlyVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
