//
//  HomeVC.swift
//  Music Player
//
//  Created by SilverGold on 12/5/20.
//  Copyright © 2020 polat. All rights reserved.
//

import UIKit
import AlamofireImage

class HomeVC: UIViewController {
    
    @IBOutlet weak var homeCollection: UICollectionView!
    @IBOutlet weak var homeCollectionHeight: NSLayoutConstraint!
    @IBOutlet weak var vTop: UIView!
    @IBOutlet weak var topCollection: UICollectionView!
    @IBOutlet weak var topHeight: NSLayoutConstraint!
    @IBOutlet weak var vDaily: UIView!
    @IBOutlet weak var dailyCollection: UICollectionView!
    @IBOutlet weak var dailyHeight: NSLayoutConstraint!
    @IBOutlet weak var vFavor: UIView!
    @IBOutlet weak var favorCollection: UICollectionView!
    @IBOutlet weak var favorHeight: NSLayoutConstraint!
    @IBOutlet weak var vRank: UIView!
    @IBOutlet weak var rankCollection: UICollectionView!
    @IBOutlet weak var rankHeight: NSLayoutConstraint!
    @IBOutlet weak var vTrending: UIView!
    @IBOutlet weak var trendingCollection: UICollectionView!
    @IBOutlet weak var trendingHeight: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        apiCallGetHomeData()
    }
    
    
    @IBAction func bProfileTapped(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func refreshUI(){
        DispatchQueue.main.async {
            if home_list.count == 0{
                self.homeCollectionHeight.constant = 0
                self.homeCollection.hideView()
            }else{
                self.homeCollectionHeight.constant = 150
                self.homeCollection.showView()
            }
            if top_list.count == 0{
                self.vTop.hideView()
                self.topHeight.constant = 0
            }else{
                self.vTop.showView()
                self.topHeight.constant = 300
            }
            if daily_list.count == 0{
                self.vDaily.hideView()
                self.dailyHeight.constant = 0
            }else{
                self.vDaily.showView()
                self.dailyHeight.constant = 300
            }
            if favor_list.count == 0{
                self.vFavor.hideView()
                self.favorHeight.constant = 0
            }else{
                self.vFavor.showView()
                self.favorHeight.constant = 300
            }
            if ranking_list.count == 0{
                self.vRank.hideView()
                self.rankHeight.constant = 0
            }else{
                self.vRank.showView()
                self.rankHeight.constant = 300
            }
            if trend_list.count == 0{
                self.vTrending.hideView()
                self.trendingHeight.constant = 0
            }else{
                self.vTrending.showView()
                self.trendingHeight.constant = 300
            }
            self.homeCollection.reloadData()
            self.topCollection.reloadData()
            self.dailyCollection.reloadData()
            self.favorCollection.reloadData()
            self.rankCollection.reloadData()
            self.trendingCollection.reloadData()
        }
    }
    
    //############### Api ####################//
    
    func apiCallGetHomeData(){
        showLoading()
        let param = ["member_key": "182be0c5cdcd5072bb1864cdee4d3d6ed046ff78e2a04ac44d4e192de82c4266", "user_id":"33"]
        apiPost(Constants.HOME_LIST, param) { res in
            hideLoading()
            if let data = res as? NSDictionary {
                if data.parseString(param: "res").elementsEqual("success"){
                    if let api_result = data["api_result"] as? NSDictionary{
                        if let homeArray = api_result["home_list"] as? NSArray{
                            home_list.removeAll()
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
                                    home_list.append(tItem)
                                }
                                
                            }
                        }
                        
                        if let favorArray = api_result["favorite_list"] as? NSArray{
                            favor_list.removeAll()
                            for i in 0..<favorArray.count{
                                if let dic = favorArray[i] as? NSDictionary{
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
                                    favor_list.append(tItem)
                                }
                            }
                        }
                        
                        if let topArray = api_result["top_list"] as? NSArray{
                            top_list.removeAll()
                            for i in 0..<topArray.count{
                                if let dic = topArray[i] as? NSDictionary{
                                    var aItem = AlbumModel()
                                    aItem.cover_image = dic.parseString(param: "cover_image")
                                    aItem.list_id = dic.parseString(param: "list_id")
                                    aItem.title = dic.parseString(param: "title")
                                    aItem.track_cnt = dic.parseString(param: "track_cnt")
                                    aItem.tracklist = dic.parseString(param: "tracklist")
                                    aItem.user_name = dic.parseString(param: "user_name")
                                    top_list.append(aItem)
                                }
                                
                            }
                        }
                        
                        if let rankArray = api_result["rank_list"] as? NSArray{
                            ranking_list.removeAll()
                            for i in 0..<rankArray.count{
                                if let dic = rankArray[i] as? NSDictionary{
                                    var aItem = AlbumModel()
                                    aItem.cover_image = dic.parseString(param: "image")
                                    aItem.list_id = dic.parseString(param: "playlist_id")
                                    aItem.title = dic.parseString(param: "country")
                                    aItem.track_cnt = dic.parseString(param: "track_cnt")
                                    aItem.tracklist = dic.parseString(param: "tracklist")
                                    aItem.user_name = dic.parseString(param: "user_name")
                                    ranking_list.append(aItem)
                                }
                            }
                        }
                        
                        if let trendArray = api_result["trend_list"] as? NSArray{
                            trend_list.removeAll()
                            for i in 0..<trendArray.count{
                                if let dic = trendArray[i] as? NSDictionary{
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
                                    trend_list.append(tItem)
                                }
                            }
                        }
                        self.refreshUI()
                    }
                }
            }
        }
    }
}

extension HomeVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView.tag {
        case 1:
            return home_list.count
        case 2:
            return top_list.count
        case 3:
            return daily_list.count
        case 4:
            return favor_list.count
        case 5:
            return ranking_list.count
        case 6:
            return trend_list.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView.tag {
        case 1:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCell", for: indexPath)
            
             let model: TrackModel = home_list[indexPath.item]
             let imageView = cell.viewWithTag(1001) as! UIImageView
             let titleLabel = cell.viewWithTag(1002) as! UILabel
             imageView.af_setImage(withURL: URL(string: model.cover_image)!, placeholderImage: UIImage(named:"aaa"))
             titleLabel.text = model.title
             return cell
        case 2:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopCell", for: indexPath)
            
             let model: AlbumModel = top_list[indexPath.item]
             let imageView = cell.viewWithTag(2001) as! UIImageView
             let titleLabel = cell.viewWithTag(2002) as! UILabel
             let subtitleLabel = cell.viewWithTag(2003) as! UILabel
             let countLabel = cell.viewWithTag(2004) as! UILabel
             imageView.af_setImage(withURL: URL(string: model.cover_image)!, placeholderImage: UIImage(named:"aaa.jpg"))
             titleLabel.text = model.title
             subtitleLabel.text = model.title
             countLabel.text = "\(model.track_cnt) songs"
             return cell
        case 3:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DailyCell", for: indexPath)
            
             let model: AlbumModel = daily_list[indexPath.item]
             let imageView = cell.viewWithTag(3001) as! UIImageView
             let titleLabel = cell.viewWithTag(3002) as! UILabel
             let subtitleLabel = cell.viewWithTag(3003) as! UILabel
             let countLabel = cell.viewWithTag(3004) as! UILabel
             imageView.af_setImage(withURL: URL(string: model.cover_image)!, placeholderImage: UIImage(named:"aaa.jpg"))
             titleLabel.text = model.title
             subtitleLabel.text = model.title
             countLabel.text = "\(model.track_cnt) songs"
             return cell
        case 4:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavorCell", for: indexPath)
            
             let model: TrackModel = favor_list[indexPath.item]
             let imageView = cell.viewWithTag(4001) as! UIImageView
             let subtitleLabel = cell.viewWithTag(4003) as! UILabel
             let countLabel = cell.viewWithTag(4004) as! UILabel
             imageView.af_setImage(withURL: URL(string: model.cover_image)!, placeholderImage: UIImage(named:"aaa.jpg"))
             subtitleLabel.text = model.title
             countLabel.text = model.artist_name
             return cell
        case 5:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RankCell", for: indexPath)
             let model: AlbumModel = ranking_list[indexPath.item]
             let imageView = cell.viewWithTag(5001) as! UIImageView
             let subtitleLabel = cell.viewWithTag(5003) as! UILabel
             let countLabel = cell.viewWithTag(5004) as! UILabel
             imageView.af_setImage(withURL: URL(string: model.cover_image)!, placeholderImage: UIImage(named:"aaa.jpg"))
             subtitleLabel.text = model.title
             countLabel.text = "Top viral songs from \(model.title)"
             return cell
        case 6:
             let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TrendingCell", for: indexPath)
            
             let model: TrackModel = trend_list[indexPath.item]
             let imageView = cell.viewWithTag(6001) as! UIImageView
             let subtitleLabel = cell.viewWithTag(6003) as! UILabel
             let countLabel = cell.viewWithTag(6004) as! UILabel
             imageView.af_setImage(withURL: URL(string: model.cover_image)!, placeholderImage: UIImage(named:"aaa.jpg"))
             subtitleLabel.text = model.title
             countLabel.text = model.artist_name
             return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    
}



extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView.tag {
        case 1:
            return CGSize(width: CGFloat(120), height: CGFloat(140))
        case 2:
            return CGSize(width: CGFloat(180), height: CGFloat(220))
        case 3:
            return CGSize(width: CGFloat(180), height: CGFloat(220))
        case 4:
            return CGSize(width: CGFloat(180), height: CGFloat(220))
        case 5:
            return CGSize(width: CGFloat(180), height: CGFloat(220))
        case 6:
            return CGSize(width: CGFloat(180), height: CGFloat(220))
        default:
            return CGSize(width: CGFloat(200), height: CGFloat(200))
        }
    }
}

// UICollectionViewDelegate
extension HomeVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView.tag {
          case 1:
            
            break
          case 2:
            let stb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = stb.instantiateViewController(withIdentifier: "AlbumDetailVC") as? AlbumDetailVC{
                vc.list_title = top_list[indexPath.row].title
                vc.list_id = top_list[indexPath.row].list_id
                vc.type = "top"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            break
          case 3:
              break
          case 4:
            
              break
          case 5:
            let stb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = stb.instantiateViewController(withIdentifier: "AlbumDetailVC") as? AlbumDetailVC{
                vc.list_title = ranking_list[indexPath.row].title
                vc.list_id = ranking_list[indexPath.row].list_id
                vc.type = "ranking"
                self.navigationController?.pushViewController(vc, animated: true)
            }
              break
          case 6:
              break
          default:
              break
        }
    }
}

