//
//  GameViewController.swift
//  EggGame
//
//  Created by Yuxiang Tang on 11/6/15.
//  Copyright (c) 2015 Yuxiang Tang. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameSelectionScene(size: view.bounds.size)
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

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
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
