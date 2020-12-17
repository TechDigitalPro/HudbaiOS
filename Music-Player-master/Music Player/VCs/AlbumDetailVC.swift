//
//  AlbumDetailVC.swift
//  Music Player
//
//  Created by SilverGold on 12/7/20.
//  Copyright © 2020 polat. All rights reserved.
//

import UIKit

class AlbumDetailVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!

    @IBOutlet weak var headerViewTop: NSLayoutConstraint!

    @IBOutlet weak var containerViewTop: NSLayoutConstraint!
    
    @IBOutlet weak var vTitle: UIView!
    @IBOutlet weak var vHeaderBack: UIView!
    
    @IBOutlet weak var iSearch: UIImageView!
    @IBOutlet weak var tSearch: UITextField!
    @IBOutlet weak var lTItle1: UILabel!
    @IBOutlet weak var lTItle2: UILabel!
    @IBOutlet weak var lCount: UILabel!
    
    var list_title = ""
    var image_url = ""
    var list_id  = ""
    var type = ""
    // how far the header view gets scrolled offscreen
    var maxScrollAmount: CGFloat {
        let expandedHeight = headerViewHeight.constant
        let collapsedHeight = containerViewTop.constant
        return expandedHeight - collapsedHeight
    }
    
    func setCollapseHeader(){
        if let scrollView = containerView.subviews.first?.subviews.first as? UIScrollView {
            scrollView.contentInset = UIEdgeInsets(top: maxScrollAmount, left: 0, bottom: 0, right: 0)
        }

        if var scrollViewContained = children.first as? ScrollViewContained {
            scrollViewContained.scrollDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setCollapseHeader()
        configView()
        if let vc = children.first as? AlblumDetailContentVC{
            vc.apiCallGetSavedData(list_id: list_id, type: type)
        }
    }
    
    
    
    
    func configView(){
        //view.setGradientBackground(colorTop: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), colorBottom: #colorLiteral(red: 0.2877361389, green: 0.2870617444, blue: 0.3500650847, alpha: 1))
        iSearch.image = iSearch.image?.tinted(color: .white)
        tSearch.whitePlaceholder(placeholder: "Search")
        vHeaderBack.alpha = 0
        lTItle1.text = list_title
        lTItle2.text = list_title
    }
    
    @IBAction func bBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension AlbumDetailVC: ScrollViewContainingDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let newTopConstraintConstant = -(scrollView.contentOffset.y + scrollView.contentInset.top)
        headerViewTop.constant = min(0, max(-maxScrollAmount, newTopConstraintConstant))
        let isAtTop = headerViewTop.constant == -maxScrollAmount
        scrollViewScrolled(scrollView, didScrollToTop: isAtTop)
    }

    func scrollViewScrolled(_ scrollView: UIScrollView, didScrollToTop isAtTop:Bool) {
        if isAtTop{
            vTitle.fadeOut(duration: 0.5)
            vHeaderBack.fadeIn(duration: 0.5)
        }else{
            vTitle.fadeIn(duration: 0.5)
            vHeaderBack.fadeOut(duration: 0.5)
        }
    }
    
    func refresh(){
        //lCount.text = "- \(count) Songs"
    }
}
