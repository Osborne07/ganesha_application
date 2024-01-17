//
//  ViewController.swift
//  Ganesha Application P1
//
//  Created by Student on 07/12/23.
//

import UIKit

struct UIimages : Codable{
    var image : String
    var name : String
}


class ViewController: UIViewController {
    
    let dataArray : [UIimages] =
    [
        UIimages(image: "GROUP6", name: "Ganesha\n Images"),
        UIimages(image: "GROUP2", name: "Famous\nMurtikar"),
        UIimages(image: "GROUP3", name: "Famous\nPandal"),
        UIimages(image: "GROUP4", name: "Decoration\n    Ideas"),
        UIimages(image: "GROUP5", name: "Ganesha\n  Aartis"),
        UIimages(image: "GROUP6", name: "Ganesha\nStories")
    ]
    
    @IBOutlet weak var TopBackground: UIImageView!
    
    @IBOutlet weak var Header1: UIImageView!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: "CircleImg", bundle: .main), forCellWithReuseIdentifier: "CircleImg")
        
        
        
    }
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(identifier: "GimgVC") as! GimgVC
            self.navigationController?.pushViewController(vc, animated: true)
        case 1:
            let vc = storyboard?.instantiateViewController(identifier: "Fmurtikar") as! Fmurtikar
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = storyboard?.instantiateViewController(identifier: "Fmandal") as! Fmandal
            self.navigationController?.pushViewController(vc, animated: true)
        case 3:
            let vc = storyboard?.instantiateViewController(identifier: "Dideas") as! Dideas
            self.navigationController?.pushViewController(vc, animated: true)
        case 4:
            let vc = storyboard?.instantiateViewController(identifier: "Gaarti") as! Gaarti
            self.navigationController?.pushViewController(vc, animated: true)
        case 5:
            let vc = storyboard?.instantiateViewController(identifier: "Gstories") as! Gstories
            self.navigationController?.pushViewController(vc, animated: true)
        default:
            print("error")
        }
       
    }
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CircleImg", for: indexPath) as! CircleImg
        cell.imgUi.image = UIImage(named: dataArray[indexPath.row].image)
        cell.NameLabel1.text = dataArray[indexPath.row].name
        cell.NameLabel1.textColor = .white
        cell.layer.cornerRadius = 60
        cell.layer.masksToBounds = true
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath){
            cell.contentView.backgroundColor = .yellow
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath){
            cell.contentView.backgroundColor = nil
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 50, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width-40)/3)
        return CGSize(width: width, height: width)
    }
    
    
}
                           




extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
