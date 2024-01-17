//
//  Fmurtikar.swift
//  Ganesha Application P1
//
//  Created by Student on 15/12/23.
//

import UIKit
import SDWebImage

struct Murtikar: Codable{
    var image : String?
    var thumb_image : String?
    var name : String?
    var contact : String?
    var location : String
}

class Fmurtikar: UIViewController{
    
    @IBOutlet weak var collectionView2: UICollectionView!
    
    var MurtikarArray = [Murtikar]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView2.register(UINib(nibName: "MurtikarCVC", bundle: .main), forCellWithReuseIdentifier: "MurtikarCVC")
        collectionView2.register(UINib(nibName: "MurtiCVC", bundle: .main), forCellWithReuseIdentifier: "MurtiCVC")
        collectionView2.delegate = self
        collectionView2.dataSource = self
        MurtikarAPI()
    }
    
    //    -------------------------------------------- Api -----------------------------------------------------------
    
    func MurtikarAPI(){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/ganesha/murtikar?category_id=3")
        else {return}
        
        let requst = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requst){ data , response , error in
            
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            
            if let data = data {
                do{
                    let Data = try JSONDecoder().decode([Murtikar].self, from: data)
                    self.MurtikarArray = Data
                    DispatchQueue.main.async {
                        
                        self.collectionView2.reloadData()
                    }
                }catch{
                    print("Error")
                }
            }
        }.resume()
    }
}

//---------------------------------------Cell function --------------------------------------------

extension Fmurtikar: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView2.dequeueReusableCell(withReuseIdentifier: "MurtikarCVC", for: indexPath) as! MurtikarCVC
        cell.imageM.sd_setImage(with: URL(string: MurtikarArray[indexPath.item].thumb_image ?? ""))
        cell.NameMLabel.text = MurtikarArray[indexPath.item].name ?? ""
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MurtikarArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "DisplayMurtiApi", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "MurtiCVC") as! MurtiCVC
        vc.FMurtiData = MurtikarArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//-------------------------------------------cell Design --------------------------------------------------



extension Fmurtikar: UICollectionViewDelegateFlowLayout {
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
        let height = width / 2
        return CGSize(width: width, height: height)
    
    }
}
