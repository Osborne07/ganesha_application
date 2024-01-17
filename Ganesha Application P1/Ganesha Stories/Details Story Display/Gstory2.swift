//
//  Gstory2.swift
//  Ganesha Application P1
//
//  Created by Jon Snow on 26/12/23.
//

import UIKit

struct StoryDetailed : Codable {
    var id : String?
    var title : String?
    var description : String?
    var image : String?
    var thumb_image : String?
}

class Gstory2: UIViewController {

    
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    var DetailedStoryData = [StoryDetailed]()
    
    var StoriesData : StoriesModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "StoryCVC", bundle: .main), forCellWithReuseIdentifier: "StoryCVC")
        collectionView.delegate = self
        collectionView.dataSource = self
        StoriesById(storybyId: StoriesData?.id ?? "")
    }
}

extension Gstory2 : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return DetailedStoryData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "StoryCVC", for: indexPath) as! StoryCVC
        cell.LabelHead.text = DetailedStoryData[indexPath.row].title
        let url = URL(string:DetailedStoryData[indexPath.row].image ?? "" )
        cell.ImageBack.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
        cell.LabelPara.text = DetailedStoryData[indexPath.row].description
        return cell
    }
}

extension Gstory2: UICollectionViewDelegateFlowLayout{
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
        let width = ((collectionView.frame.width - 20)/1)
        let height = width * 1
        return CGSize(width: width, height: height)
    }
}
extension Gstory2{
    func StoriesById(storybyId : String){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/ganesha/stories?category_id=\(storybyId)")else { return }
        let requst = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requst){data, response, error in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let data = try JSONDecoder().decode([StoryDetailed].self, from: data)
                    print(data)
                    self.DetailedStoryData = data
                    
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
