//
//  Level_Two.swift
//  EggGame
//
//  Created by Yuxiang Tang on 11/16/15.
//  Copyright © 2015 Yuxiang Tang. All rights reserved.
//

import UIKit
import SpriteKit

class Level_Two: GameScene {
    
    override func initLevel() {
        self.currentLevel = 2
    }
    
    override func addHen(){
        self.hen = self.assetViewController.initHen(CGPointMake(self.screenWidth / 2 - 50, self.screenHeight - 150),size: CGSizeMake(80, 80))
        self.addChild(hen)
        
        self.redArrow = self.assetViewController.initArrow(CGPointMake(self.screenWidth / 2 + 20, self.screenHeight - 230),size: CGSizeMake(50, 50))
        self.addChild(redArrow)
        
    }
    
    override func addBall(){
        self.ball = self.assetViewController.initBall(CGPointMake(self.screenWidth / 2, screenHeight - 130),size: CGSizeMake(30, 30))
        self.addChild(ball)
        self.initialEggPosition = self.ball.position
    }
    
    override func addBasket(){
        self.basket = self.assetViewController.initBasket(CGPointMake(screenWidth / 2, 140),size: CGSizeMake(80, 80),actionArray: self.basketAction)
        self.addChild(self.basket)
    }
    
    override func initStars() {
        self.star_1 = self.assetViewController.initStar("star_1", position: CGPointMake(200, 400))
        self.addChild(self.star_1)
        
        self.star_2 = self.assetViewController.initStar("star_2", position: CGPointMake(280, 300))
        self.addChild(self.star_2)
        
        self.star_3 = self.assetViewController.initStar("star_3", position: CGPointMake(200, 200))
        self.addChild(self.star_3)
    }
    
    override func addSharpRock() {
        var sharpRock = self.assetViewController.initSharpRock("rock1", position: CGPointMake(self.screenWidth / 2 , 300))
//        self.sharpRockArray.append(sharpRock)
        self.addChild(sharpRock)
    }
    
    override func addTram() {
        var tram = self.assetViewController.initTrampoline("tram", position: CGPointMake(self.screenWidth - 50, 280))
        tram.zRotation = CGFloat(M_PI) / 2
        self.addChild(tram)
    }
    
    override func addTansP_chicken() {
        transparentButton_chicken.frame=CGRectMake(135,65, 80, 80);
        transparentButton_chicken.setTitleColor(UIColor.whiteColor(),forState: .Normal)
        transparentButton_chicken.setBackgroundImage(UIImage(named:"transparent"),forState:.Normal)
        self.view!.addSubview(transparentButton_chicken);
        transparentButton_chicken.addTarget(self,action:Selector("tapped"),forControlEvents:UIControlEvents.TouchUpInside)
    }
    
    
}
