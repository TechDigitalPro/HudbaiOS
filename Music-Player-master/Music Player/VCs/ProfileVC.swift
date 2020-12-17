//
//  ProfileVC.swift
//  Music Player
//
//  Created by SilverGold on 12/11/20.
//  Copyright © 2020 polat. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController {

    @IBOutlet weak var iLib: UIImageView!
    @IBOutlet weak var iReview: UIImageView!
    @IBOutlet weak var iFind: UIImageView!
    @IBOutlet weak var iContact: UIImageView!
    @IBOutlet weak var iInfo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        iLib.image = iLib.image?.tinted(color: .white)
        iReview.image = iReview.image?.tinted(color: .white)
        iFind.image = iFind.image?.tinted(color: .white)
        iContact.image = iContact.image?.tinted(color: .white)
        iInfo.image = iInfo.image?.tinted(color: .white)
    }
    
    @IBAction func bBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func playerTapped(_ sender: UITapGestureRecognizer) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "PlayerVC") as? PlayerVC{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
