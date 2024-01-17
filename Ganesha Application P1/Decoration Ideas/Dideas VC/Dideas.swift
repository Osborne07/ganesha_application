//
//  Dideas.swift
//  Ganesha Application P1
//
//  Created by Student on 15/12/23.
//

import UIKit

struct ideas : Codable{
    var id : String?
    var image : String?
    var thumb_image : String?
    var description : String?
    
}

class Dideas: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var IdeaArray = [ideas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: "IdeaCVC", bundle: .main), forCellWithReuseIdentifier: "IdeaCVC")
        collectionView.register(UINib(nibName: "IdeasDisplay", bundle: .main), forCellWithReuseIdentifier: "IdeasDisplay")
        collectionView.delegate = self
        collectionView.dataSource = self
        IdeaAPI()
        
    }
    
    func IdeaAPI(){
        guard let url = URL(string: "https://mapi.trycatchtech.com/v3/ganesha/decoration_ideas")else { return }
        let requst = URLRequest(url: url)
        
        URLSession.shared.dataTask(with: requst){data, response, error in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            if let data = data{
                do{
                    let data = try JSONDecoder().decode([ideas].self, from: data)
//                    print(data)
                    self.IdeaArray = data
                    
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
    




//------------------------------------------------- Cell Function ---------------------------------------------

extension Dideas: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IdeaCVC", for: indexPath) as! IdeaCVC
        cell.Ideaimg.sd_setImage(with: URL(string: IdeaArray[indexPath.item].thumb_image ?? ""))
        cell.ideaLabel.text = IdeaArray[indexPath.item].description
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return IdeaArray.count
    }
}

//--------------------------------------------------- Cell Design --------------------------------------------------

extension Dideas: UICollectionViewDelegateFlowLayout{
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
        let width = ((collectionView.frame.width - 30)/2)
        
        return CGSize(width: width, height: width)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "IdeasDisplay", bundle: .main)
        let vc = storyboard.instantiateViewController(identifier: "IdeasDisplay") as! IdeasDisplay
        vc.IdeasData = IdeaArray[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
