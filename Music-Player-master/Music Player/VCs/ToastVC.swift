//
//  ToastVC.swift
//  MowJood
//
//  Created by SilverGold on 9/2/20.
//  Copyright © 2020 FAT_MAC. All rights reserved.
//

import UIKit

class ToastVC: UIViewController {

    @IBOutlet weak var vDlg: UIView!
    @IBOutlet weak var lTItle: UILabel!
    @IBOutlet weak var lMsg: UILabel!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    var delegate: ToastDelegate?
    
    var backColor = UIColor.black
    var foreColor = UIColor.white
    var sTitle = ""
    var message = ""
    var bottom = 120.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        initUI()
        startFade()
    }
    
    func initUI(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.0)
        lTItle.textColor = foreColor
        lMsg.textColor = foreColor
        vDlg.backgroundColor = backColor
        vDlg.setCornerRadius(radius: 16)
        lTItle.text = sTitle
        lMsg.text = message
        bottomConstraint.constant = CGFloat(bottom)
    }
    
    func startFade(){
        vDlg.alpha = 0.0
        // fade in
        UIView.animate(withDuration: 0.5, animations: {
            self.vDlg.alpha = 1.0
        }) { (finished) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 1.0, animations: {
                    self.vDlg.alpha = 0.0
                }){ (finished) in
                    self.dismiss(animated: true, completion: nil)
                    self.delegate?.dismissed()
                }
            }
        }
    }
}
