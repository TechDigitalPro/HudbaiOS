//
//  YoutubeVC.swift
//  POS
//
//  Created by SilverGold on 8/6/20.
//  Copyright © 2020 Xian. All rights reserved.
//

import UIKit
import YoutubeKit

class YoutubeVC: UIViewController {

    var player: YTSwiftyPlayer!
    var videoId = ""
    var delegate: YTSwiftyPlayerDelegate?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
        }
    
    func showVideo(){
        player = YTSwiftyPlayer(
        frame: CGRect(x: 0, y: 0, width: 640, height: 480),
        playerVars: [
            .playsInline(true),
            .videoID(videoId),
            .loopVideo(false),
            .showRelatedVideo(false),
            .showControls(.hidden)
        ])
        player.delegate = delegate
        player.autoplay = true
        view = player
        player.loadPlayer()
        let request = VideoListRequest(part: [.id, .snippet, .contentDetails], filter: .chart)
        YoutubeAPI.shared.send(request) { result in
            switch result {
            case .success(let response):
                print(response)
            case .failed(let error):
                print(error)
            }
        }
    }
}
