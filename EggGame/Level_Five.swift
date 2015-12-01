//
//  Level_Five.swift
//  EggGame
//
//  Created by Yuxiang Tang on 11/16/15.
//  Copyright © 2015 Yuxiang Tang. All rights reserved.
//

import UIKit
import SpriteKit

class Level_Five: GameScene {
    
    override func initLevel() {
        self.currentLevel = 5
    }
    
    override func addHen(){
        self.hen = self.assetViewController.initHen(CGPointMake(50, 400),size: CGSizeMake(80, 80))
        self.addChild(hen)
        
        self.redArrow = self.assetViewController.initArrow(CGPointMake(100, 350),size: CGSizeMake(50, 50))
        self.addChild(redArrow)
    }
    
    override func addBall(){
        self.ball = self.assetViewController.initBall(CGPointMake(85, 430),size: CGSizeMake(30, 30))
        self.addChild(ball)
        self.initialEggPosition = self.ball.position
    }
    
    override func addBasket(){
        self.basket = self.assetViewController.initBasket(CGPointMake(self.screenWidth - 50, self.screenHeight - 250),size: CGSizeMake(80, 80),actionArray: self.basketAction)
        self.addChild(self.basket)
    }
    
    override func initStars() {
        self.star_1 = self.assetViewController.initStar("star_1", position: CGPointMake(200, 400))
        self.addChild(self.star_1)
        
        self.star_2 = self.assetViewController.initStar("star_2", position: CGPointMake(100, 300))
        self.addChild(self.star_2)
        
        self.star_3 = self.assetViewController.initStar("star_3", position: CGPointMake(200, 200))
        self.addChild(self.star_3)
    }
    
    override func addWind() {
        
        self.wind_2 = self.assetViewController.initWindRight("wind_2", position: CGPointMake(25, 220))
        self.wind_3 = self.assetViewController.initWindRight("wind_3", position: CGPointMake(140, 550))
        self.addChild(self.wind_3)
        self.addChild(self.wind_2)
    }
    
    override func addTansP_chicken() {
        transparentButton_chicken.frame=CGRectMake(60,200, 80, 80);
        transparentButton_chicken.setTitleColor(UIColor.whiteColor(),forState: .Normal)
        transparentButton_chicken.setBackgroundImage(UIImage(named:"transparent"),forState:.Normal)
        self.view!.addSubview(transparentButton_chicken);
        transparentButton_chicken.addTarget(self,action:Selector("tapped"),forControlEvents:UIControlEvents.TouchUpInside)
    }
    
    override func addBubble() {
        
        self.bubble = self.assetViewController.initBubble("bubble_static", position: CGPointMake(200, 120))
        self.initialBubblePosition = self.bubble.position
        self.addChild(self.bubble)
    }
    
    
    
}
