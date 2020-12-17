//
//  HomeContentVC.swift
//  Music Player
//
//  Created by SilverGold on 12/5/20.
//  Copyright © 2020 polat. All rights reserved.
//

import UIKit

class LibContentVC: UIViewController ,ScrollViewContained{
    
    @IBOutlet weak var iSaved: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var iAdd: UIImageView!
    @IBOutlet weak var lCount: UILabel!
    @IBOutlet weak var tableH: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    var datas = [PlayListModel]()
    var image_path = ""
    var song_count = 0
    
    weak var scrollDelegate: ScrollViewContainingDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self
        configView()
        apiCallGetSavedData()
    }
    
    func configView(){
        iAdd.image = iAdd.image?.tinted(color: .white)
    }
    
    func refreshView(){
        iSaved.af_setImage(withURL: URL(string: image_path)!, placeholderImage: UIImage(named:"aaa.jpg"))
        lCount.text = "\(song_count) songs"
        tableH.constant = CGFloat(datas.count * 80 + 100)
        tableView.reloadData()
    }
    
    @IBAction func bAddTapped(_ sender: Any) {
        let stb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = stb.instantiateViewController(withIdentifier: "AddPlaylistVC") as? AddPlaylistVC{
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    //############### Api ####################//
    
    func apiCallGetSavedData(){
        showLoading()
        let param = ["memberKey": "182be0c5cdcd5072bb1864cdee4d3d6ed046ff78e2a04ac44d4e192de82c4266", "user_id":"33"]
        apiPost(Constants.MYPLAY_LIST, param) { res in
            hideLoading()
            if let data = res as? NSDictionary {
                if data.parseString(param: "res").elementsEqual("success"){
                    if let api_result = data["api_result"] as? NSDictionary{
                        self.image_path = api_result.parseString(param: "image_path")
                        self.song_count = api_result.parseInt(param: "count")
                        if let homeArray = api_result["list"] as? NSArray{
                            self.datas.removeAll()
                            for i in 0..<homeArray.count{
                                if let dic = homeArray[i] as? NSDictionary{
                                    var tItem = PlayListModel()
                                    tItem.id = dic.parseString(param: "id")
                                    tItem.sub_title = dic.parseString(param: "sub_title")
                                    tItem.title = dic.parseString(param: "title")
                                    tItem.song_cnt = dic.parseString(param: "song_cnt")
                                    self.datas.append(tItem)
                                }
                            }
                        }
                        self.refreshView()
                    }
                }
            }
        }
    }
}

extension LibContentVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView)
    }
}

extension LibContentVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
      
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath)
        cell.selectionStyle = .none
        let model = datas[indexPath.row]
        //let imageView = cell.viewWithTag(1001) as! UIImageView
        let titleLabel = cell.viewWithTag(1001) as! UILabel
        let subTitleLabel = cell.viewWithTag(1002) as! UILabel
        let cntLabel = cell.viewWithTag(1003) as! UILabel
        let btnImage = cell.viewWithTag(1005) as! UIImageView
        btnImage.image = btnImage.image?.tinted(color: .white)
        titleLabel.text = model.title
        subTitleLabel.text = model.sub_title
        cntLabel.text = "\(model.song_cnt) songs"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}


extension LibContentVC: AddPlayListDelegate{
    func dismissed(){
        self.view.makeToast("Playlist added successfully")
        dismiss(animated: true, completion: nil)
        self.apiCallGetSavedData()
    }
}


