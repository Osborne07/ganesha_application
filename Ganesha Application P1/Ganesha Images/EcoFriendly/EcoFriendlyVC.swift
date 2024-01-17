//
//  EcoFriendlyVC.swift
//  Ganesha Application P1
//
//  Created by Student on 15/12/23.
//

import UIKit
import SDWebImage

struct EcoFriendlyModel : Codable{
    var id : String?
    var murti_image : String?
    var thumb_image : String?
}



class EcoFriendlyVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var dataArray = [EcoFriendlyModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "EcoFriendlyCVC", bundle: .main), forCellWithReuseIdentifier: "EcoFriendlyCVC")
        collectionView.dataSource = self
        collectionView.delegate = self
        EcoFriendlyAPI()
    }
    
//-----------------------------------API SECTION------------------------------------------------

    
    func EcoFriendlyAPI(){
        guard let URL = URL(string: "https://mapi.trycatchtech.com/v3/ganesha/murti_images?category_id=1") else{return}
        
        let request = URLRequest(url: URL)
        
        URLSession.shared.dataTask(with: request) {data , response , error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let data = data {
                do{
                    let Data = try JSONDecoder().decode([EcoFriendlyModel].self, from: data)
                    self.dataArray = Data
                                        DispatchQueue.main.async {

                        self.collectionView.reloadData()
                    }
                    
                }catch{
                    print("Error")
                }
            }
        }.resume()
    }
}

//--------------------------------------------CEll SECTION---------------------------------------------


extension EcoFriendlyVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EcoFriendlyCVC", for: indexPath) as! EcoFriendlyCVC
        cell.EcoImage.sd_setImage(with: URL(string: dataArray[indexPath.item].murti_image ?? ""), placeholderImage: UIImage(named: "placeholder.png"))
        cell.layer.cornerRadius = 35
        cell.layer.masksToBounds = true
        return cell
    }
    
    
//    --------------------------------------------LAYouT SECTion ------------------------------------
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 30)/2)
//        let height = width / 2
        return CGSize(width: width, height: width)
    }
}
