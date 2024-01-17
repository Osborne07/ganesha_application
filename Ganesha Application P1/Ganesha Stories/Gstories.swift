//
//  Gstories.swift
//  Ganesha Application P1
//
//  Created by Student on 15/12/23.
//

import UIKit

struct StoriesModel : Codable {
    var id  : String?
    var cat_name : String?
    var cat_image : String?
    var thumb_image : String?
}

struct LabelimageBG : Codable{
    var image : String
}

class Gstories: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var StoryData = [StoriesModel]()
    
    let BGImageData : [LabelimageBG] =
    [
        LabelimageBG(image: "KIDS IP Rectangle" ),
        LabelimageBG(image: "ORIGINAL IP Rectangle" )
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "GstoriesCVC", bundle: .main), forCellWithReuseIdentifier: "GstoriesCVC")
        collectionView.register(UINib(nibName: "Gstory2", bundle: .main), forCellWithReuseIdentifier: "Gstory2")
        collectionView.delegate = self
        collectionView.dataSource = self
        StroiesAPI()
    }
}

extension Gstories: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StoryData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GstoriesCVC", for: indexPath) as! GstoriesCVC
        cell.StoriesImg.image = UIImage(named: BGImageData[indexPath.row].image)
        cell.StoryLabel.text = StoryData[indexPath.row].cat_name
        let url = URL(string: StoryData[indexPath.row].cat_image ?? "")
        cell.LabelImg.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "StoryDetailsDispla", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "Gstory2") as! Gstory2
        vc.StoriesData = StoryData[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension Gstories: UICollectionViewDelegateFlowLayout{
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
        let width = (collectionView.frame.width)
        return CGSize(width: width, height: width)
    }
}
extension Gstories{
    func StroiesAPI(){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/ganesha/stories_categories")else { return }
        let requst = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requst){data, response, error in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let data = try JSONDecoder().decode([StoriesModel].self, from: data)
//                    print(data)
                    self.StoryData = data
                    
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
