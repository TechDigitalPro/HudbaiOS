//
//  AddPlaylistVC.swift
//  Music Player
//
//  Created by SilverGold on 12/7/20.
//  Copyright © 2020 polat. All rights reserved.
//

import UIKit

class AddPlaylistVC: UIViewController {

    @IBOutlet weak var vName: UIView!
    @IBOutlet weak var vBio: UIView!
    @IBOutlet weak var tName: UITextField!
    @IBOutlet weak var tBio: UITextField!
    
    var delegate: AddPlayListDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        vName.setBorder(color: .white, width: 1)
        vBio.setBorder(color: .white, width: 1)
        tName.whitePlaceholder(placeholder: "Type a name you like...")
        tBio.whitePlaceholder(placeholder: "Fill with a nice bio...")
    }
    
    @IBAction func bYesTapped(_ sender: UIButton) {
        if tName.isEmpty || tBio.isEmpty{
            self.view.makeToast("Please confirm fields.")
            return
        }
        apiCallForAddPlaylist()
    }
    
    @IBAction func bNoTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func apiCallForAddPlaylist(){
        showLoading()
        let param = ["memberKey": "182be0c5cdcd5072bb1864cdee4d3d6ed046ff78e2a04ac44d4e192de82c4266", "user_id":"33", "title":tName.text!, "subtitle":tBio.text!]
        apiPost(Constants.CREATE_LIST, param) { res in
            hideLoading()
            if let data = res as? NSDictionary {
                if data.parseString(param: "res").elementsEqual("success"){
                    self.delegate?.dismissed()
                }else{
                    self.view.makeToast("Playlist add fail.")
                    self.dismiss(animated: true, completion: nil)
                }
                
            }else{
                self.view.makeToast("Playlist add fail.")
            }
        }
    }
}
