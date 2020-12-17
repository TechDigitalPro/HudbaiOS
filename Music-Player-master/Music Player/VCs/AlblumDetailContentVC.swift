//
//  AlblumDetailContentVC.swift
//  Music Player
//
//  Created by SilverGold on 12/7/20.
//  Copyright © 2020 polat. All rights reserved.
//

import UIKit

class AlblumDetailContentVC: UIViewController ,ScrollViewContained{
   
   
    @IBOutlet weak var tableView: UITableView!
    
    
    
    weak var scrollDelegate: ScrollViewContainingDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func refreshView(){
        tableView.reloadData()
        scrollDelegate?.refresh()
    }
    
   
    
    //############### Api ####################//
    
    func apiCallGetSavedData(list_id: String, type: String){
        showLoading()
        let param = ["memberKey": "182be0c5cdcd5072bb1864cdee4d3d6ed046ff78e2a04ac44d4e192de82c4266", "user_id":"33", "list_id":list_id, "type":type]
        apiPost(Constants.ALBUM_DETAIL_LIST, param) { res in
            hideLoading()
            if let data = res as? NSDictionary {
                if data.parseString(param: "res").elementsEqual("success"){
                    if let api_result = data["api_result"] as? NSDictionary{
                        if let homeArray = api_result["list"] as? NSArray{
                            play_list.removeAll()
                            for i in 0..<homeArray.count{
                                if let dic = homeArray[i] as? NSDictionary{
                                    var tItem = TrackModel()
                                    tItem.id = dic.parseString(param: "id")
                                    tItem.add_timestamp = dic.parseString(param: "add_timestamp")
                                    tItem.album_id = dic.parseString(param: "album_id")
                                    tItem.album_name = dic.parseString(param: "album_name")
                                    tItem.artist_id = dic.parseString(param: "artist_id")
                                    tItem.artist_name = dic.parseString(param: "artist_name")
                                    tItem.cover_image = dic.parseString(param: "cover_image")
                                    tItem.p_listid = dic.parseString(param: "p_listid")
                                    tItem.title = dic.parseString(param: "title")
                                    tItem.track_id = dic.parseString(param: "track_id")
                                    tItem.type = dic.parseString(param: "type")
                                    tItem.user_id = dic.parseString(param: "user_id")
                                    tItem.videoId = dic.parseString(param: "videoId")
                                    play_list.append(tItem)
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

extension AlblumDetailContentVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView)
    }
}

extension AlblumDetailContentVC: UITableViewDelegate,UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return play_list.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlaylistCell", for: indexPath)
        cell.selectionStyle = .none
        let model = play_list[indexPath.row]
        //let imageView = cell.viewWithTag(1001) as! UIImageView
        let titleLabel = cell.viewWithTag(1001) as! UILabel
        let noLabel = cell.viewWithTag(1002) as! UILabel
        let subTitleLabel = cell.viewWithTag(1003) as! UILabel
        let btnImage = cell.viewWithTag(1005) as! UIImageView
        btnImage.image = btnImage.image?.tinted(color: .white)
        titleLabel.text = model.title
        subTitleLabel.text = model.artist_name
        noLabel.text = String(format: "%02i", indexPath.row + 1)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let mainVC = self.parent?.parent?.parent as? MainVC{
            let mediaType = userDefaults.integer(forKey: "mediaType")
            mainVC.play(index: indexPath.row, type: mediaType)
        }
    }
}

