//
//  SearchVC.swift
//  Music Player
//
//  Created by SilverGold on 12/5/20.
//  Copyright © 2020 polat. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!

    @IBOutlet weak var headerViewTop: NSLayoutConstraint!

    @IBOutlet weak var containerViewTop: NSLayoutConstraint!

    @IBOutlet weak var vTitle: UIView!
    @IBOutlet weak var vHeaderBack: UIView!
    
    @IBOutlet weak var iSearch: UIImageView!
    @IBOutlet weak var tSearch: UITextField!
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
    }
    
    @IBAction func bProfileTapped(_ sender: UIButton) {
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as? ProfileVC{
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func configView(){
        iSearch.image = iSearch.image?.tinted(color: .white)
        tSearch.whitePlaceholder(placeholder: "Search")
        vHeaderBack.alpha = 0
    }
}

extension SearchVC: ScrollViewContainingDelegate {
    func refresh() {
    }
    
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
}
