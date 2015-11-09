//
//  AssetViewController.swift
//  inEggGame2
//
//  Created by Yuxiang Tang on 9/29/15.
//  Copyright (c) 2015 陈天远. All rights reserved.
//

import UIKit
import SpriteKit

class AssetViewController: UIViewController {

    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    let ballCategory:UInt32=0x1 << 1
    let basketCategory:UInt32=0x1 << 5
    let rectCategory:UInt32=0x1 << 2
    let frameCategory:UInt32=0x1 << 3
    let sharpRockCategory:UInt32 = 0x1 << 4
    let bubbleCategory:UInt32 = 0x1 << 6
    
    
    //init basic parts
    func initBall(position: CGPoint, size: CGSize)->SKSpriteNode{
        let ball = SKSpriteNode(imageNamed: "round")
        ball.position=position
        ball.name = "ball"
        ball.size = size
        ball.physicsBody=SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        ball.physicsBody?.dynamic = false
        ball.physicsBody?.categoryBitMask=ballCategory
        ball.physicsBody?.contactTestBitMask=basketCategory | sharpRockCategory
        return ball
    }
    
    func initHen(position: CGPoint, size: CGSize)->SKSpriteNode{
        let hen=SKSpriteNode(imageNamed: "muji")
        hen.size = size
        hen.anchorPoint = CGPointZero
        hen.position = position
        
        return hen
    }
    
    func initBasket(position: CGPoint, size: CGSize, actionArray: [SKAction])->SKSpriteNode{
        let basket=SKSpriteNode(imageNamed: "basket2")
        basket.size = size
        basket.position=position
        basket.physicsBody=SKPhysicsBody(rectangleOfSize: CGSizeMake(50, 1))
        basket.physicsBody?.dynamic = false
        basket.physicsBody?.categoryBitMask=basketCategory
        basket.physicsBody?.contactTestBitMask=ballCategory
//        basket.physicsBody?.collisionBitMask=ballCategory & rectCategory
        basket.physicsBody?.usesPreciseCollisionDetection = true
        
        if actionArray.count != 0 {
            let sequence = SKAction.sequence(actionArray)
            let repeatS = SKAction.repeatActionForever(sequence)
            basket.runAction(repeatS)
        }
        
        return basket
    }
    
    func initFramework()->SKSpriteNode{
        let framework=SKSpriteNode(imageNamed: "framework")
        framework.name = "framework"
        framework.size.width = 1500
        framework.size.height = 3
        framework.position=CGPointMake(0, 70)
        framework.physicsBody=SKPhysicsBody(rectangleOfSize: framework.size)
        framework.physicsBody?.dynamic = false
        
        return framework
    }
    
    //init movable parts
    func initTriangle(name: String,position: CGPoint)->SKSpriteNode{
        let triangle = SKSpriteNode(imageNamed: "triangle")
        triangle.name = name
        triangle.size.width = 40
        triangle.size.height = 40
        triangle.position = position
        triangle.physicsBody=SKPhysicsBody(texture: triangle.texture!, size: triangle.size)
        triangle.physicsBody?.dynamic = false
        triangle.physicsBody?.categoryBitMask=rectCategory
        triangle.physicsBody?.contactTestBitMask = 0
        //  triangle.physicsBody?.collisionBitMask=ballCategory & basketCategory
        return triangle
    }
    
    func initArrow(position: CGPoint, size: CGSize)->SKSpriteNode{
        let arrow=SKSpriteNode(imageNamed: "Arrow_Red_1")
        arrow.size = size
        arrow.anchorPoint = CGPointZero
        arrow.position = position
        
        
        return arrow
    }
    
    func initDoubleTriangle(name: String, position: CGPoint)->SKSpriteNode{
        let triangle = SKSpriteNode(imageNamed: "double_triangle")
        triangle.name = name
        triangle.size.width = 46
        triangle.size.height = 40
        triangle.position = position
        triangle.physicsBody=SKPhysicsBody(texture: triangle.texture!, size: triangle.size)
        triangle.physicsBody?.dynamic = false
        triangle.physicsBody?.categoryBitMask=rectCategory
        triangle.physicsBody?.contactTestBitMask = 0
        //  triangle.physicsBody?.collisionBitMask=ballCategory & basketCategory
        return triangle
    
    }
    
    
    
    func initStick(name: String, position: CGPoint)->SKSpriteNode{
        let stick = SKSpriteNode(imageNamed: "longsquare")
        stick.name = name
        stick.size.width = 60
        stick.size.height = 15
        stick.position = position
        stick.physicsBody=SKPhysicsBody(rectangleOfSize: stick.size)
        stick.physicsBody?.dynamic = false
        stick.physicsBody?.categoryBitMask=rectCategory
        stick.physicsBody?.contactTestBitMask = 0
        //  triangle.physicsBody?.collisionBitMask=ballCategory & basketCategory
    
        return stick
    }
    
    func initStickRotation(name: String)->SKSpriteNode{
        let rotationSign = SKSpriteNode(imageNamed: "rotation")
        rotationSign.name = name
        rotationSign.size.width = 120
        rotationSign.size.height = 120
        rotationSign.position = CGPointMake(100, -500)
        rotationSign.alpha = 0.3
        rotationSign.color = UIColor.blueColor()
        rotationSign.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        //rotationSign.physicsBody=SKPhysicsBody(rectangleOfSize: rotationSign.size)
        rotationSign.physicsBody?.dynamic = false
        //rotationSign.physicsBody?.categoryBitMask=rectCategory
        //rotationSign.physicsBody?.contactTestBitMask = 0
        //  triangle.physicsBody?.collisionBitMask=ballCategory & basketCategory
        
        return rotationSign
    }
    
    //init floating parts
    func initTrampoline(name: String, position: CGPoint)->SKSpriteNode{
        let trampoline=SKSpriteNode(imageNamed: "trampoline")
        trampoline.name = name
        trampoline.size.width = 80
        trampoline.size.height = 30
        trampoline.position = position
        //trampoline.physicsBody=SKPhysicsBody(texture: trampoline.texture, size: trampoline.texture!.size())
        trampoline.physicsBody = SKPhysicsBody(rectangleOfSize: trampoline.size)
        trampoline.physicsBody?.dynamic = false
        trampoline.physicsBody?.restitution = 1.0
    
        return trampoline
    }
    
    func initSharpRock(name: String, position: CGPoint)->SKSpriteNode{
        let sharpRock = SKSpriteNode(imageNamed: "sharprock")
        sharpRock.name = name
        sharpRock.position = position
        sharpRock.size.width = 100
        sharpRock.size.height = 100
        sharpRock.physicsBody=SKPhysicsBody(texture: sharpRock.texture!, size: sharpRock.size)
        sharpRock.physicsBody?.categoryBitMask=sharpRockCategory
        sharpRock.physicsBody?.contactTestBitMask=ballCategory
        sharpRock.physicsBody?.dynamic = false
        return sharpRock
    }
    
    func initExplode(name: String, position: CGPoint)->SKSpriteNode{
        let explod = SKSpriteNode(imageNamed: "hedgehog")
        explod.name = name
        explod.position = position
        explod.size.width = 70
        explod.size.height = 70
        explod.physicsBody=SKPhysicsBody(texture: explod.texture!, size: explod.size)
        explod.physicsBody?.categoryBitMask=sharpRockCategory
        explod.physicsBody?.contactTestBitMask=ballCategory
        explod.physicsBody?.dynamic = false
        return explod
    }
    
    func initWind(name: String, position: CGPoint) -> SKSpriteNode {
        let blower = SKSpriteNode(imageNamed: "wind_blower_right")
        blower.name = name
        blower.size.width = 50
        blower.size.height = 50
        //blower.zRotation = -CGFloat(M_PI/4)
        blower.position = position
        blower.physicsBody = SKPhysicsBody(texture: blower.texture!, size: blower.size)
        blower.physicsBody?.dynamic = false
        
        return blower
    }
    
    func scoreSystem (anotherInt1: Int) -> String {
        
       // let anotherInt1 = NSUserDefaults.standardUserDefaults().integerForKey("myInt1")
        var scoreInt1 = "D";
        if (anotherInt1>6){
            scoreInt1 = "D";
        }
        if (anotherInt1<=6 && anotherInt1>4){
            scoreInt1 = "C";
        }
        if (anotherInt1<=4 && anotherInt1>2){
            scoreInt1 = "B";
        }
        if (anotherInt1<=2 && anotherInt1>1){
            scoreInt1 = "A";
        }
        if(anotherInt1<=1){
            scoreInt1 = "None";
        }
        return scoreInt1;
        
    }
    
    func initBubble(name: String, position: CGPoint) -> SKSpriteNode {
        let bubble = SKSpriteNode(imageNamed: "bubble")
        bubble.name = name
        bubble.size.width = 60
        bubble.size.height = 50
        //blower.zRotation = -CGFloat(M_PI/4)
        bubble.position = position
        bubble.physicsBody=SKPhysicsBody(circleOfRadius: bubble.size.width / 2)
        //bubble.physicsBody = SKPhysicsBody(texture: bubble.texture!, size: bubble.size)
        bubble.physicsBody?.dynamic = false
        bubble.physicsBody?.categoryBitMask=bubbleCategory
        bubble.physicsBody?.contactTestBitMask=ballCategory
        bubble.physicsBody?.usesPreciseCollisionDetection = true
        
        return bubble
    }

    
    

    
    
    
}
