//
//  Level_One.swift
//  EggGame
//
//  Created by Yuxiang Tang on 11/16/15.
//  Copyright © 2015 Yuxiang Tang. All rights reserved.
//

import UIKit
import SpriteKit

class Level_One: GameScene {
    
     override func addHen(){
        self.hen = self.assetViewController.initHen(CGPointMake(30, self.screenHeight - 150),size: CGSizeMake(80, 80))
        self.addChild(hen)
    
        self.redArrow = self.assetViewController.initArrow(CGPointMake(100, self.screenHeight - 220),size: CGSizeMake(50, 50))
        self.addChild(redArrow)
    }
    
    override func addBall(){
        self.ball = self.assetViewController.initBall(CGPointMake(70, screenHeight - 130),size: CGSizeMake(30, 30))
        self.addChild(ball)
        self.initialEggPosition = self.ball.position
    }
    
    override func addBasket(){
        self.basket = self.assetViewController.initBasket(CGPointMake(screenWidth - 80, 140),size: CGSizeMake(80, 80), actionArray: self.basketAction)
        self.addChild(self.basket)
    }
    
    override func initStars() {
        self.star_1 = self.assetViewController.initStar("star_1", position: CGPointMake(50, 400))
        self.addChild(self.star_1)
        
        self.star_2 = self.assetViewController.initStar("star_2", position: CGPointMake(150, 300))
        self.addChild(self.star_2)
        
        self.star_3 = self.assetViewController.initStar("star_3", position: CGPointMake(200, 200))
        self.addChild(self.star_3)
    }
    
    override func initLevel() {
        self.currentLevel = 1
    }
    
}
