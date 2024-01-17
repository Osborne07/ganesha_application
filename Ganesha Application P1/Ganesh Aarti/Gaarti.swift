//
//  Gaarti.swift
//  Ganesha Application P1
//
//  Created by Student on 15/12/23.
//

import UIKit

struct Aarti : Codable {
    var id : String?
    var title : String?
    var audio : String?
    var description : String?
}


class Gaarti: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var HeadLabel: UILabel!
    
    
    @IBOutlet weak var HeadImg: UIImageView!
    
    var aartiArray = [Aarti]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "AartiCVC", bundle: .main), forCellWithReuseIdentifier: "AartiCVC")
        collectionView.delegate = self
        collectionView.dataSource = self
        AartiAPI()
    }
    
    func AartiAPI(){
            guard let url = URL(string: "https://mapi.trycatchtech.com/v3/ganesha/aarti")else { return }
            let requst = URLRequest(url: url)
    
            URLSession.shared.dataTask(with: requst){data, response, error in
    
                if let error = error{
                    print(error.localizedDescription)
                    return
                }
                if let data = data{
                    do{
                        let data = try JSONDecoder().decode([Aarti].self, from: data)
//                        print(data)
                        self.aartiArray = data
    
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

////------------------------------------------- Cell Function ------------------------------------------

extension Gaarti: UICollectionViewDelegate, UICollectionViewDataSource{
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return aartiArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AartiCVC", for: indexPath) as! AartiCVC
        cell.SongLabel.text = aartiArray[indexPath.item].title
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Aarti play", bundle: .main)
        let vc = storyboard.instantiateViewController(withIdentifier: "Aarti_play") as! Aarti_play
        vc.artiPlayer = aartiArray[indexPath.row]
        vc.Artiurl = aartiArray[indexPath.row].audio
//        vc.FMandalData = MandalArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension Gaarti: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = ((collectionView.frame.width - 20)/1)
        let height = width / 5
        return CGSize(width: width, height: height)
    }
}
    


