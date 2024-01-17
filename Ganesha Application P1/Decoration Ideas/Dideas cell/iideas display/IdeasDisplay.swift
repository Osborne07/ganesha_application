//
//  IdeasDisplay.swift
//  Ganesha Application P1
//
//  Created by Jon Snow on 21/12/23.
//

import UIKit
import SDWebImage

class IdeasDisplay: UIViewController {
    
    @IBOutlet weak var HeadLabel: UILabel!
    @IBOutlet weak var HeadImg: UIImageView!
    
    @IBOutlet weak var MainImg: UIImageView!
    
    @IBOutlet weak var SemiHeadLabel: UILabel!
    
    @IBOutlet weak var SepratorImg: UIImageView!
    
    @IBOutlet weak var DesLabel: UILabel!
    
    @IBOutlet weak var backImg: UIImageView!
    
    var IdeasData : ideas?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: IdeasData?.image ?? "")
        self.MainImg.sd_setImage(with: url)
        self.DesLabel.text = IdeasData?.description ?? ""
        self.SemiHeadLabel.text = IdeasData?.description ?? ""
    }
}
