//
//  Fmandal.swift
//  Ganesha Application P1
//
//  Created by Student on 15/12/23.
//

import UIKit
import SDWebImage

struct FamousMandals : Codable{
    var image : String?
    var thumb_image : String?
    var title : String?
    var location : String?
    var how_to_reach : String?
}

class Fmandal: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var MandalArray = [FamousMandals]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "MandalCVC", bundle: .main), forCellWithReuseIdentifier: "MandalCVC")
        collectionView.delegate = self
        collectionView.dataSource = self
        MandalAPI()
    }
    func MandalAPI(){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/ganesha/famous_pandals")else { return }
        let requst = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requst){data, response, error in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let data = try JSONDecoder().decode([FamousMandals].self, from: data)
                    print(data)
                    self.MandalArray = data
                    
                }catch{
                    print("error in do block")
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
                
            }
            
        }.resume()
    }
}






//--------------------------------------------------- Cell Function -------------------------------------------------

extension Fmandal: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MandalCVC", for: indexPath) as! MandalCVC
        cell.Mandalimg.sd_setImage(with: URL(string: MandalArray[indexPath.row].image ?? ""))
        cell.MandalLabel.text = MandalArray[indexPath.row].title
        return cell
        
        
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MandalArray.count
    }
}

//------------------------------------------------------ Cell Design --------------------------------------------------

extension Fmandal: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 20)/1)
        let height = width / 2
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "MandalDisplay", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "MandalDisplay") as! MandalDisplay
        vc.FMandalData = MandalArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
