//
//  HomeVC.swift
//  iSporty
//
//  Created by SilverGold on 12/2/20.
//  Copyright © 2020 Shubham Choudhary. All rights reserved.
//

import UIKit
import SnapKit
import AVFoundation
import MediaPlayer
import YoutubeKit

class MainVC: UIViewController, AVAudioPlayerDelegate {
    
    //######## PlayerView ###########//
    var audioPlayer:AVAudioPlayer! = nil
    var currentAudio = ""
    var currentAudioPath:URL!
    var audioList:NSArray!
    var currentAudioIndex = 0
    var timer:Timer!
    var audioLength = 0.0
    var toggle = true
    var effectToggle = true
    var totalLengthOfAudio = ""
    var finalImage:UIImage!
    var isTableViewOnscreen = false
    var shuffleState = false
    var repeatState = false
    var shuffleArray = [Int]()
    
    

    var youtubVC: YoutubeVC!
    
    @IBOutlet weak var videoContainer: UIView!
    @IBOutlet weak var albumArtworkImageView: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet var songNameLabel : UILabel!
    @IBOutlet var progressTimerLabel : UILabel!
    @IBOutlet var playerProgressSlider : UISlider!
    @IBOutlet var totalLengthOfAudioLabel : UILabel!
    @IBOutlet var previousButton : UIButton!
    @IBOutlet var playButton : UIButton!
    @IBOutlet var nextButton : UIButton!
    @IBOutlet weak var moreImage: UIImageView!
    @IBOutlet weak var shareImage: UIImageView!
    @IBOutlet weak var favorImage: UIImageView!
    
    
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var repeatButton: UIButton!
    @IBOutlet weak var youtubView: UIView!
    
    @IBOutlet weak var miniArtistName: UILabel!
    @IBOutlet weak var miniSongName: UILabel!
    @IBOutlet weak var miniPlayButton: UIButton!
    @IBOutlet weak var miniArtistImage: UIImageView!
    @IBOutlet weak var miniProgress: UIProgressView!
    //######## PlayerView ###########//
    
    //######## PlayerView slide animation #####//
    var trayOriginalBottom: CGFloat!
    var trayDownOffset: CGFloat!
    var trayDown: CGFloat!
    
    @IBOutlet weak var trayView: UIView!
    @IBOutlet weak var tabView: UIView!
    @IBOutlet weak var maxPlayerView: UIView!
    @IBOutlet weak var trayViewBottom: NSLayoutConstraint!
    
    //######## PlayerView slide animation #####//
    
    @IBOutlet weak var iHome: UIImageView!
    @IBOutlet weak var iLibrary: UIImageView!
    @IBOutlet weak var iSearch: UIImageView!
    @IBOutlet weak var vContent: UIView!
      
      
    var currentVC: UINavigationController?
    var selectedIndex: Int = 0
    var mediaType = 0// 0: music, 1: video
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //vContent.backgroundColor = .red
        vContent.setGradientBackground(colorTop: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1), colorBottom: #colorLiteral(red: 0.2877361389, green: 0.2870617444, blue: 0.3500650847, alpha: 1))
        setTab(index: 0)
        UIApplication.shared.applicationIconBadgeNumber = 0
        //######## PlayerView ###########//
        moreImage.image = moreImage.image?.tinted(color: .white)
        shareImage.image = shareImage.image?.tinted(color: .white)
        favorImage.image = UIImage(named: "unfavorite_heart.png")?.tinted(color: .green)
        assingSliderUI()
        setRepeatAndShuffle()
        
        if UIApplication.shared.responds(to: #selector(UIApplication.beginReceivingRemoteControlEvents)){
            UIApplication.shared.beginReceivingRemoteControlEvents()
            UIApplication.shared.beginBackgroundTask(expirationHandler: { () -> Void in
            })
        }
        trayView.hideView()
        
        //######## PlayerView ###########//
        
        //######## PlayerView slide animation #####//
        trayDownOffset = self.view.frame.size.height - 75
        
        trayDown = trayViewBottom.constant - trayDownOffset
        videoContainer.setBorder(color: .lightGray, width: 1)
        videoContainer.setCornerRadius(radius: 5)
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "YoutubeVC") as? YoutubeVC{
            youtubVC = vc
            youtubVC.willMove(toParent: self)
            self.youtubView.addSubview(youtubVC.view)
            youtubVC.view.snp.makeConstraints { (make) in
                make.top.left.bottom.right.equalTo(self.youtubView)
            }
            self.addChild(vc)
            youtubVC.didMove(toParent: self)
        }
        //######## PlayerView slide animation #####//
    }
    
    override func viewDidAppear(_ animated: Bool) {
        moveDown()
    }
    
    
    func showContentVC() {
        switch selectedIndex {
        case 0:
            let stb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = stb.instantiateViewController(withIdentifier: "HomeNav") as? UINavigationController{
                addContentVC(vc: vc)
            }
            break
        case 1:
            let stb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = stb.instantiateViewController(withIdentifier: "LibNav") as? UINavigationController{
                addContentVC(vc: vc)
            }
            break
        case 2:
            let stb = UIStoryboard(name: "Main", bundle: nil)
            if let vc = stb.instantiateViewController(withIdentifier: "SearchNav") as? UINavigationController{
                addContentVC(vc: vc)
            }
            break
        default:
            if let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeNav") as? UINavigationController{
                addContentVC(vc: vc)
            }
            break
        }
    }
    
    
    func addContentVC(vc: UINavigationController){
        addChild(vc)
        vc.view.frame = vContent.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        vc.didMove(toParent: self)
        vContent.addSubview(vc.view)
        vc.view.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.vContent)
        }
        if currentVC != nil {
            currentVC?.view.removeFromSuperview()
        }
        currentVC = vc
    }

   
    @IBAction func bHomeTapped(_ sender: UIButton) {
        setTab(index: 0)
    }
    
    @IBAction func bLibTapped(_ sender: UIButton) {
        setTab(index: 1)
    }
    
    @IBAction func bSearchTapped(_ sender: UIButton) {
        setTab(index: 2)
    }
    
    @IBAction func bFavorTapped(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        favorImage.image = sender.isSelected ? UIImage(named: "favorite_heart.png")?.tinted(color: .green) : UIImage(named: "unfavorite_heart.png")?.tinted(color: .green)
    }
    
    
    
    
    func setTab(index: Int){
        switch index {
        case 0:
            iHome.image = iHome.image?.tinted(color: #colorLiteral(red: 0.1387398541, green: 0.6311670542, blue: 0.09424053878, alpha: 1))
            iLibrary.image = iLibrary.image?.tinted(color: .lightGray)
            iSearch.image = iSearch.image?.tinted(color: .lightGray)
            break
        case 1:
            iLibrary.image = iLibrary.image?.tinted(color: #colorLiteral(red: 0.1387398541, green: 0.6311670542, blue: 0.09424053878, alpha: 1))
            iHome.image = iHome.image?.tinted(color: .lightGray)
            iSearch.image = iSearch.image?.tinted(color: .lightGray)
            break
        case 2:
            iSearch.image = iSearch.image?.tinted(color: #colorLiteral(red: 0.1387398541, green: 0.6311670542, blue: 0.09424053878, alpha: 1))
            iLibrary.image = iLibrary.image?.tinted(color: .lightGray)
            iHome.image = iHome.image?.tinted(color: .lightGray)
            break
        default:
            break
        }
        selectedIndex = index
        showContentVC()
    }
    
    //######## PlayerView ###########//
    
    func showMediaInfo(){
        let artistName = play_list[currentAudioIndex].artist_name
        let songName = play_list[currentAudioIndex].title
        MPNowPlayingInfoCenter.default().nowPlayingInfo = [MPMediaItemPropertyArtist : artistName,  MPMediaItemPropertyTitle : songName]
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        if event!.type == UIEvent.EventType.remoteControl{
            switch event!.subtype{
            case UIEventSubtype.remoteControlPlay:
                play(self)
            case UIEventSubtype.remoteControlPause:
                play(self)
            case UIEventSubtype.remoteControlNextTrack:
                next(self)
            case UIEventSubtype.remoteControlPreviousTrack:
                previous(self)
            default:
                print("There is an issue with the control")
            }
        }
    }

    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return UIStatusBarStyle.default
    }
    
    override var prefersStatusBarHidden : Bool {
        
        if isTableViewOnscreen{
            return true
        }else{
            return false
        }
    }
 
    
    func setRepeatAndShuffle(){
        shuffleButton.setImage(shuffleButton.image(for: .normal)?.tinted(color: .white), for: .normal)
        shuffleButton.setImage(shuffleButton.image(for: .selected)?.tinted(color: .green), for: .selected)
        
        repeatButton.setImage(repeatButton.image(for: .normal)?.tinted(color: .white), for: .normal)
        repeatButton.setImage(repeatButton.image(for: .selected)?.tinted(color: .green), for: .selected)
        
        shuffleState = UserDefaults.standard.bool(forKey: "shuffleState")
        repeatState = UserDefaults.standard.bool(forKey: "repeatState")
        if shuffleState == true {
            shuffleButton.isSelected = true
        } else {
            shuffleButton.isSelected = false
        }
        
        if repeatState == true {
            repeatButton.isSelected = true
        }else{
            repeatButton.isSelected = false
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool){
        if flag == true {
            if shuffleState == false && repeatState == false {
                playButton.setImage( UIImage(named: "ic_play"), for: UIControl.State())
                miniPlayButton.setImage( UIImage(named: "ic_play"), for: UIControl.State())
                return
            
            } else if shuffleState == false && repeatState == true {
                prepareAudio()
                playAudio()
            
            } else if shuffleState == true && repeatState == false {
                shuffleArray.append(currentAudioIndex)
                if shuffleArray.count >= audioList.count {
                    playButton.setImage( UIImage(named: "ic_play"), for: UIControl.State())
                    miniPlayButton.setImage( UIImage(named: "ic_play"), for: UIControl.State())
                    return
                }
                var randomIndex = 0
                var newIndex = false
                while newIndex == false {
                    randomIndex =  Int(arc4random_uniform(UInt32(audioList.count)))
                    if shuffleArray.contains(randomIndex) {
                        newIndex = false
                    }else{
                        newIndex = true
                    }
                }
                currentAudioIndex = randomIndex
                prepareAudio()
                playAudio()
            
            } else if shuffleState == true && repeatState == true {
                shuffleArray.append(currentAudioIndex)
                if shuffleArray.count >= audioList.count {
                    shuffleArray.removeAll()
                }
                var randomIndex = 0
                var newIndex = false
                while newIndex == false {
                    randomIndex =  Int(arc4random_uniform(UInt32(audioList.count)))
                    if shuffleArray.contains(randomIndex) {
                        newIndex = false
                    }else{
                        newIndex = true
                    }
                }
                currentAudioIndex = randomIndex
                prepareAudio()
                playAudio()
            }
        }
    }
    
    func setCurrentAudioPath(){
        currentAudio = readSongNameFromPlist(0)
        currentAudioPath = URL(fileURLWithPath: Bundle.main.path(forResource: currentAudio, ofType: "mp3")!)
    }
    
    
    func saveCurrentTrackNumber(){
        UserDefaults.standard.set(currentAudioIndex, forKey:"currentAudioIndex")
        UserDefaults.standard.synchronize()
        
    }
    
    

    func prepareAudio(){
        updateLabels()
        if mediaType == 2{
            setCurrentAudioPath()
            do {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category(rawValue: convertFromAVAudioSessionCategory(AVAudioSession.Category.playback)))
            } catch _ {
            }
            do {
                try AVAudioSession.sharedInstance().setActive(true)
            } catch _ {
            }
            UIApplication.shared.beginReceivingRemoteControlEvents()
            audioPlayer = try? AVAudioPlayer(contentsOf: currentAudioPath)
            audioPlayer.delegate = self
            
            audioLength = audioPlayer.duration
            playerProgressSlider.maximumValue = CFloat(audioLength)
            playerProgressSlider.minimumValue = 0.0
            playerProgressSlider.value = 0.0
            miniProgress.setProgress(0.0, animated: true)
            audioPlayer.prepareToPlay()
            showTotalSongLength()
            progressTimerLabel.text = "00:00"
        }else{
            let videoId = play_list[currentAudioIndex].videoId
            youtubVC.videoId = videoId
            youtubVC.delegate = self
            youtubVC.showVideo()
        }
    }
    
    func  playAudio(){
        if mediaType == 2{
            audioPlayer.play()
        }else{
            youtubVC.player.playVideo()
        }
        startTimer()
        updateLabels()
        saveCurrentTrackNumber()
        showMediaInfo()
    }
    
    func playNextAudio(){
        currentAudioIndex += 1
        if mediaType == 2{
            if currentAudioIndex>audioList.count-1{
                currentAudioIndex -= 1
                return
            }
            if audioPlayer.isPlaying{
                prepareAudio()
                playAudio()
            }else{
                prepareAudio()
            }
        }else{
            if currentAudioIndex>play_list.count-1{
                currentAudioIndex -= 1
                return
            }
            if youtubVC.player.playerState == .playing{
                prepareAudio()
                playAudio()
            }else{
                prepareAudio()
            }
        }
    }
    
    
    func playPreviousAudio(){
        currentAudioIndex -= 1
        if currentAudioIndex<0{
            currentAudioIndex += 1
            return
        }
        if mediaType == 2{
            if audioPlayer.isPlaying{
                prepareAudio()
                playAudio()
            }else{
                prepareAudio()
            }
        }else{
            if youtubVC.player.playerState == .playing{
                prepareAudio()
                playAudio()
            }else{
                prepareAudio()
            }
        }
        
    }
    
    
    func stopAudiplayer(){
        if mediaType == 2{
            audioPlayer.stop()
        }else{
            youtubVC.player.stopVideo()
        }
    }
    
    func pauseAudioPlayer(){
        if mediaType == 2{
            audioPlayer.pause()
        }else{
            youtubVC.player.pauseVideo()
        }
    }
    
    func startTimer(){
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(update(_:)), userInfo: nil,repeats: true)
            timer.fire()
        }
    }
    
    deinit {
        if timer != nil{
            timer.invalidate()
        }
        
    }
    
    func stopTimer(){
        if timer != nil{
            timer.invalidate()
        }
    }
    
    
    @objc func update(_ timer: Timer){
        if mediaType == 2{
            if !audioPlayer.isPlaying{
                return
            }
            let time = calculateTimeFromNSTimeInterval(audioPlayer.currentTime)
            progressTimerLabel.text  = "\(time.minute):\(time.second)"
            playerProgressSlider.value =  CFloat(audioPlayer.currentTime)
            miniProgress.setProgress(playerProgressSlider.value/playerProgressSlider.maximumValue, animated: true)
            UserDefaults.standard.set(playerProgressSlider.value , forKey: "playerProgressSliderValue")
        }
    }
    

    
    //This returns song length
    func calculateTimeFromNSTimeInterval(_ duration:TimeInterval) ->(minute:String, second:String){
        let minute_ = abs(Int((duration/60).truncatingRemainder(dividingBy: 60)))
        let second_ = abs(Int(duration.truncatingRemainder(dividingBy: 60)))
        let minute = minute_ > 9 ? "\(minute_)" : "0\(minute_)"
        let second = second_ > 9 ? "\(second_)" : "0\(second_)"
        return (minute,second)
    }
    
    func showTotalSongLength(){
        calculateSongLength()
        totalLengthOfAudioLabel.text = totalLengthOfAudio
    }
    
    
    func calculateSongLength(){
        let time = calculateTimeFromNSTimeInterval(audioLength)
        totalLengthOfAudio = "\(time.minute):\(time.second)"
    }
    
    
    //Read plist file and creates an array of dictionary
    func readFromPlist(){
        let path = Bundle.main.path(forResource: "list", ofType: "plist")
        audioList = NSArray(contentsOfFile:path!)
    }
    
    func readArtistNameFromPlist(_ indexNumber: Int) -> String {
        readFromPlist()
        var infoDict = NSDictionary();
        infoDict = audioList.object(at: indexNumber) as! NSDictionary
        let artistName = infoDict.value(forKey: "artistName") as! String
        return artistName
    }
    
    func readAlbumNameFromPlist(_ indexNumber: Int) -> String {
        readFromPlist()
        var infoDict = NSDictionary();
        infoDict = audioList.object(at: indexNumber) as! NSDictionary
        let albumName = infoDict.value(forKey: "albumName") as! String
        return albumName
    }

    
    func readSongNameFromPlist(_ indexNumber: Int) -> String {
        readFromPlist()
        var songNameDict = NSDictionary();
        songNameDict = audioList.object(at: indexNumber) as! NSDictionary
        let songName = songNameDict.value(forKey: "songName") as! String
        return songName
    }
    
    func readArtworkNameFromPlist(_ indexNumber: Int) -> String {
        readFromPlist()
        var infoDict = NSDictionary();
        infoDict = audioList.object(at: indexNumber) as! NSDictionary
        let artworkName = infoDict.value(forKey: "albumArtwork") as! String
        return artworkName
    }

    
    func updateLabels(){
        updateAlbumNameLabel()
        updateSongNameLabel()
        updateAlbumArtwork()
    }
    
   
    
    func updateAlbumNameLabel(){
        var albumName = ""
        if mediaType == 2{
            albumName = "Artist Name"
        }else{
            albumName =  play_list[currentAudioIndex].album_name
        }
        albumNameLabel.text = albumName
        miniArtistName.text = albumName
    }
    
    func updateSongNameLabel(){
        var songName = ""
        if mediaType == 2{
            songName = "Album Name"
        }else{
            songName =  play_list[currentAudioIndex].artist_name
        }
        songNameLabel.text = songName
        miniSongName.text = songName
    }
    
    func updateAlbumArtwork(){
        if mediaType == 2{
            
        }else{
            albumArtworkImageView.af_setImage(withURL: URL(string: play_list[currentAudioIndex].cover_image)!, placeholderImage: UIImage(named: "aaa.jpg"))
            miniArtistImage.af_setImage(withURL: URL(string: play_list[currentAudioIndex].cover_image)!, placeholderImage: UIImage(named: "aaa.jpg"))
        }
    }
    
    func changeMediaType(){
        let mediaType = userDefaults.integer(forKey: "mediaType")
        if mediaType == 0{
            albumArtworkImageView.hideView()
            videoContainer.showView()
        }else{
            albumArtworkImageView.showView()
            videoContainer.hideView()
        }
    }
   
    func assingSliderUI () {
        let minImage = UIImage(named: "slider-track-fill")
        let maxImage = UIImage(named: "slider-track")
        let thumb = UIImage(named: "thumb")
        playerProgressSlider.setMinimumTrackImage(minImage, for: UIControl.State())
        playerProgressSlider.setMaximumTrackImage(maxImage, for: UIControl.State())
        playerProgressSlider.setThumbImage(thumb, for: UIControl.State())
    }
    
    func play(index: Int, type: Int){
        mediaType = type
        trayView.showView()
        albumArtworkImageView.isHidden = mediaType > 0 ? false : true
        videoContainer.isHidden = mediaType > 0 ? true : false
        currentAudioIndex = index
        prepareAudio()
        playAudio()
        playButton.setImage(UIImage(named: "ic_pause"), for: UIControl.State())
        miniPlayButton.setImage( UIImage(named: "ic_pause"), for: UIControl.State())
        
    }
    
    @IBAction func play(_ sender : AnyObject) {
        trayView.showView()
        albumArtworkImageView.isHidden = mediaType > 0 ? false : true
        videoContainer.isHidden = mediaType > 0 ? true : false
        
        if shuffleState == true {
            shuffleArray.removeAll()
        }
        let play = UIImage(named: "ic_play")
        let pause = UIImage(named: "ic_pause")
        if mediaType == 2{
            if audioPlayer.isPlaying{
                pauseAudioPlayer()
            }else{
                playAudio()
            }
            playButton.setImage(audioPlayer.isPlaying ? pause : play, for: UIControl.State())
            miniPlayButton.setImage(audioPlayer.isPlaying ? pause : play, for: UIControl.State())
        }else{
            if youtubVC.player.playerState == .playing{
                pauseAudioPlayer()
            }else{
                playAudio()
            }
        }
    }
    
  
    
    
    @IBAction func next(_ sender : AnyObject) {
        playNextAudio()
    }
    
    
    @IBAction func previous(_ sender : AnyObject) {
        playPreviousAudio()
    }
    
    
    
    
    @IBAction func changeAudioLocationSlider(_ sender : UISlider) {
        if mediaType == 2{
            audioPlayer.currentTime = TimeInterval(sender.value)
        }else{
            youtubVC.player.seek(to: Int(sender.value), allowSeekAhead: true)
        }
        
        
    }
    
    @IBAction func shuffleButtonTapped(_ sender: UIButton) {
        shuffleArray.removeAll()
        if sender.isSelected == true {
        sender.isSelected = false
        shuffleState = false
        UserDefaults.standard.set(false, forKey: "shuffleState")
        } else {
        sender.isSelected = true
        shuffleState = true
        UserDefaults.standard.set(true, forKey: "shuffleState")
        }
    }
    
    
    @IBAction func repeatButtonTapped(_ sender: UIButton) {
        if sender.isSelected == true {
            sender.isSelected = false
            repeatState = false
            UserDefaults.standard.set(false, forKey: "repeatState")
        } else {
            sender.isSelected = true
            repeatState = true
            UserDefaults.standard.set(true, forKey: "repeatState")
        }
    }
    
    @IBAction func bDownTapped(_ sender: UIButton) {
        moveDown()
    }
    
    @IBAction func minViewTapped(_ sender: UIButton) {
        moveUp()
    }
    
    //######## PlayerView slide animation #####//
    @IBAction func didPanTray(_ sender: UIPanGestureRecognizer) {
        //let translation = sender.translation(in: view)
        let velocity = sender.velocity(in: view)
        let translation = sender.translation(in: view)
        print("transsY:", sender.location(in: view).y)
        if sender.location(in: view).y > 400 && velocity.y > 0{
            return
        }
        if sender.state == UIGestureRecognizer.State.began {
            trayOriginalBottom = trayViewBottom.constant
        }else if sender.state == UIGestureRecognizer.State.changed && velocity.y < 0{
            trayViewBottom.constant = trayOriginalBottom - translation.y
        }else if sender.state == UIGestureRecognizer.State.ended {
            if velocity.y > 0 {
                moveDown()
            } else {
                moveUp()
            }
        }
    }
    
    func moveDown(){
        self.tabView.fadeIn(duration: 0.3)
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.trayViewBottom.constant = self.trayDown
            self.view.layoutIfNeeded()
        })
    }
    
    func moveUp(){
        self.tabView.fadeOut(duration: 0.3)
        UIView.animate(withDuration: 0.3, animations: { () -> Void in
            self.trayViewBottom.constant = 0
            self.view.layoutIfNeeded()
        })
    }
    //######## PlayerView slide animation #####//
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromAVAudioSessionCategory(_ input: AVAudioSession.Category) -> String {
    return input.rawValue
}



 //######## PlayerView ###########//
extension MainVC: YTSwiftyPlayerDelegate {
    func playerReady(_ player: YTSwiftyPlayer) {
    }
    
    func player(_ player: YTSwiftyPlayer, didUpdateCurrentTime currentTime: Double) {
        let time = calculateTimeFromNSTimeInterval(currentTime)
        progressTimerLabel.text  = "\(time.minute):\(time.second)"
        playerProgressSlider.value =  CFloat(player.currentTime)
        miniProgress.setProgress(playerProgressSlider.value/playerProgressSlider.maximumValue, animated: true)
        UserDefaults.standard.set(playerProgressSlider.value , forKey: "playerProgressSliderValue")
        print("\(#function): \(currentTime)")
    }
    
    func player(_ player: YTSwiftyPlayer, didChangeState state: YTSwiftyPlayerState) {
        print("\(#function): \(state)")
        let play = UIImage(named: "ic_play")
        let pause = UIImage(named: "ic_pause")
        playButton.setImage(state == .playing ? pause : play, for: UIControl.State())
        miniPlayButton.setImage(state == .playing ? pause : play, for: UIControl.State())
    }
    
    func player(_ player: YTSwiftyPlayer, didChangePlaybackRate playbackRate: Double) {
        print("\(#function): \(playbackRate)")
    }
    
    func player(_ player: YTSwiftyPlayer, didReceiveError error: YTSwiftyPlayerError) {
        print("\(#function): \(error)")
    }
    
    func player(_ player: YTSwiftyPlayer, didChangeQuality quality: YTSwiftyVideoQuality) {
        print("\(#function): \(quality)")
    }
    
    func apiDidChange(_ player: YTSwiftyPlayer) {
        print(#function)
        audioLength = player.duration ?? 0.0
        playerProgressSlider.maximumValue = CFloat(audioLength)
        playerProgressSlider.minimumValue = 0.0
        playerProgressSlider.value = 0.0
        miniProgress.setProgress(0.0, animated: true)
        showTotalSongLength()
        progressTimerLabel.text = "00:00"
    }
    
    func youtubeIframeAPIReady(_ player: YTSwiftyPlayer) {
        print(#function)
    }
    
    func youtubeIframeAPIFailedToLoad(_ player: YTSwiftyPlayer) {
        print(#function)
    }
}
