//
//  Level_Three.swift
//  EggGame
//
//  Created by Yuxiang Tang on 11/16/15.
//  Copyright © 2015 Yuxiang Tang. All rights reserved.
//

import UIKit
import SpriteKit

class Level_Three: GameScene {
    
    override func initLevel() {
        self.currentLevel = 3
    }
    
    override func addHen(){
        self.hen = self.assetViewController.initHen(CGPointMake(30, self.screenHeight - 150),size: CGSizeMake(80, 80))
        self.addChild(hen)
        
        self.redArrow = self.assetViewController.initArrow(CGPointMake(100, self.screenHeight - 200),size: CGSizeMake(50, 50))
        self.addChild(redArrow)
    }
    
    override func addBall(){
        self.ball = self.assetViewController.initBall(CGPointMake(70, screenHeight - 130),size: CGSizeMake(30, 30))
        self.addChild(ball)
        self.initialEggPosition = self.ball.position
    }
    
    override func addBasket(){
        let moveRight = SKAction.moveTo(CGPointMake(self.screenWidth - 50, 120), duration: 2.0)
        let moveLeft = SKAction.moveTo(CGPointMake(50, 120), duration: 2.0)
        self.basketAction.append(moveRight)
        self.basketAction.append(moveLeft)
        
        self.basket = self.assetViewController.initBasket(CGPointMake(50, 120),size: CGSizeMake(80, 80),actionArray: self.basketAction)
        self.addChild(self.basket)
    }

    override func initStars() {
        self.star_1 = self.assetViewController.initStar("star_1", position: CGPointMake(200, 400))
        self.addChild(self.star_1)
        
        self.star_2 = self.assetViewController.initStar("star_2", position: CGPointMake(120, 300))
        self.addChild(self.star_2)
        
        self.star_3 = self.assetViewController.initStar("star_3", position: CGPointMake(200, 200))
        self.addChild(self.star_3)
 //       let RollingStar: SKAction
//                // 1
//                var texturesStar:[SKTexture] = []
//                // 2
//        
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_1"))
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_2"))
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_3"))
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_4"))
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_5"))
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_6"))
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_7"))
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_8"))
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_9"))
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_10"))
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_11"))
//                texturesStar.append(SKTexture(imageNamed: "rotating_star_12"))
//        
//        
//        
//        
//                RollingStar = SKAction.repeatActionForever(SKAction.animateWithTextures(texturesStar,timePerFrame: 0.1))
//                star_1.runAction(SKAction.repeatActionForever(RollingStar))
//                star_2.runAction(SKAction.repeatActionForever(RollingStar))
//                star_3.runAction(SKAction.repeatActionForever(RollingStar))
    }
    
    override func addFireBall() {
        self.fireball_1 = self.assetViewController.initFireball("rock",position: CGPointMake(100, 400))
        self.addChild(fireball_1)
        self.fireball_2 = self.assetViewController.initFireball("rock1", position: CGPointMake(self.screenWidth - 100, 300))
        self.addChild(self.fireball_2)
        self.fireball_3 = self.assetViewController.initFireball("rock2", position: CGPointMake(100, 200))
        self.addChild(self.fireball_3)
        
                let oneAnimationFire: SKAction
                // 1
                var texturesFire:[SKTexture] = []
                // 2
        
                texturesFire.append(SKTexture(imageNamed: "fire_2"))
                texturesFire.append(SKTexture(imageNamed: "fire_1"))
                texturesFire.append(SKTexture(imageNamed: "fire_3"))
                texturesFire.append(SKTexture(imageNamed: "fire_4"))
        
        
                oneAnimationFire = SKAction.repeatActionForever(SKAction.animateWithTextures(texturesFire,timePerFrame: 0.1))
                fireball_1.runAction(SKAction.repeatActionForever(oneAnimationFire))
                fireball_2.runAction(SKAction.repeatActionForever(oneAnimationFire))
                fireball_3.runAction(SKAction.repeatActionForever(oneAnimationFire))
    }
    

    
    
    
}
