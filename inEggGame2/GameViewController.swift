//
//  GameViewController.swift
//  inEggGame2
//
//  Created by 陈天远 on 15/9/18.
//  Copyright (c) 2015年 陈天远. All rights reserved.
//

import AVFoundation
import UIKit
import SpriteKit

var CURRENTLEVEL: Int = 0

extension SKNode {
    class func unarchiveFromFile(file : String) -> SKNode? {
        if let path = NSBundle.mainBundle().pathForResource(file, ofType: "sks") {
            let sceneData = try! NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            let archiver = NSKeyedUnarchiver(forReadingWithData: sceneData)
            
            archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
            let scene = archiver.decodeObjectForKey(NSKeyedArchiveRootObjectKey) as! GameSelectionScene
            archiver.finishDecoding()
            return scene
        } else {
            return nil
        }
    }
}

class GameViewController: UIViewController {
    
    var backgroundMusicPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
       // if let scene =  GameScene(size:CGSize(width: 1024, height: 768)) as? GameScene {
        if let scene = GameSelectionScene.unarchiveFromFile("GameSelectionScene") as? GameSelectionScene {
            // Configure the view.
            
            let skView = self.view as! SKView
//            skView.showsFPS = true
//            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            
            skView.presentScene(scene)
        }
    }
    
    override func viewWillLayoutSubviews() {
        
        var bgMusicURL = NSBundle.mainBundle().URLForResource("bgMusic", withExtension: "mp3")
        var error: NSError!
        
        do {
            self.backgroundMusicPlayer = try AVAudioPlayer(contentsOfURL: bgMusicURL!)
        } catch let error1 as NSError {
            error = error1
        }
        
        self.backgroundMusicPlayer.numberOfLoops = -1
        self.backgroundMusicPlayer.prepareToPlay()
        self.backgroundMusicPlayer.play()
        
        
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return UIInterfaceOrientationMask.AllButUpsideDown
        } else {
            return UIInterfaceOrientationMask.All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
