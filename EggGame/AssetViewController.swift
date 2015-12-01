//
//  AssetViewController.swift
//  inEggGame2
//
//  Created by Yuxiang Tang on 9/29/15.
//  Copyright (c) 2015 Yuxiang Tang. All rights reserved.
//

import UIKit
import SpriteKit

class AssetViewController: UIViewController {

    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height

    
    //init basic parts
    func initBall(position: CGPoint, size: CGSize)->SKSpriteNode{
        let ball = SKSpriteNode(imageNamed: "egg")
        ball.position=position
        ball.name = "ball"
        ball.size = size
       // ball.physicsBody=SKPhysicsBody(circleOfRadius: ball.size.width / 2)
        
        ball.size.width = 30
        ball.size.height = 40
        ball.physicsBody = SKPhysicsBody(texture: ball.texture!, size: ball.size)
        
        ball.physicsBody?.dynamic = false
        ball.physicsBody?.categoryBitMask=ballCategory
        ball.physicsBody?.contactTestBitMask=basketCategory | sharpRockCategory | starCategory
        ball.zRotation = CGFloat(M_PI) * 2
        
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
    
    func initLeftEdge()->SKSpriteNode{
        let leftEdge=SKSpriteNode(imageNamed: "leftEdge")
        leftEdge.name = "framework"
        leftEdge.size.width = 4
        leftEdge.size.height = 1500
        leftEdge.position=CGPointMake(-2, 70)
        leftEdge.physicsBody=SKPhysicsBody(rectangleOfSize: leftEdge.size)
        leftEdge.physicsBody?.dynamic = false
        
        return leftEdge
    }
    
    func initRightEdge()->SKSpriteNode{
        let rightEdge=SKSpriteNode(imageNamed: "rightEdge")
        rightEdge.name = "framework"
        rightEdge.size.width = 4
        rightEdge.size.height = 1500
        rightEdge.position=CGPointMake(self.screenWidth + 2, 70)
        rightEdge.physicsBody=SKPhysicsBody(rectangleOfSize: rightEdge.size)
        rightEdge.physicsBody?.dynamic = false
        
        return rightEdge
    }
    
    func initUpEdge()->SKSpriteNode{
        let upEdge=SKSpriteNode(imageNamed: "upEdge")
        upEdge.name = "framework"
        upEdge.size.width = 1500
        upEdge.size.height = 4
        upEdge.position=CGPointMake(0, self.screenHeight + 2)
        upEdge.physicsBody=SKPhysicsBody(rectangleOfSize: upEdge.size)
        upEdge.physicsBody?.dynamic = false
        
        return upEdge
    }
    
    
    
    //init movable parts
    func initTriangle(name: String)->SKSpriteNode{
        var triangle = SKSpriteNode(imageNamed: "triangle")
        triangle.name = name
        triangle.size.width = 40
        triangle.size.height = 40
        triangle.position = CGPointMake(60, 35)
        triangle.physicsBody=SKPhysicsBody(texture: triangle.texture!, size: triangle.size)
        triangle.physicsBody?.dynamic = false
        triangle.physicsBody?.categoryBitMask=toolKitCategory
        triangle.physicsBody?.contactTestBitMask = ballCategory
        //  triangle.physicsBody?.collisionBitMask=ballCategory & basketCategory
        return triangle
    }
    
    func initArrow(position: CGPoint, size: CGSize)->SKSpriteNode{
        let arrow=SKSpriteNode(imageNamed: "Arrow_Red_1")
        arrow.size = size
        arrow.anchorPoint = CGPointZero
        arrow.position = position
        
        arrow.zRotation = CGFloat(M_PI) / 2
        let moveUP = SKAction.moveTo(CGPointMake(position.x, position.y), duration: 0.8)
        let moveDOWN = SKAction.moveTo(CGPointMake(position.x, position.y + 50), duration: 0)
        
        let sequence = SKAction.sequence([moveUP, moveDOWN])
        let repeats = SKAction.repeatActionForever(sequence)        
        arrow.runAction(repeats)

        return arrow
    }
    
    func initDoubleTriangle(name: String)->SKSpriteNode{
        let triangle = SKSpriteNode(imageNamed: "double_triangle")
        triangle.name = name
        triangle.size.width = 46
        triangle.size.height = 40
        triangle.position = CGPointMake(230, 35)
        triangle.physicsBody=SKPhysicsBody(texture: triangle.texture!, size: triangle.size)
        triangle.physicsBody?.dynamic = false
        triangle.physicsBody?.categoryBitMask=toolKitCategory
        triangle.physicsBody?.contactTestBitMask = ballCategory
        //  triangle.physicsBody?.collisionBitMask=ballCategory & basketCategory
        return triangle
        
    }
    
    
    func initCloud(name:String) -> SKSpriteNode{
        let cloud = SKSpriteNode(imageNamed: "cloud")
        cloud.name = name
        cloud.position = CGPointMake(310, 35)
        cloud.size.width = 70
        cloud.size.height = 50

        cloud.physicsBody=SKPhysicsBody(rectangleOfSize: CGSizeMake(70, 50))
    
        cloud.physicsBody?.categoryBitMask = cloudCategory
        cloud.physicsBody?.contactTestBitMask=0
        cloud.physicsBody?.dynamic = false
        
        return cloud
    }
    
    func initCloudBack() -> UILabel {
        let cloudBack = UILabel(frame: CGRectMake(270, self.screenHeight - 60, 80, 50))
        cloudBack.backgroundColor = UIColor.whiteColor()
        cloudBack.alpha = 0.3
        cloudBack.layer.cornerRadius = 5
        cloudBack.clipsToBounds = true
        
        return cloudBack
        
    }
    
    func initCloudNum()->UILabel{
        let cloudNum = UILabel(frame: CGRectMake(340, self.screenHeight - 65, 20, 16))
        cloudNum.backgroundColor = UIColor(red: 192 / 255, green: 235 / 255, blue: 215 / 255, alpha: 1.0)
        cloudNum.layer.cornerRadius = 8
        cloudNum.clipsToBounds = true
        cloudNum.tag = 2
        cloudNum.text = String(cloudNum.tag)
        cloudNum.textAlignment = .Center
        cloudNum.textColor = UIColor.whiteColor()
        cloudNum.font = UIFont.boldSystemFontOfSize(12)
        
        return cloudNum
    }

    
    func initStick(name: String)->SKSpriteNode{
        let stick = SKSpriteNode(imageNamed: "longsquare")
        stick.name = name
        stick.size.width = 60
        stick.size.height = 15
        stick.position = CGPointMake(140, 35)
        stick.physicsBody=SKPhysicsBody(rectangleOfSize: stick.size)
        stick.physicsBody?.dynamic = false
        stick.physicsBody?.categoryBitMask=toolKitCategory
        stick.physicsBody?.contactTestBitMask = ballCategory
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
    
    func initRectBack() -> UILabel {
        let rectBack = UILabel(frame: CGRectMake(35, self.screenHeight - 60, 50, 50))
        rectBack.backgroundColor = UIColor.whiteColor()
        rectBack.alpha = 0.3
        rectBack.layer.cornerRadius = 5
        rectBack.clipsToBounds = true
        
        return rectBack
    
    }
    
    func initRectNum()->UILabel{
        let rectNum = UILabel(frame: CGRectMake(75, self.screenHeight - 65, 20, 16))
        rectNum.backgroundColor = UIColor(red: 192 / 255, green: 235 / 255, blue: 215 / 255, alpha: 1.0)
        rectNum.layer.cornerRadius = 8
        rectNum.clipsToBounds = true
        rectNum.tag = 2
        rectNum.text = String(rectNum.tag)
        rectNum.textAlignment = .Center
        rectNum.textColor = UIColor.whiteColor()
        rectNum.font = UIFont.boldSystemFontOfSize(12)
        
        return rectNum
    }
    
    func initStickBack()->UILabel{
        let stickBack = UILabel(frame: CGRectMake(100, self.screenHeight - 50, 80, 30))
        stickBack.backgroundColor = UIColor.whiteColor()
        stickBack.alpha = 0.3
        stickBack.layer.cornerRadius = 5
        stickBack.clipsToBounds = true
        
        return stickBack
    }
    
    func initStickNum()->UILabel{
        let stickNum = UILabel(frame: CGRectMake(170, self.screenHeight - 55, 20, 16))
        stickNum.backgroundColor = UIColor(red: 192 / 255, green: 235 / 255, blue: 215 / 255, alpha: 1.0)
        stickNum.layer.cornerRadius = 8
        stickNum.clipsToBounds = true
        stickNum.tag = 2
        stickNum.text = String(stickNum.tag)
        stickNum.textAlignment = .Center
        stickNum.textColor = UIColor.whiteColor()
        stickNum.font = UIFont.boldSystemFontOfSize(12)
        
        return stickNum
    }
    
    func initDoubleTriBack()->UILabel{
        let doubleTriBack = UILabel(frame: CGRectMake(205, self.screenHeight - 60, 50, 50))
        doubleTriBack.backgroundColor = UIColor.whiteColor()
        doubleTriBack.alpha = 0.3
        doubleTriBack.layer.cornerRadius = 5
        doubleTriBack.clipsToBounds = true
        
        return doubleTriBack
    }
    
    func initDoubleTriNum()->UILabel{
        let doubleTriNum = UILabel(frame: CGRectMake(245, self.screenHeight - 65, 20, 16))
        doubleTriNum.backgroundColor = UIColor(red: 192 / 255, green: 235 / 255, blue: 215 / 255, alpha: 1.0)
        doubleTriNum.layer.cornerRadius = 8
        doubleTriNum.clipsToBounds = true
        doubleTriNum.tag = 2
        doubleTriNum.text = String(doubleTriNum.tag)
        doubleTriNum.textAlignment = .Center
        doubleTriNum.textColor = UIColor.whiteColor()
        doubleTriNum.font = UIFont.boldSystemFontOfSize(12)
        
        return doubleTriNum
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
        var sharpRock = SKSpriteNode(imageNamed: "spike")
        sharpRock.name = name
        sharpRock.position = position
        sharpRock.size.width = 120
        sharpRock.size.height = 80
        sharpRock.physicsBody=SKPhysicsBody(texture: sharpRock.texture!, size: sharpRock.size)
        sharpRock.physicsBody?.categoryBitMask=sharpRockCategory
        sharpRock.physicsBody?.contactTestBitMask=ballCategory
        sharpRock.physicsBody?.dynamic = false
        return sharpRock
    }
    
    func initFireball(name: String, position: CGPoint)->SKSpriteNode{
        var sharpRock = SKSpriteNode(imageNamed: "spike")
        sharpRock.name = name
        sharpRock.position = position
        sharpRock.size.width = 60
        sharpRock.size.height = 80
        sharpRock.physicsBody=SKPhysicsBody(texture: sharpRock.texture!, size: sharpRock.size)
        sharpRock.physicsBody?.categoryBitMask=sharpRockCategory
        sharpRock.physicsBody?.contactTestBitMask=ballCategory
        sharpRock.physicsBody?.dynamic = false
        return sharpRock
    }
    
//    func initFireBall
    
    func initExplode(name: String, position: CGPoint)->SKSpriteNode{
        var explod = SKSpriteNode(imageNamed: "spike")
        explod.name = name
        explod.position = position
        explod.size.width = 100
        explod.size.height = 70
        explod.physicsBody=SKPhysicsBody(texture: explod.texture!, size: explod.size)
        explod.physicsBody?.categoryBitMask=sharpRockCategory
        explod.physicsBody?.contactTestBitMask=ballCategory
        explod.physicsBody?.dynamic = false
        return explod
    }
    
    func initWind(name: String, position: CGPoint) -> SKSpriteNode {
        var blower = SKSpriteNode(imageNamed: "wind_blower1")
        blower.name = name
        blower.size.width = 50
        blower.size.height = 50
        //blower.zRotation = -CGFloat(M_PI/4)
        blower.position = position
        blower.physicsBody = SKPhysicsBody(texture: blower.texture!, size: blower.size)
        blower.physicsBody?.dynamic = false
        
        return blower
    }
    
    func initWindRight(name: String, position: CGPoint) -> SKSpriteNode {
        var blower = SKSpriteNode(imageNamed: "r_wind_blower1")
        blower.name = name
        blower.size.width = 50
        blower.size.height = 50
        //blower.zRotation = -CGFloat(M_PI/4)
        blower.position = position
        blower.physicsBody = SKPhysicsBody(texture: blower.texture!, size: blower.size)
        blower.physicsBody?.dynamic = false
        
        return blower
    }
    
    
    
    func initBubble(name: String, position: CGPoint) -> SKSpriteNode {
        let bubble = SKSpriteNode(imageNamed: "bubble")
        bubble.name = name
        bubble.size.width = 50
        bubble.size.height = 50
        //blower.zRotation = -CGFloat(M_PI/4)
        bubble.position = position
//        bubble.physicsBody=SKPhysicsBody(circleOfRadius: bubble.size.width / 2)
//        //bubble.physicsBody = SKPhysicsBody(texture: bubble.texture!, size: bubble.size)
//        bubble.physicsBody?.dynamic = false
//        bubble.physicsBody?.categoryBitMask=bubbleCategory
//        bubble.physicsBody?.contactTestBitMask=ballCategory
//        bubble.physicsBody?.usesPreciseCollisionDetection = true
        
        return bubble
    }
    
    func initStar(name: String,position: CGPoint)->SKSpriteNode{
        let star = SKSpriteNode(imageNamed: "star_2")
        star.name = name
        star.position = position
        star.size.width = 90
        star.size.height = 70
        //star.physicsBody=SKPhysicsBody(texture: star.texture!, size: star.size)
        star.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0, 0))
        star.physicsBody?.categoryBitMask=starCategory
        star.physicsBody?.contactTestBitMask=0
        star.physicsBody?.usesPreciseCollisionDetection = true
        star.physicsBody?.dynamic = false
        return star
    }
    
    func initExplodeEffect()-> SKAction{
        let oneAnimation1: SKAction
        // 1
        var textures:[SKTexture] = []
        // 2
        
        textures.append(SKTexture(imageNamed: "fireball00"))
        textures.append(SKTexture(imageNamed: "fireball01"))
        textures.append(SKTexture(imageNamed: "fireball02"))
        textures.append(SKTexture(imageNamed: "fireball03"))
        textures.append(SKTexture(imageNamed: "fireball04"))
        textures.append(SKTexture(imageNamed: "fireball05"))
        
        oneAnimation1 = SKAction.animateWithTextures(textures, timePerFrame: 0.08)
        
        return oneAnimation1
        
    }

    
}
