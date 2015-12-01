//
//  GameScene.swift
//  inEggGame2
//
//  Created by Yuxiang Tang on 10/2/15.
//  Copyright (c) 2015 Yuxiang Tang. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var currentLevel = 0
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    var keepUpdate = true

    
    var lastYieldTimeInterval:NSTimeInterval=NSTimeInterval()
    var lastUpdateTimeInterval:NSTimeInterval=NSTimeInterval()
    var timeSinceLastUpdate:NSTimeInterval=NSTimeInterval()
    var example:SKSpriteNode=SKSpriteNode()//just for compare
        
    var ball:SKSpriteNode!
    var initialEggPosition: CGPoint!
    var initialBubblePosition: CGPoint!
    var lastBubblePosition: CGPoint!
    
    var hen:SKSpriteNode!
    var basket:SKSpriteNode!
    var rect0:SKSpriteNode!
    var rect1:SKSpriteNode!
    var doubleTri0: SKSpriteNode!
    var doubleTri1: SKSpriteNode!
    var stick0: SKSpriteNode!
    var stick1: SKSpriteNode!
    var stickRotate0: SKSpriteNode!
    var stickRotate1: SKSpriteNode!
    var wind_1:SKSpriteNode!
    var wind_2:SKSpriteNode!
    var wind_3:SKSpriteNode!
    var cloud0: SKSpriteNode!
    var cloud1: SKSpriteNode!
    var background:SKSpriteNode!
    
    var star_1:SKSpriteNode!
    var star_2:SKSpriteNode!
    var star_3:SKSpriteNode!
    
    var fireball_1:SKSpriteNode!
    var fireball_2:SKSpriteNode!
    var fireball_3:SKSpriteNode!
    
    var bubble: SKSpriteNode!
    
    
    var rectBack: UILabel!
    var rectNum: UILabel!
    var stickBack: UILabel!
    var stickNum: UILabel!
    var doubleTriBack: UILabel!
    var doubleTriNum: UILabel!
    var cloudBack: UILabel!
    var cloudNum: UILabel!
    
    var framework:SKSpriteNode!
    var redArrow:SKSpriteNode!
    var leftEdge: SKSpriteNode!
    var rightEdge: SKSpriteNode!
    var upEdge: SKSpriteNode!
    
    var basketAction = [SKAction]()
    
    //var sharpRockArray = [SKSpriteNode]()
    
    
    var bloodLabel: UIView!
    var bloodOne: UIImageView!
    var bloodTwo: UIImageView!
    var bloodThree: UIImageView!
    
    var HP: Int = 3
    var lastCrackVelocity: CGFloat = 0
    var lastCollideObject: String!
    //for cloud
    var initialSpeed: CGFloat = 0
    var speedFlag = false
    
    
   // var trampoline:SKSpriteNode!
    
    var isPlaceRectangle = false
    var isPlaceStick = false
    var temp:String = "label"
    var menuButton:UIButton = UIButton(type: UIButtonType.System);
    var playButton:UIButton = UIButton(type: UIButtonType.System);
    var transparentButton_chicken:UIButton = UIButton(type: UIButtonType.System);
    
    var menuView: UIView!
    var syncProgress: UIButton!
    var resetAssetsButton: UIButton!
    var returnGameSelectionButton: UIButton!
    var transparentButton: UIButton!
    var blurView: UIVisualEffectView!
    var endBlurView: UIVisualEffectView!
    
    var star1Removed = false
    var star2Removed = false
    var star3Removed = false
    var starCollideCount = 0
    
    //end of game
    var mainLabel: UILabel!
    var nextLevel:UIButton!
    var playAgain:UIButton!
    var goToLevelSelection: UIButton!
   // var scoreLabel: UILabel!
    var starScoreImageView: UIImageView!
    var starImage1: UIImageView!
    var starImage2: UIImageView!
    var starImage3: UIImageView!
    var currentScoreLabel: UILabel!
    
    var assetViewController: AssetViewController!
    
    override init(size: CGSize){
        super.init(size: size)
    }
    required init?(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)
    }
    
    override func didMoveToView(view: SKView) {
        
        self.initMenu()
        self.assetViewController = AssetViewController()
        self.initLevel()
        /* Setup your scene here */
        
        let background = SKSpriteNode(imageNamed: "background_green")
        background.alpha = 0.8
    //    background.position = CGpoint (x: screenWidth/2, y: screenHeight/2 )
        background.position = CGPointMake(screenWidth/2, screenHeight/2)
        background.size.width = self.screenWidth / 2 * 3
        
        background.size.height = self.screenHeight
        background.zPosition = -1
        self.addChild(background)
        
        self.backgroundColor=SKColor.whiteColor()
        
        self.physicsWorld.gravity=CGVectorMake(0, -1.8)
        
        menuButton.frame=CGRectMake(self.screenWidth-50, 20, 30, 30);
        menuButton.setTitleColor(UIColor.whiteColor(),forState: .Normal)
        menuButton.setBackgroundImage(UIImage(named:"menu2"),forState:.Normal)
        menuButton.addTarget(self, action: "goToMenu:", forControlEvents: UIControlEvents.TouchUpInside)
        self.view!.addSubview(menuButton);
        
        
        playButton.frame=CGRectMake(20, 20, 35, 35);
        playButton.setTitleColor(UIColor.whiteColor(),forState: .Normal)
        playButton.setBackgroundImage(UIImage(named:"start2"),forState:.Normal)
        self.view!.addSubview(playButton);
        playButton.addTarget(self,action:Selector("tapped"),forControlEvents:UIControlEvents.TouchUpInside)
        
        
        let bloodLabelFrame = CGRectMake(self.screenWidth / 2 - 60, 10, 120, 30)
        self.bloodLabel = UILabel(frame: bloodLabelFrame)
        self.bloodLabel.layer.cornerRadius = 5
        self.bloodLabel.clipsToBounds = true
        self.bloodLabel.backgroundColor = UIColor.whiteColor()
        self.bloodLabel.alpha = 0.5
        self.view?.addSubview(bloodLabel)
        
        self.bloodOne = UIImageView(frame: CGRectMake(5, 0, 30, 30))
        self.bloodTwo = UIImageView(frame: CGRectMake(45, 0, 30, 30))
        self.bloodThree = UIImageView(frame: CGRectMake(85, 0, 30, 30))
        self.bloodLabel.addSubview(self.bloodOne)
        self.bloodLabel.addSubview(self.bloodTwo)
        self.bloodLabel.addSubview(self.bloodThree)
        
        
        /*------basic parts------*/
        self.addHen()
        self.addBall()
        self.addBasket()
        self.initStars()
        self.addSharpRock()
        self.addTram()
        self.addWind()
        self.addFireBall()
        self.addTansP_chicken()
        self.addwindRight()
        self.addBubble()
        
        self.framework = self.assetViewController.initFramework()
        self.addChild(self.framework)
        
        self.leftEdge = self.assetViewController.initLeftEdge()
        self.addChild(self.leftEdge)
        
        self.rightEdge = self.assetViewController.initRightEdge()
        self.addChild(self.rightEdge)
        
        self.upEdge = self.assetViewController.initUpEdge()
        self.addChild(self.upEdge)
        
        /*------------------------*/
        
        

        
        /*------movable parts------*/
        // 2 triagnle
        self.rect0 = self.assetViewController.initTriangle("rect0")
        self.addChild(rect0)
        
        self.rect1 = self.assetViewController.initTriangle("rect1")
        self.addChild(rect1)
        
        //2 stick rotate signs
        self.stickRotate0 = self.assetViewController.initStickRotation("rot0")
        self.stickRotate1 = self.assetViewController.initStickRotation("rot1")
        //self.stickRotate0.position = CGPointMake(100, 100)
        self.addChild(self.stickRotate0)
        self.addChild(self.stickRotate1)
        
        
        // 2 stick
        self.stick0 = self.assetViewController.initStick("stick0")
        self.addChild(self.stick0)
        
        self.stick1 = self.assetViewController.initStick("stick1")
        self.addChild(self.stick1)
        
        
        // 2 double triangle
        self.doubleTri0 = self.assetViewController.initDoubleTriangle("dou0")
        self.addChild(self.doubleTri0)
        self.doubleTri1 = self.assetViewController.initDoubleTriangle("dou1")
        self.addChild(self.doubleTri1)
        
        
        self.rectBack = self.assetViewController.initRectBack()
        self.view?.addSubview(self.rectBack)
        
        self.rectNum = self.assetViewController.initRectNum()
        self.view?.addSubview(self.rectNum)
        
        self.stickBack = self.assetViewController.initStickBack()
        self.stickNum = self.assetViewController.initStickNum()
        self.view?.addSubview(self.stickBack)
        self.view?.addSubview(self.stickNum)
        
        self.doubleTriBack = self.assetViewController.initDoubleTriBack()
        self.doubleTriNum = self.assetViewController.initDoubleTriNum()
        self.view?.addSubview(self.doubleTriBack)
        self.view?.addSubview(self.doubleTriNum)
        
        //cloud
        self.cloud0 = self.assetViewController.initCloud("cloud0")
        self.addChild(self.cloud0)
        
        self.cloud1 = self.assetViewController.initCloud("cloud1")
        self.addChild(self.cloud1)
        
        self.cloudBack = self.assetViewController.initCloudBack()
        self.view?.addSubview(self.cloudBack)
        self.cloudNum = self.assetViewController.initCloudNum()
        self.view?.addSubview(self.cloudNum)
        
        /*--------------------------*/
        
        self.physicsWorld.contactDelegate = self
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: "rotateStick:")
        self.view?.addGestureRecognizer(rotationGesture)
        
        
    }
    
    func addTansP_chicken(){
        transparentButton_chicken.frame=CGRectMake(35,65, 80, 80);
        transparentButton_chicken.setTitleColor(UIColor.whiteColor(),forState: .Normal)
        transparentButton_chicken.setBackgroundImage(UIImage(named:"transparent"),forState:.Normal)
        self.view!.addSubview(transparentButton_chicken);
        transparentButton_chicken.addTarget(self,action:Selector("tapped"),forControlEvents:UIControlEvents.TouchUpInside)
        
    }
    
    func initLevel(){
        self.currentLevel = 0
    }
    
    func addHen(){
        self.hen = self.assetViewController.initHen(CGPointMake(30, self.screenHeight - 150),size: CGSizeMake(80, 80))
        self.addChild(hen)
        
        self.redArrow = self.assetViewController.initArrow(CGPointMake(100, self.screenHeight - 200),size: CGSizeMake(50, 50))
        self.addChild(redArrow)
    }
    
    func addBall(){
        self.ball = self.assetViewController.initBall(CGPointMake(70, screenHeight - 130),size: CGSizeMake(30, 30))
        self.addChild(ball)
    }
    
    func addBasket(){
        self.basket = self.assetViewController.initBasket(CGPointMake(screenWidth - 80, 140),size: CGSizeMake(80, 80), actionArray: self.basketAction)
        self.addChild(self.basket)
    }
    

    func initStars(){
        
        
        
    }
    
    func addSharpRock(){
        //init sharp rock array
//        var sharpRock = self.assetViewController.initSharpRock("rock1", position: CGPointMake(self.screenWidth / 2 , 300))
//        // self.sharpRockArray.append(sharpRock)
//        self.addChild(sharpRock)
    }
    
    func addWind(){
        //init wind
    }
    
    func addwindRight(){
        
    }
    
    func addTram(){
        //init tram
    }
    
    func addFireBall(){
        //init fire ball
    }
    
    func addBubble(){
    
    }
    
    

    
    func rotateStick(recognizer: UIRotationGestureRecognizer){
        
        if recognizer.numberOfTouches() == 2 {
            if recognizer.locationOfTouch(0, inView: self.view).y > self.framework.position.y && recognizer.locationOfTouch(1, inView: self.view).y > self.framework.position.y {
                
                let locA = recognizer.locationOfTouch(0, inView: self.view)
                let locB = recognizer.locationOfTouch(1, inView: self.view)
                
                if let bodyA = self.physicsWorld.bodyAtPoint(CGPointMake(locA.x, self.screenHeight - locA.y)){
                    if let bodyB = self.physicsWorld.bodyAtPoint(CGPointMake(locB.x, self.screenHeight - locB.y)){
                        if bodyA.node!.name == bodyB.node!.name && bodyB.node!.name == "rot0" {
                            self.stick0.zRotation = -recognizer.rotation*1.2
                            self.stickRotate0.zRotation = -recognizer.rotation*1.2
                            
                        }
                        if bodyA.node!.name == bodyB.node!.name && bodyB.node!.name == "rot1" {
                            self.stick1.zRotation = -recognizer.rotation*1.2
                            self.stickRotate1.zRotation = -recognizer.rotation*1.2
                            
                        }
                    }
                }
                
            }
        }
    }

    
    
    func tapped(){
        print("tapped")
        ball.physicsBody?.dynamic = true
        
        if self.bubble != nil {
            self.bubble.name = "bubble"
        }
        rect0.name = "rect0static"
        rect1.name = "rect1static"
        self.stick0.name = "stick0static"
        self.stick1.name = "stick0static"
        self.doubleTri0.name = "double0static"
        self.doubleTri1.name = "double1static"
        
        self.cloud0.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0, 0))
        self.cloud1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(0, 0))
        
        //playButton.removeTarget(self, action: Selector("tapped"), forControlEvents: UIControlEvents.TouchUpInside)
        self.playButton.hidden = true
        self.menuButton.hidden = true
        self.transparentButton_chicken.hidden = true
        self.redArrow.hidden = true
        
        self.stickRotate0.hidden = true
        self.stickRotate1.hidden = true
        self.stickRotate0.physicsBody = nil
        self.stickRotate1.physicsBody = nil
    }
    

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
        
        
        //update blood label
        var emptyBlood = UIImage(named: "heart_empty")
        var fullBlood = UIImage(named: "heart")
        switch self.HP {
        case 3:
            self.bloodOne.image = fullBlood
            self.bloodThree.image = fullBlood
            self.bloodTwo.image = fullBlood
            break
        case 2:
            self.bloodOne.image = fullBlood
            self.bloodThree.image = emptyBlood
            self.bloodTwo.image = fullBlood
            break
        case 1:
            self.bloodOne.image = fullBlood
            self.bloodThree.image = emptyBlood
            self.bloodTwo.image = emptyBlood
            break
        case 0:
            self.bloodOne.image = emptyBlood
            self.bloodThree.image = emptyBlood
            self.bloodTwo.image = emptyBlood
            break
        default:
            self.bloodOne.image = emptyBlood
            self.bloodThree.image = emptyBlood
            self.bloodTwo.image = emptyBlood
            break
        }
        
        
        
        
        
        var newAnimation: SKAction
        
        var textures:[SKTexture] = []
        
//        textures.append(SKTexture(imageNamed: "starDisappear_1"))
//        textures.append(SKTexture(imageNamed: "starDisappear_2"))
        textures.append(SKTexture(imageNamed: "starDisappear_3"))
        textures.append(SKTexture(imageNamed: "starDisappear_4"))
//        textures.append(SKTexture(imageNamed: "transparent"))
        //textures.append(SKTexture(imageNamed: "star_2"))

        
        if(self.ball.position.x <= self.star_1.position.x+50 && self.ball.position.x >= self.star_1.position.x-50 && self.ball.position.y <= self.star_1.position.y+50 && self.ball.position.y >= self.star_1.position.y-50){
            newAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.05)
        
            //self.star_1.runAction(newAnimation)
            self.star_1.runAction(newAnimation, completion:{
                
                if self.star1Removed == false {
                    self.star_1.removeFromParent()
                    self.star1Removed = true
                    self.starCollideCount++
                }
                }
            )
        }
        
        if(self.ball.position.x <= self.star_2.position.x+50 && self.ball.position.x >= self.star_2.position.x-50 && self.ball.position.y <= self.star_2.position.y+50 && self.ball.position.y >= self.star_2.position.y-50){
            newAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.03)
            
            self.star_2.runAction(newAnimation, completion:{
                if self.star2Removed == false {
                    self.star_2.removeFromParent()
                    self.star2Removed = true
                    self.starCollideCount++
                }
                }
            )
        }
        
        if(self.ball.position.x <= self.star_3.position.x+50 && self.ball.position.x >= self.star_3.position.x-50 && self.ball.position.y <= self.star_3.position.y+50 && self.ball.position.y >= self.star_3.position.y-50){
            newAnimation = SKAction.animateWithTextures(textures, timePerFrame: 0.03)
            
            self.star_3.runAction(newAnimation, completion:{
                if self.star3Removed == false {
                    self.star_3.removeFromParent()
                    self.star3Removed = true
                    self.starCollideCount++
                }                }
                
            )
        }
        
        
        
        if self.bubble != nil {
            if self.ball.position.x >= self.bubble.position.x - 20 && self.ball.position.x <= self.bubble.position.x + 20 && self.ball.position.y >= self.bubble.position.y - 20 && self.ball.position.y <= self.bubble.position.y + 20 {
                //egg is close to bubble
                self.bubbleDidCollideWithBall()
            }
        
        }
        
        
        
        if self.ball.position.x >= self.cloud0.position.x - 35 && self.ball.position.x <= self.cloud0.position.x + 35 && self.ball.position.y >= self.cloud0.position.y - 25 && self.ball.position.y <= self.cloud0.position.y + 25 {
            
            if self.speedFlag == false {
                self.initialSpeed = self.ball.physicsBody!.velocity.dy * 0.2
                self.speedFlag = true
            }
            self.ball.physicsBody?.velocity.dy = self.initialSpeed
            print("slow down!!!!!")
        }else {
            //            self.ball.physicsBody?.affectedByGravity = true
        }
        
        if self.ball.position.x >= self.cloud1.position.x - 35 && self.ball.position.x <= self.cloud1.position.x + 35 && self.ball.position.y >= self.cloud1.position.y - 25 && self.ball.position.y <= self.cloud1.position.y + 25 {
            
            if self.speedFlag == false {
                self.initialSpeed = self.ball.physicsBody!.velocity.dy * 0.2
                self.speedFlag = true
            }
            self.ball.physicsBody?.velocity.dy = self.initialSpeed
            print("slow down!!!!!")
        }else {
            //            self.ball.physicsBody?.affectedByGravity = true
        }
    
        if(timeSinceLastUpdate>1){
            lastUpdateTimeInterval=currentTime
            
            if(ball.position.y<=framework.position.y+30){
                print("conlision with framework")
                
                if self.keepUpdate {
                    self.gameEnd(false)
                }
                
            }
            if(ball.physicsBody?.dynamic == true){
                if(example.position==ball.position){
                    if self.keepUpdate {
                        self.gameEnd(false)
                    }

                }
                else{
                    example.position = ball.position
                }
            }
            
        }
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        let touch =  (touches as NSSet).anyObject() as! UITouch!
        let location = touch.locationInNode(self)
        print("000")
        
        if let body = self.physicsWorld.bodyAtPoint(location){
            //    println("111")
            print(body.node!.name)
            
            if body.node!.name == "rect0" {
                print("place a rectangle")
                isPlaceRectangle = true
                temp = "rect0"
            }
            
            if body.node!.name == "rect1" {
                print("place a rectangle")
                isPlaceRectangle = true
                temp = "rect1"
            }
            
            if body.node?.name == "dou0" {
                isPlaceRectangle = true
                temp = "dou0"
            }
            
            if body.node?.name == "dou1" {
                isPlaceRectangle = true
                temp = "dou1"
            }
            
            if body.node?.name == "stick0" {
                isPlaceStick = true
                temp = "stick0"
            }
            if body.node?.name == "stick1" {
                isPlaceStick = true
                temp = "stick1"
            }
            
            if body.node?.name == "rot0" {
                isPlaceStick = true
                temp = "rot0"
            }
            
            if body.node?.name == "rot1" {
                isPlaceStick = true
                temp = "rot1"
            }
            
            if body.node?.name == "cloud0" {
                isPlaceRectangle = true
                temp = "cloud0"
            }
            
            if body.node?.name == "cloud1" {
                isPlaceRectangle = true
                temp = "cloud1"
            }
            
            let oneAnimation: SKAction
            // 1
            var textures:[SKTexture] = []
            // 2
            textures.append(SKTexture(imageNamed: "wind_blower2"))
            textures.append(SKTexture(imageNamed: "wind_blower3"))
            textures.append(SKTexture(imageNamed: "wind_blower4"))
            textures.append(SKTexture(imageNamed: "wind_blower5"))
            
            oneAnimation = SKAction.animateWithTextures(textures,timePerFrame: 0.1)
           // sharpRock.runAction(SKAction.repeatActionForever(oneAnimation))
            
            let oneAnimation_r: SKAction
            // 1
            var textures_r:[SKTexture] = []
            // 2
            textures_r.append(SKTexture(imageNamed: "r_wind_blower2"))
            textures_r.append(SKTexture(imageNamed: "r_wind_blower3"))
            textures_r.append(SKTexture(imageNamed: "r_wind_blower4"))
            textures_r.append(SKTexture(imageNamed: "r_wind_blower5"))
            
            oneAnimation_r = SKAction.animateWithTextures(textures_r,timePerFrame: 0.1)
            
            if body.node?.name == "wind_1" {
                
                wind_1.runAction(oneAnimation)
                self.blowerAction(self.wind_1, blowVector: CGVectorMake(0, 10))
            }
            if body.node?.name == "wind_2" {
                wind_2.runAction(oneAnimation_r)
                self.blowerAction(self.wind_2, blowVector: CGVectorMake(5, 2))
            }
            
            if body.node?.name == "wind_3" {
                wind_3.runAction(oneAnimation_r)
                self.blowerAction(self.wind_3, blowVector: CGVectorMake(10, 0))
            }
            
            
            if body.node!.name == "ball_in_bubble" {
                
                var currentLocation = self.ball.position

                self.ball.removeFromParent()
                self.ball = self.assetViewController.initBall(currentLocation, size: CGSizeMake(30, 40))
                self.addChild(self.ball)
                self.ball.physicsBody?.dynamic = true
                print("bubble touched")

            }
            
            
//            if body.node!.name == "startend" {
//                print("start")
//                let ball = childNodeWithName("ball") as! SKSpriteNode
//                
//                ball.physicsBody?.dynamic = true;
//                ball.physicsBody?.applyImpulse(CGVectorMake(3, 3))
//                //stop the function of startend!!!!!!!!!
//                
//            }
            
        }
        
        self.checkPartsNumber()
        
    }
    
    func blowerAction(blower: SKSpriteNode, blowVector: CGVector){
        
        if self.distance(blower.position, second: self.ball.position) < 100.0 {
            ball.physicsBody?.applyImpulse(blowVector)
        }
        
    }
    func distance(first: CGPoint, second: CGPoint) -> CGFloat {
        let dx = first.x - second.x
        let dy = first.y - second.y
        return sqrt(dx * dx + dy * dy)
    }
    func moveEGGUp(blower: SKSpriteNode){
        
        if(self.ball.position.y<blower.position.y+30 && ball.position.y>blower.position.y-30 && ball.position.x>blower.position.x-150 && ball.position.x<blower.position.x){
            
            ball.physicsBody?.applyImpulse(CGVectorMake(1, 2))
            
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if isPlaceRectangle || isPlaceStick {
            let touch =  (touches as NSSet).anyObject() as! UITouch!
            let location = touch.locationInNode(self)
            
            let prevLocation = touch.previousLocationInNode(self)
            
            
            let rectangle0 = childNodeWithName(temp) as! SKSpriteNode
            
            let xPos = rectangle0.position.x + (location.x - prevLocation.x)
            
            let yPos = rectangle0.position.y + (location.y - prevLocation.y)
            
            rectangle0.position = CGPointMake(xPos, yPos)
            
            if temp == "rot0" {
                self.stick0.position = self.stickRotate0.position
                self.stickRotate0.position = self.stick0.position
            }else if temp == "rot1" {
                self.stick1.position = self.stickRotate1.position
                self.stickRotate1.position = self.stick1.position
            }
            
            if temp == "stick0" {
                self.stickRotate0.position = self.stick0.position
            } else if temp == "stick1" {
                self.stickRotate1.position = self.stick1.position
            }
        
            
        }
        
        self.checkPartsNumber()
        
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        if temp == "rect1" || temp == "rect0" {
            let rectangle0 = childNodeWithName(temp) as! SKSpriteNode
            
            let longLine = childNodeWithName("framework") as! SKSpriteNode
            if rectangle0.position.y < longLine.position.y+20{
                rectangle0.position = CGPointMake(60, 35)
            }
        }
        
        if temp == "stick0" || temp == "stick1" {
            let stick = childNodeWithName(temp) as! SKSpriteNode
            let longLine = childNodeWithName("framework") as! SKSpriteNode
            
            if temp == "stick0" {
                self.stickRotate0.position = self.stick0.position
            } else {
                self.stickRotate1.position = self.stick1.position
            }
            
            if stick.position.y < longLine.position.y + 20 {
                stick.position = CGPointMake(140, 35)
                
                if stick.name == "stick0" {
                    self.stickRotate0.position = CGPointMake(100, -500)
                }else if stick.name == "stick1" {
                    self.stickRotate1.position = CGPointMake(100, -500)
                }
            }
            
        }
        
        if temp == "rot0" || temp == "rot1" {
            let currentNode = childNodeWithName(temp) as! SKSpriteNode
            let longLine = childNodeWithName("framework") as! SKSpriteNode
            if currentNode.position.y < longLine.position.y + 20 {
                currentNode.position = CGPointMake(100, -500)
                if temp == "rot0" {
                    self.stick0.position = CGPointMake(140, 35)
                }else {
                    self.stick1.position = CGPointMake(140, 35)
                }
            }
        }
        
        if temp == "dou0" || temp == "dou1" {
            let currentNode = childNodeWithName(temp) as! SKSpriteNode
            let longLine = childNodeWithName("framework") as! SKSpriteNode
            if currentNode.position.y < longLine.position.y + 20 {
                currentNode.position = CGPointMake(230, 35)
            }
        
        }
        
        if temp == "cloud0" || temp == "cloud1" {
            let currentNode = childNodeWithName(temp) as! SKSpriteNode
            let longLine = childNodeWithName("framework") as! SKSpriteNode
            if currentNode.position.y < longLine.position.y + 20 {
                currentNode.position = CGPointMake(310, 35)
            }
        }
        
        temp  = "label";
        isPlaceRectangle = false
        isPlaceStick = false
        //if rect under the line set it to default place
        
        self.checkPartsNumber()
    }
    
    func checkPartsNumber(){
        //check the position of parts and set the number label
        
        if self.rect0.position.y < 70 && self.rect1.position.y < 70 {
            self.rectNum.tag = 2
        }else if self.rect0.position.y > 70 && self.rect1.position.y > 70 {
            self.rectNum.tag = 0
        }else{
            self.rectNum.tag = 1
        }
        self.rectNum.text = String(self.rectNum.tag)
        
        if self.stick0.position.y < 70 && self.stick1.position.y < 70 {
            self.stickNum.tag = 2
        }else if self.stick0.position.y > 70 && self.stick1.position.y > 70 {
            self.stickNum.tag = 0
        }else{
            self.stickNum.tag = 1
        }
        self.stickNum.text = String(self.stickNum.tag)
        
        if self.doubleTri0.position.y < 70 && self.doubleTri1.position.y < 70 {
            self.doubleTriNum.tag = 2
        }else if self.doubleTri0.position.y > 70 && self.doubleTri1.position.y > 70 {
            self.doubleTriNum.tag = 0
        }else{
            self.doubleTriNum.tag = 1
        }
        self.doubleTriNum.text = String(self.doubleTriNum.tag)
        
        if self.cloud0.position.y < 70 && self.cloud1.position.y < 70 {
            self.cloudNum.tag = 2
        }else if self.cloud0.position.y > 70 && self.cloud1.position.y > 70 {
            self.cloudNum.tag = 0
        }else{
            self.cloudNum.tag = 1
        }
        self.cloudNum.text = String(self.cloudNum.tag)
        
        

    }
    
    
    func didBeginContact(contact: SKPhysicsContact) {
        var firstBody:SKPhysicsBody
        var secondBody:SKPhysicsBody
        
        if(contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
            
        }else{
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if(firstBody.categoryBitMask == basketCategory && secondBody.categoryBitMask == ballCategory){
            basketDidCollideWithBall(firstBody.node as! SKSpriteNode, ball: secondBody.node as! SKSpriteNode)
        }
        
        if(firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == basketCategory){
            basketDidCollideWithBall(firstBody.node as! SKSpriteNode, ball: secondBody.node as! SKSpriteNode)
        }
        
//        if((firstBody.contactTestBitMask & sharpRockCategory) != 0 && (secondBody.contactTestBitMask & ballCategory) != 0){
//            //sharpRockDidCollideWithBall()
//            self.gameEnd(false)
//        }
        
        if firstBody.categoryBitMask == sharpRockCategory && secondBody.categoryBitMask == ballCategory {
            self.gameEnd(false)
        }
        if firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == sharpRockCategory {
            self.gameEnd(false)
        }
        
//        if firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == bubbleCategory {
//            let joint:SKPhysicsJointFixed = SKPhysicsJointFixed.jointWithBodyA(contact.bodyA, bodyB: contact.bodyB, anchor:contact.contactPoint)
//            self.physicsWorld.addJoint(joint)
//            print("bubble collision")
//            bubbleDidCollideWithBall(firstBody.node as! SKSpriteNode, bubble: secondBody.node as! SKSpriteNode)
//        }
        
    
        if firstBody.categoryBitMask == ballCategory && secondBody.categoryBitMask == toolKitCategory {
            print("collide with tools-----------")
            print("ball speed:")
            print(self.ball.physicsBody?.velocity)
            
           // var velocityX = self.ball.physicsBody?.velocity.dx
            var velocityY = self.ball.physicsBody?.velocity.dy
            
            var currentVelocity = velocityY! * velocityY!
            
            
            print("second body name")
            print(secondBody.node?.name)
                
            if currentVelocity >= CGFloat(EggCrackVelocityLevelOne * EggCrackVelocityLevelOne) && currentVelocity < CGFloat(EggCrackVelocityLevelTwo * EggCrackVelocityLevelTwo) && currentVelocity != self.lastCrackVelocity && secondBody.node?.name != self.lastCollideObject {
                self.HP--
                if self.HP == 2 || self.HP == 1{
                    self.ball.texture = SKTexture(imageNamed: "cracking_egg")
                }
                
                if self.HP <= 0 {
                    self.gameEnd(false)
                }
            }
            
            if currentVelocity >= CGFloat(EggCrackVelocityLevelTwo * EggCrackVelocityLevelTwo) && currentVelocity != self.lastCrackVelocity && secondBody.node?.name != self.lastCollideObject {
                self.HP = self.HP - 2
                if self.HP == 2 || self.HP == 1{
                    self.ball.texture = SKTexture(imageNamed: "cracking_egg")
                }
                
                if self.HP <= 0 {
                    self.gameEnd(false)
                }
            }

            
            
            self.lastCrackVelocity = currentVelocity
            self.lastCollideObject = secondBody.node?.name
        }
        
        
    
    }
    
    func basketDidCollideWithBall(basket:SKSpriteNode,ball:SKSpriteNode){
        print("HIT")
        
        var myInt1 =  1
        if(rect0.position.y>=framework.position.y){
            myInt1++
        }
        if(rect1.position.y>=framework.position.y){
            myInt1++
        }
        if(doubleTri0.position.y>=framework.position.y){
            myInt1++
        }
        if(doubleTri1.position.y>=framework.position.y){
            myInt1++
        }
        if(stick0.position.y>=framework.position.y){
            myInt1++
        }
        if(stick1.position.y>=framework.position.y){
            myInt1++
        }
        
        let anotherInt1 = NSUserDefaults.standardUserDefaults().integerForKey("myInt1")
        if(myInt1<anotherInt1 || anotherInt1 == 0){
            NSUserDefaults.standardUserDefaults().setInteger(myInt1, forKey: "myInt1")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        
           //    self.scoreLabel.text = self.assetViewController.scoreSystem(myInt1)

        //self.currentScoreLabel.text = "Your Score: " + self.assetViewController.scoreSystem(myInt1)
        
        
     //   self.scoreLabel.text = "Highest Score: " + self.assetViewController.scoreSystem(NSUserDefaults.standardUserDefaults().integerForKey("myInt1"))
        //failed
        self.gameEnd(true)
        
    }
    
    func sharpRockDidCollideWithBall(){
        print("HIT rock")
        
        
        //transition to gameover or success
        self.gameEnd(false)
        
//        var transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
//        var YouWinScene:SKScene = youWinScene(size: self.frame.size, won:false)
//        self.view?.presentScene(YouWinScene, transition: transition)
//        self.transitToNextScene()
        
    }
    
    func bubbleDidCollideWithBall() {
        print("bubble collide with ball")
        
        self.bubble.hidden = true
        self.bubble.removeFromParent()
        self.bubble = nil
        self.ball.texture = SKTexture.init(imageNamed: "bubble_with_ball")
        self.ball.name = "ball_in_bubble"
        self.ball.size.width = 50
        self.ball.size.height = 50
        
    
    
        let ballVelocity = self.screenHeight / 60;
        let location:CGPoint = CGPointMake(self.ball.position.x, self.screenHeight);
        
        let moveAction:SKAction = SKAction.moveTo(location, duration: NSTimeInterval.init(ballVelocity));
        self.ball.runAction(moveAction, withKey: "float")
        
    }
    
//    func bubbleAction(bubble: SKSpriteNode){
//        print("bubble collide with ball")
//        self.physicsWorld.gravity=CGVectorMake(0,-5);
//    }
    
    func initMenu(){
        self.menuView = UIView(frame: CGRectMake(self.screenWidth / 2 - 100, -self.screenHeight / 2 - 150, 200, 250))
        self.menuView.backgroundColor = UIColor(red: 6 / 255, green: 82 / 255, blue: 121 / 255, alpha: 1.0)
        self.menuView.layer.cornerRadius = 15
        
        self.syncProgress = UIButton(frame: CGRectMake(self.menuView.frame.width / 2 - 60, 50, 120, 40))
        self.syncProgress.backgroundColor = UIColor(red: 238 / 255, green: 222 / 255, blue: 176 / 255, alpha: 1.0)
        self.syncProgress.setTitle("Sync Progress", forState: UIControlState.Normal)
        self.syncProgress.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.syncProgress.layer.cornerRadius = 20
        self.menuView.addSubview(self.syncProgress)
        
        self.resetAssetsButton = UIButton(frame: CGRectMake(self.menuView.frame.width / 2 - 60, 110, 120, 40))
        self.resetAssetsButton.backgroundColor = UIColor(red: 237 / 255, green: 209 / 255, blue: 216 / 255, alpha: 1.0)
        self.resetAssetsButton.setTitle("Restart", forState: UIControlState.Normal)
        self.resetAssetsButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.resetAssetsButton.layer.cornerRadius = 20
        self.resetAssetsButton.addTarget(self, action: "resetGame:", forControlEvents: UIControlEvents.TouchUpInside)
        self.menuView.addSubview(self.resetAssetsButton)
        
        
        self.returnGameSelectionButton = UIButton(frame: CGRectMake(self.menuView.frame.width / 2 - 60, 170, 120, 40))
        self.returnGameSelectionButton.backgroundColor = UIColor(red: 233 / 255, green: 241 / 255, blue: 246 / 255, alpha: 1.0)
        self.returnGameSelectionButton.setTitle("Exit to Map", forState: UIControlState.Normal)
        self.returnGameSelectionButton.titleLabel?.font = UIFont.systemFontOfSize(16)
        self.returnGameSelectionButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        self.returnGameSelectionButton.layer.cornerRadius = 20
        self.returnGameSelectionButton.addTarget(self, action: "returnGameSelection:", forControlEvents: UIControlEvents.TouchUpInside)
        self.menuView.addSubview(self.returnGameSelectionButton)
        
        
        self.transparentButton = UIButton(frame: CGRectMake(0, 0, self.screenWidth, self.screenHeight))
        self.transparentButton.backgroundColor = UIColor.clearColor()
        self.transparentButton.addTarget(self, action: "dismissMenuView:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        self.blurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.Light))
        self.blurView.frame = self.view!.frame
        self.view?.addSubview(self.blurView)
        self.blurView.addSubview(self.transparentButton)
        self.blurView.addSubview(self.menuView)
        self.blurView.hidden = true
        
        //end of game
        self.endBlurView = UIVisualEffectView(effect: UIBlurEffect(style: UIBlurEffectStyle.ExtraLight))
        self.endBlurView.frame = self.view!.frame
        self.view?.addSubview(self.endBlurView)
        self.endBlurView.hidden = true
        
        self.mainLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 100, self.screenHeight / 2 - 100, 200, 150))
        self.mainLabel.textAlignment = .Center
        self.mainLabel.font = UIFont(name: "DamascusBold", size: 18)
        self.endBlurView.addSubview(self.mainLabel)
        
        self.nextLevel = UIButton(frame: CGRectMake(self.screenWidth / 2 - 80, self.screenHeight / 2 + 50, 50, 50))
        self.nextLevel.setBackgroundImage(UIImage(named:"start2"),forState:.Normal)
        self.nextLevel.addTarget(self,action:"nextLevel:",forControlEvents:UIControlEvents.TouchUpInside)
        self.endBlurView.addSubview(self.nextLevel)
        self.nextLevel.hidden = true
        
        self.playAgain = UIButton(frame: CGRectMake(self.screenWidth / 2 - 80, self.screenHeight / 2 + 50, 50, 50))
        self.playAgain.setBackgroundImage(UIImage(named:"replay_button"),forState:.Normal)
        self.playAgain.addTarget(self, action: "goBackGame:", forControlEvents: UIControlEvents.TouchUpInside)
        self.endBlurView.addSubview(self.playAgain)
        self.playAgain.hidden = true
        
        self.goToLevelSelection = UIButton(frame: CGRectMake(screenWidth / 2 + 30, self.screenHeight / 2 + 50, 50, 50))
        //self.goToLevelSelection.setTitleColor(UIColor.whiteColor(),forState: .Normal)
        self.goToLevelSelection.setBackgroundImage(UIImage(named:"menu2"),forState:.Normal)
        self.goToLevelSelection.addTarget(self, action: "transitionToLevelSelection:", forControlEvents: UIControlEvents.TouchUpInside)
        self.endBlurView.addSubview(self.goToLevelSelection)
        
        // show score
        
      //  self.scoreLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 60, 150, 200, 50))
     //   self.scoreLabel.textColor = UIColor.blackColor()
        
       
        
        
        
    //    self.endBlurView.addSubview(self.scoreLabel)
        
        self.starScoreImageView = UIImageView(frame: CGRectMake(self.screenWidth / 2 - 75, self.screenHeight / 2 - 100, 150, 50))
        starImage1 = UIImageView(frame: CGRectMake(0, 0, 50, 50))
        starImage2 = UIImageView(frame: CGRectMake(50, 0, 50, 50))
        starImage3 = UIImageView(frame: CGRectMake(100, 0, 50, 50))

        self.starScoreImageView.addSubview(starImage1)
        self.starScoreImageView.addSubview(starImage2)
        self.starScoreImageView.addSubview(starImage3)
        self.starScoreImageView.backgroundColor = UIColor.clearColor()
        self.endBlurView.addSubview(self.starScoreImageView)

        
    }
    
    func freezeGame(){

        self.playButton.hidden = true
        self.menuButton.hidden = true
        self.transparentButton_chicken.hidden = true
        self.bloodLabel.hidden = true
        
        //hide parts number label
        self.rectBack.hidden = true
        self.rectNum.hidden = true
        self.stickBack.hidden = true
        self.stickNum.hidden = true
        self.doubleTriBack.hidden = true
        self.doubleTriNum.hidden = true
        self.cloudBack.hidden = true
        self.cloudNum.hidden = true
        
        self.blurView.hidden = false
        self.blurView.alpha = 1.0
        
    }
    
    func resumeGame(){

        //restart button action in sidebar menu
        print("resume game")
        self.ball.zPosition = CGFloat(M_PI) * 2
        
        self.playButton.hidden = false
        self.menuButton.hidden = false
        self.transparentButton.hidden = true
        self.transparentButton_chicken.hidden = false
        
        self.HP = 3
        self.bloodLabel.hidden = false
        
        self.rectBack.hidden = false
        self.rectNum.hidden = false
        self.stickBack.hidden = false
        self.stickNum.hidden = false
        self.doubleTriBack.hidden = false
        self.doubleTriNum.hidden = false
        self.cloudBack.hidden = false
        self.cloudNum.hidden = false
        
    }
    
    
    
    //for button targets
    func goToMenu(sender: UIButton){
        
        self.freezeGame()
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.8, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.menuView.frame.origin.y = self.screenHeight / 2 - 150
            }, completion: {
                finished in
                self.transparentButton.hidden = false
        
        })

        
    }
    
    func goBackGame(sender: UIButton){
        
    
    
        //restart button after game fails
        print("here")
        self.ball.zPosition = CGFloat(M_PI) / 4
        
        self.playButton.hidden = false
        self.menuButton.hidden = false
        self.transparentButton_chicken.hidden = false
        
        self.endBlurView.hidden = true
        
        self.resumeGame()
        self.ball.position = self.initialEggPosition
        self.ball.physicsBody?.dynamic = false
        self.ball.texture = SKTexture(imageNamed: "egg")
        self.keepUpdate = true
        
        
        if self.initialBubblePosition != nil {
            self.bubble = self.assetViewController.initBubble("bubble", position: self.initialBubblePosition)
            self.addChild(self.bubble)
        }
        
        self.rect0.name = "rect0"
        self.rect1.name = "rect1"
        self.stick0.name = "stick0"
        self.stick1.name = "stick1"
        self.doubleTri0.name = "dou0"
        self.doubleTri1.name = "dou1"
        self.stickRotate0.name = "rot0"
        self.stickRotate1.name = "rot1"
        self.stickRotate0.hidden = false
        self.stickRotate1.hidden = false
        self.stickRotate0.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        self.stickRotate0.physicsBody?.dynamic = false
        self.stickRotate1.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        self.stickRotate1.physicsBody?.dynamic = false
        
        self.cloud0.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(70, 50))
        self.cloud1.physicsBody = SKPhysicsBody(rectangleOfSize: CGSizeMake(70, 50))
        self.cloud0.physicsBody?.dynamic = false
        self.cloud1.physicsBody?.dynamic = false
        
        
        self.star_1.removeAllActions()
        self.star_2.removeAllActions()
        self.star_3.removeAllActions()
        self.star_1.texture = SKTexture(imageNamed: "star_2")
        self.star_2.texture = SKTexture(imageNamed: "star_2")
        self.star_3.texture = SKTexture(imageNamed: "star_2")
        self.addChild(self.star_1)
        self.addChild(self.star_2)
        self.addChild(self.star_3)
        self.star1Removed = false
        self.star2Removed = false
        self.star3Removed = false
        
        self.lastCollideObject = ""
        self.lastCrackVelocity = 0
    
    }
    

    
    func dismissMenuView(sender: UIButton){
        
        
        
        UIView.animateWithDuration(0.8, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.menuView.frame.origin.y = -self.screenHeight / 2 - 150
            }, completion: nil)
        
        
        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.blurView.alpha = 0.1
            }, completion: {
                finished in
                self.blurView.hidden = true
                    self.resumeGame()
        })
        
        
        
    }
    
    func returnGameSelection(sender: UIButton){
        
        //self.dismissMenuView(self.transparentButton)
        
        
        UIView.animateWithDuration(0.8, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.menuView.frame.origin.y = -self.screenHeight / 2 - 150
            }, completion: nil )
        
        
        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.blurView.alpha = 0.1
            }, completion: {
                finished in
                self.blurView.hidden = true
        })

        //hide parts number label
        self.rectBack.hidden = true
        self.rectNum.hidden = true
        self.stickBack.hidden = true
        self.stickNum.hidden = true
        self.doubleTriBack.hidden = true
        self.doubleTriNum.hidden = true
        
        let sceneTransition = SKTransition.crossFadeWithDuration(0.5)
        let gameSectionScene:SKScene = GameSelectionScene()
        self.view?.presentScene(gameSectionScene, transition: sceneTransition)
        
        
    }
    
    func resetGame(sender: UIButton){
        
        self.dismissMenuView(sender)
        self.rect0.position = CGPointMake(60, 35)
        self.rect1.position = CGPointMake(60, 35)
        self.stick0.position = CGPointMake(140, 35)
        self.stick1.position = CGPointMake(140, 35)
        self.stickRotate0.position = CGPointMake(100, -500)
        self.stickRotate1.position = CGPointMake(100, -500)
        self.doubleTri0.position = CGPointMake(230, 35)
        self.doubleTri1.position =  CGPointMake(230, 35)
        
        self.HP = 3
        
        self.checkPartsNumber()
        
    }
    
    func transitToNextScene(){
        self.menuButton.hidden = true
        self.playButton.hidden = true
        self.transparentButton_chicken.hidden = true
        print("hahah")
    }
    
    //end of game
    func gameEnd(didWin:Bool){
        //self.transitToNextScene()
        self.playButton.hidden = true
        self.menuButton.hidden = true
        self.transparentButton_chicken.hidden = true
        self.bloodLabel.hidden = true
        
        //hide parts number label
        self.rectBack.hidden = true
        self.rectNum.hidden = true
        self.stickBack.hidden = true
        self.stickNum.hidden = true
        self.doubleTriBack.hidden = true
        self.doubleTriNum.hidden = true
        self.cloudNum.hidden = true
        self.cloudBack.hidden = true
        
        self.ball.physicsBody?.dynamic = false
        
        self.star_1.removeFromParent()
        self.star_2.removeFromParent()
        self.star_3.removeFromParent()
        
        if didWin {
            
            let anotherInt1 = NSUserDefaults.standardUserDefaults().integerForKey(String(currentLevel))
            if(starCollideCount>anotherInt1){
                NSUserDefaults.standardUserDefaults().setInteger(starCollideCount, forKey: String(currentLevel))
                NSUserDefaults.standardUserDefaults().synchronize()
                
            }
            print(NSUserDefaults.standardUserDefaults().integerForKey(String(currentLevel)))
          //  self.scoreLabel.text = "Highest Score: " + self.assetViewController.scoreSystem(NSUserDefaults.standardUserDefaults().integerForKey("myInt1"))
            
            var empty_star = UIImage(named:"star_empty")
            var filled_star = UIImage(named: "star_filled")
            self.starScoreImageView.hidden = false
            switch self.starCollideCount {
                case 0:
                    self.starImage1.image = empty_star
                    self.starImage2.image = empty_star
                    self.starImage3.image = empty_star
                    break
                case 1:
                    self.starImage1.image = filled_star
                    self.starImage2.image = empty_star
                    self.starImage3.image = empty_star
                    break
                case 2:
                    self.starImage1.image = filled_star
                    self.starImage2.image = filled_star
                    self.starImage3.image = empty_star
                    break
                case 3:
                    self.starImage1.image = filled_star
                    self.starImage2.image = filled_star
                    self.starImage3.image = filled_star
                    break
                default:
                    break
            }
            
            
            mainLabel.text = "You Win!"
            self.nextLevel.hidden = false
            self.playAgain.hidden = true
        }else {
            
            self.starCollideCount = 0
            self.starScoreImageView.hidden = true
            
         //   self.scoreLabel.text = "Highest Score: " + self.assetViewController.scoreSystem(NSUserDefaults.standardUserDefaults().integerForKey("myInt1"))
            mainLabel.text = "You Lose!"
            self.playAgain.hidden = false
            self.nextLevel.hidden = true
        }
        self.keepUpdate = false
        self.endBlurView.hidden = false
        
    }
    
    func nextLevel(sender: UIButton){
        
        UIView.animateWithDuration(0.3, delay: 0.3, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.endBlurView.alpha = 0.1
            }, completion: {
                finished in
                self.endBlurView.hidden = true
        })
        
        
        let sceneTransition = SKTransition.crossFadeWithDuration(0.3)
        var scene:SKScene!
        print(self.currentLevel)
        switch self.currentLevel {
        case 1:
            scene = Level_Two(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        case 2:
            scene = Level_Three(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        case 3:
            scene = Level_Four(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        case 4:
            scene = Level_Five(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        case 5:
            scene = Level_One(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        default:
            break
        }
    
        self.view?.presentScene(scene, transition: sceneTransition)
        
    }
    
    func transitionToLevelSelection(sender: UIButton){
        
        UIView.animateWithDuration(0.3, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.endBlurView.alpha = 0.1
            }, completion: {
                finished in
                self.endBlurView.hidden = true

        })
        UIView.animateWithDuration(0.0, delay: 0.4, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            
            let sceneTransition = SKTransition.crossFadeWithDuration(0.3)
            let scene = GameSelectionScene(size:CGSizeMake(self.screenWidth, self.screenHeight))
            self.view?.presentScene(scene, transition: sceneTransition)
            
        }, completion: nil)
        
    }
    
}
