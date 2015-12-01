//
//  Level_Four.swift
//  EggGame
//
//  Created by Yuxiang Tang on 11/16/15.
//  Copyright © 2015 Yuxiang Tang. All rights reserved.
//

import UIKit
import SpriteKit

class Level_Four: GameScene {
    
    override func initLevel() {
        self.currentLevel = 4
    }
    
    override func addHen(){
        self.hen = self.assetViewController.initHen(CGPointMake(30, 300),size: CGSizeMake(80, 80))
        self.addChild(hen)
        
        self.redArrow = self.assetViewController.initArrow(CGPointMake(95, self.screenHeight - 430),size: CGSizeMake(50, 50))
        self.addChild(redArrow)
    }
    
    override func addBall(){
        self.ball = self.assetViewController.initBall(CGPointMake(80, 310),size: CGSizeMake(30, 30))
        self.addChild(ball)
        self.initialEggPosition = self.ball.position
    }
    
    override func addBasket(){
        self.basket = self.assetViewController.initBasket(CGPointMake(self.screenWidth - 50, self.screenHeight - 250),size: CGSizeMake(80, 80),actionArray: self.basketAction)
        self.addChild(self.basket)
    }
    
    override func addTram() {
        var tram = self.assetViewController.initTrampoline("tram", position: CGPointMake(self.screenWidth - 50, 370))
        self.addChild(tram)
    }
    
    override func initStars() {
        self.star_1 = self.assetViewController.initStar("star_1", position: CGPointMake(200, 500))
        self.addChild(self.star_1)
        
        self.star_2 = self.assetViewController.initStar("star_2", position: CGPointMake(80, 200))
        self.addChild(self.star_2)
        
        self.star_3 = self.assetViewController.initStar("star_3", position: CGPointMake(200, 300))
        self.addChild(self.star_3)
    }
    override func addWind() {
        self.wind_1 = self.assetViewController.initWind("wind_1", position: CGPointMake(200, 180))
        self.wind_2 = self.assetViewController.initWindRight("wind_2", position: CGPointMake(25, 220))
        self.addChild(self.wind_1)
        self.addChild(self.wind_2)
    }
    override func addTansP_chicken() {
        transparentButton_chicken.frame=CGRectMake(35,300, 80, 80);
        transparentButton_chicken.setTitleColor(UIColor.whiteColor(),forState: .Normal)
        transparentButton_chicken.setBackgroundImage(UIImage(named:"transparent"),forState:.Normal)
        self.view!.addSubview(transparentButton_chicken);
        transparentButton_chicken.addTarget(self,action:Selector("tapped"),forControlEvents:UIControlEvents.TouchUpInside)
    }
}

