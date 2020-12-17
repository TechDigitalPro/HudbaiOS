//
//  PlayerVC.swift
//  Music Player
//
//  Created by SilverGold on 12/11/20.
//  Copyright © 2020 polat. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {
    
    
    @IBOutlet weak var mSlider: UISwitch!
    @IBOutlet weak var bSlider: UISwitch!
    
    @IBOutlet weak var iVolume: UIImageView!
    @IBOutlet weak var iMusic: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iVolume.image = iVolume.image?.tinted(color: .white)
        iMusic.image = iMusic.image?.tinted(color: .white)
        
        mSlider.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        bSlider.transform = CGAffineTransform(scaleX: 0.75, y: 0.75)
        if userDefaults.integer(forKey: "mediaType") == 0{
            mSlider.isOn = true
        }else{
            mSlider.isOn = false
        }
    }
    
    @IBAction func musicAndVideo(_ sender: UISwitch) {
        if sender.isOn{
            userDefaults.set(0, forKey: "mediaType")
        }else{
            userDefaults.set(1, forKey: "mediaType")
        }
        if let mainVC = self.parent?.parent as? MainVC{
            mainVC.changeMediaType()
        }
    }
    
    @IBAction func bBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
   

}
