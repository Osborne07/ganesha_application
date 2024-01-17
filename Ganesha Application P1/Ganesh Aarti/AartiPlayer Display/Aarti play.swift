//
//  Aarti play.swift
//  Ganesha Application P1
//
//  Created by Jon Snow on 21/12/23.
//

import UIKit
import AVKit
import AVFoundation

class Aarti_play: UIViewController {

    @IBOutlet weak var HeadLabel: UILabel!
    
    
    @IBOutlet weak var ImageView:UIImageView!
    
    
    @IBOutlet weak var PlayerSlider: UISlider!
    
    
    
    @IBOutlet weak var PlayPause: UIButton!
    
    var player = AVPlayer()
    var artiPlayer : Aarti?
    var Artiurl : String?
    var isPlaying = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = URL(string:Artiurl ?? "") else {return}
        print(Artiurl)
        player = AVPlayer(url: url)

        player.play()
        }
    
    
//    func playSound() {
//        let url = URL(string: Artiurl ?? "" )
//           let urlAudio = Bundle.main.url(forResource: "", withExtension: "mp3")
//           player = try! AVAudioPlayer(contentsOf: urlAudio!)
//           player.play()
//        }
//    
    @IBAction func LeftOption(_ sender: UIButton) {
    }
    
    @IBAction func sliderAct(_ sender: UISlider) {
        
        player.seek(to: CMTime(seconds: Double(sender.value), preferredTimescale: 1), toleranceBefore: .zero, toleranceAfter: .zero)
        
    }
    @IBAction func ListTapped(_ sender: UIButton) {
        
    }
    
    
    @IBAction func RightOption(_ sender: UIButton) {
        
    }
    
    @IBAction func PauseTapped(_ sender: Any) {
        
        guard let url = URL(string:Artiurl ?? "") else {return}
        
        player = AVPlayer(url: url)
        
        //        player.play()
        if isPlaying{
            player.pause()
            
            print("pauseeeeee")
            //            PlayPause.setTitle("Resume", for: .normal)
        }
        
        else{
            player.play()
            
            print("playyyyyy")
            //            PlayPause.setTitle("Pause", for: .normal)
            
            player.addPeriodicTimeObserver(forInterval: CMTime(seconds: 1, preferredTimescale: 1), queue: DispatchQueue.main) { t in
                
                if self.player.status == .readyToPlay {
                    self.PlayerSlider.maximumValue = Float(self.player.currentItem?.duration.seconds ?? 0)
                }
                
            }
            
        }
        isPlaying.toggle()
        
        
        
        //                if player != nil {
        //                    player.stop()
        //                    player = nil
        //                    PlayPause.setImage(UIImage(named: "play"), for: .normal)
        //                } else {
        //                    PlayPause.setImage(UIImage(named: "pause"), for: .normal)
        //                    playSound()
        //
        //            }
        
        
    }
    
    
    
}
