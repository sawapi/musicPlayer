//
//  ViewController.swift
//  musicPlayer
//
//  Created by sawapi on 2014/06/05.
//  Copyright (c) 2014年 sawapi. All rights reserved.
//

import UIKit
import MediaPlayer
import AVFoundation

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView : UITableView
    let myTableView: UITableView = UITableView( frame: CGRectZero, style: .Grouped )
    
    var albums: AlbumInfo[] = []
    var songQuery: SongQuery = SongQuery()
    var audio: AVAudioPlayer! = nil
    
    override func viewDidLoad() {
        
        super.viewDidLoad()

        self.title = "Songs"
        
        let stopButton: UIBarButtonItem = UIBarButtonItem( title: "Stop", style:  UIBarButtonItemStyle.Plain, target: self, action: "stop" )
        
        self.navigationItem.rightBarButtonItem = stopButton
        
        albums = songQuery.get()
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()

    }
    
    
     // sectionの数を返す
    func numberOfSectionsInTableView( tableView: UITableView! ) -> Int {
        
        return albums.count
    }
    
    // 各sectionのitem数を返す
    func tableView( tableView: UITableView!, numberOfRowsInSection section: Int ) -> Int  {
        
        return albums[section].songs.count
    }
    
    func tableView( tableView: UITableView?, cellForRowAtIndexPath indexPath:NSIndexPath! ) -> UITableViewCell! {
        
        let cell: UITableViewCell = UITableViewCell( style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell" )
        
        cell.textLabel.text = albums[indexPath.section].songs[indexPath.row].songTitle
        cell.detailTextLabel.text = albums[indexPath.section].songs[indexPath.row].artistName
        
        return cell;
    }
    
    // sectionのタイトル
    func tableView( tableView: UITableView?, titleForHeaderInSection section: Int ) -> String {
        
        return albums[section].albumTitle
    }
    
    // 選択した音楽を再生
    func tableView( tableView: UITableView?, didSelectRowAtIndexPath indexPath:NSIndexPath! ) {
        
        // soundIdからMediaItemを取得
        let songId: NSNumber = albums[indexPath.section].songs[indexPath.row].songId
        let item: MPMediaItem = songQuery.getItem( songId )
        
        let url: NSURL = item.valueForProperty( MPMediaItemPropertyAssetURL ) as NSURL
        
        // これをAVAudioPlayerに突っ込むとエラーでる。。あとで調べる
        //var error: NSError? = nil
        
        // 再生
        audio = AVAudioPlayer( contentsOfURL: url, error: nil )
        audio.play()
        
        self.title = albums[indexPath.section].songs[indexPath.row].songTitle
    }
    
    func stop() {
        
        if audio != nil {
            
            audio.stop()
            self.title = "Songs"
        }

    }
}