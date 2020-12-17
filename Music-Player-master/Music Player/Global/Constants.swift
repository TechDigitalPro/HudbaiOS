//
//  Config.swift
//  webservicesDemo
//
//  Created by Chun Tianhong on 07/25/19.
//  Copyright © 2019 Chun Tianhong. All rights reserved.
//

import Foundation
import UIKit
import JGProgressHUD
import Alamofire

let userDefaults: UserDefaults = UserDefaults.standard
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let hud = JGProgressHUD(style: .dark)

struct Constants {
    static let BASE_URL = "https://wamusic.net/hudba/mobile/"
    static let Client = "?client=android"
    static let ApiVersion = "&api_version=1"
    
    static let HOME_LIST = BASE_URL + "main/getTotalList" + Client + ApiVersion
    static let SEARCH_LIST = BASE_URL + "main/getSearchList" + Client + ApiVersion
    static let MYPLAY_LIST = BASE_URL + "library/get_user_playlist" + Client + ApiVersion
    static let CREATE_LIST = BASE_URL + "library/create_playlist" + Client + ApiVersion
    static let ALBUM_DETAIL_LIST = BASE_URL + "main/getTrackListDetail" + Client + ApiVersion
    
    static let IS_LOGINED = "is_logined"
    static let U_NAME = "username"
    static let U_PASS = "password"
}







