//
//  SearchContentVC.swift
//  Music Player
//
//  Created by SilverGold on 12/6/20.
//  Copyright © 2020 polat. All rights reserved.
//

import UIKit

class SearchContentVC: UIViewController ,ScrollViewContained{

    
    @IBOutlet weak var collection: UICollectionView!
    
    var search_list = [SearchModel]()
    var datas = [SearchModel]()
    
    weak var scrollDelegate: ScrollViewContainingDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        apiCallGetSearchData()
    }
    
    
    
    //############### Api ####################//
    
    func apiCallGetSearchData(){
        showLoading()
        let param = ["memberKey": "182be0c5cdcd5072bb1864cdee4d3d6ed046ff78e2a04ac44d4e192de82c4266"]
        apiPost(Constants.SEARCH_LIST, param) { res in
            hideLoading()
            if let data = res as? NSDictionary {
                if data.parseString(param: "res").elementsEqual("success"){
                    if let api_result = data["api_result"] as? NSDictionary{
                        if let homeArray = api_result["list"] as? NSArray{
                            self.search_list.removeAll()
                            self.datas.removeAll()
                            for i in 0..<homeArray.count{
                                if let dic = homeArray[i] as? NSDictionary{
                                    var tItem = SearchModel()
                                    tItem.id = dic.parseString(param: "id")
                                    tItem.cover_image = dic.parseString(param: "cover_image")
                                    tItem.title = dic.parseString(param: "title")
                                    tItem.search_id = dic.parseString(param: "search_id")
                                    self.search_list.append(tItem)
                                    self.datas.append(tItem)
                                }
                                
                            }
                        }
                        self.collection.reloadData()
                    }
                }
            }
        }
    }
}

extension SearchContentVC: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.scrollViewDidScroll(scrollView)
    }
}

// UICollectionViewDataSource
extension SearchContentVC: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCell", for: indexPath)
        let model: SearchModel = datas[indexPath.item]
        let imageView = cell.viewWithTag(1001) as! UIImageView
        let titleLabel = cell.viewWithTag(1002) as! UILabel
        imageView.af_setImage(withURL: URL(string: model.cover_image)!, placeholderImage: UIImage(named:"aaa"))
        titleLabel.text = model.title
        return cell
    }
}


extension SearchContentVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = collectionView.frame.size.width / 2
        return CGSize(width: width, height: width * 0.6)
    }
}

// UICollectionViewDelegate
extension SearchContentVC: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

