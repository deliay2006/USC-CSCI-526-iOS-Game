//
//  GameScene.swift
//  inEggGame2
//
//  Created by Yuxiang Tang on 10/2/15.
//  Copyright (c) 2015 陈天远. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    var keepUpdate = true
    
    var lastYieldTimeInterval:NSTimeInterval=NSTimeInterval()
    var lastUpdateTimeInterval:NSTimeInterval=NSTimeInterval()
    var timeSinceLastUpdate:NSTimeInterval=NSTimeInterval()
    var example:SKSpriteNode=SKSpriteNode()//just for compare
    let ballCategory:UInt32=0x1 << 1
    let basketCategory:UInt32=0x1 << 5
    let rectCategory:UInt32=0x1 << 2
    let frameCategory:UInt32=0x1 << 3//for frame
    let sharpRockCategory:UInt32 = 0x1 << 4
    
    var ball:SKSpriteNode!
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
    var framework:SKSpriteNode!
    var redArrow:SKSpriteNode!
    
    var basketAction = [SKAction]()
   // var sharpRock:SKSpriteNode!//sharp rock
   // var trampoline:SKSpriteNode!
    
    var isPlaceRectangle = false
    var isPlaceStick = false
    var temp:String = "label"
    var menuButton:UIButton = UIButton(type: UIButtonType.System);
    var playButton:UIButton = UIButton(type: UIButtonType.System);
    
    var menuView: UIView!
    var syncProgress: UIButton!
    var resetAssetsButton: UIButton!
    var returnGameSelectionButton: UIButton!
    var transparentButton: UIButton!
    var blurView: UIVisualEffectView!
    var endBlurView: UIVisualEffectView!
    
    //end of game
    var mainLabel: UILabel!
    var nextLevel:UIButton!
    var playAgain:UIButton!
    var goToLevelSelection: UIButton!
    var scoreLabel: UILabel!
    var currentScoreLabel: UILabel!
    
    var assetViewController: AssetViewController!
    
    override init(size: CGSize){
        super.init(size: size)
    }
    required init?(coder aDecoder:NSCoder){
        super.init(coder:aDecoder)
    }
    
    
    override func didMoveToView(view: SKView) {
        
        CURRENTLEVEL = 1
        
        self.initMenu()
        self.assetViewController = AssetViewController()
        
        /* Setup your scene here */
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
        
        /*------basic parts------*/
        self.hen = self.assetViewController.initHen(CGPointMake(30, self.screenHeight - 150),size: CGSizeMake(80, 80))
        self.addChild(hen)
        
        self.ball = self.assetViewController.initBall(CGPointMake(70, screenHeight - 130),size: CGSizeMake(30, 30))
        self.addChild(ball)
        
        self.basket = self.assetViewController.initBasket(CGPointMake(screenWidth - 80, 140),size: CGSizeMake(80, 80), actionArray: self.basketAction)
        self.addChild(self.basket)
        
        self.framework = self.assetViewController.initFramework()
        self.addChild(self.framework)
        
        self.redArrow = self.assetViewController.initArrow(CGPointMake(100, self.screenHeight - 200),size: CGSizeMake(50, 50))
        redArrow.zRotation = CGFloat(M_PI) / 2
        
        let moveUP = SKAction.moveTo(CGPointMake(100, self.screenHeight - 250), duration: 0.8)
        let moveDOWN = SKAction.moveTo(CGPointMake(100, self.screenHeight - 200), duration: 0)
       
        let sequence = SKAction.sequence([moveUP, moveDOWN])
        let repeats = SKAction.repeatActionForever(sequence)
        
        redArrow.runAction(repeats)
        self.addChild(redArrow)
        
        /*------------------------*/
        
        
        /*-------obstacles-------*/
//        self.sharpRock = self.assetViewController.initSharpRock("rock",position: CGPointMake(200, 200))
//        self.addChild(sharpRock)
//        
//        self.trampoline = self.assetViewController.initTrampoline("tram",position: CGPointMake(100, 100))
//        self.addChild(trampoline)
        
        /*------------------------*/
        
        /*------movable parts------*/
        // 2 triagnle
        self.rect0 = self.assetViewController.initTriangle("rect0", position: CGPointMake(60, 35))
        self.addChild(rect0)
        
        self.rect1 = self.assetViewController.initTriangle("rect1", position: CGPointMake(60, 35))
        self.addChild(rect1)
        
        //2 stick rotate signs
        self.stickRotate0 = self.assetViewController.initStickRotation("rot0")
        self.stickRotate1 = self.assetViewController.initStickRotation("rot1")
        //self.stickRotate0.position = CGPointMake(100, 100)
        self.addChild(self.stickRotate0)
        self.addChild(self.stickRotate1)
        
        
        // 2 stick
        self.stick0 = self.assetViewController.initStick("stick0", position: CGPointMake(120, 35))
        self.addChild(self.stick0)
        
        self.stick1 = self.assetViewController.initStick("stick1", position: CGPointMake(120, 35))
        self.addChild(self.stick1)
        
        // 2 double triangle
        self.doubleTri0 = self.assetViewController.initDoubleTriangle("dou0", position: CGPointMake(200, 35))
        self.addChild(self.doubleTri0)
        self.doubleTri1 = self.assetViewController.initDoubleTriangle("dou1", position: CGPointMake(200, 35))
        self.addChild(self.doubleTri1)
        
        /*--------------------------*/
        
        self.physicsWorld.contactDelegate = self
        
        let rotationGesture = UIRotationGestureRecognizer(target: self, action: "rotateStick:")
        self.view?.addGestureRecognizer(rotationGesture)
        
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
        
        rect0.name = "rect0static"
        rect1.name = "rect1static"
        self.stick0.name = "stick0static"
        self.stick1.name = "stick0static"
        self.doubleTri0.name = "double0static"
        self.doubleTri1.name = "double1static"
        
        //playButton.removeTarget(self, action: Selector("tapped"), forControlEvents: UIControlEvents.TouchUpInside)
        self.playButton.hidden = true
        self.menuButton.hidden = true
        
        self.redArrow.hidden = true
        
        self.stickRotate0.hidden = true
        self.stickRotate1.hidden = true
        self.stickRotate0.physicsBody = nil
        self.stickRotate1.physicsBody = nil
    }
    
    func tapped2(){
        print("tapped2")
        
        
        //maybe for stop the ball
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        timeSinceLastUpdate = currentTime - lastUpdateTimeInterval
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
            
            if body.node!.name == "startend" {
                print("start")
                let ball = childNodeWithName("ball") as! SKSpriteNode
                
                ball.physicsBody?.dynamic = true;
                ball.physicsBody?.applyImpulse(CGVectorMake(3, 3))
                //stop the function of startend!!!!!!!!!
                
            }
            
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
                stick.position = CGPointMake(120, 35)
                
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
                    self.stick0.position = CGPointMake(120, 35)
                }else {
                    self.stick1.position = CGPointMake(120, 35)
                }
            }
        }
        
        if temp == "dou0" || temp == "dou1" {
            let currentNode = childNodeWithName(temp) as! SKSpriteNode
            let longLine = childNodeWithName("framework") as! SKSpriteNode
            if currentNode.position.y < longLine.position.y + 20 {
                currentNode.position = CGPointMake(200, 35)
            }
        
        }
        
        temp  = "label";
        isPlaceRectangle = false
        isPlaceStick = false
        //if rect under the line set it to default place
        
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
        
        if((firstBody.contactTestBitMask & basketCategory) != 0 && (secondBody.contactTestBitMask & ballCategory) != 0){
            basketDidCollideWithBall(firstBody.node as! SKSpriteNode, ball: secondBody.node as! SKSpriteNode)
        }
        
    }
    
    func basketDidCollideWithBall(basket:SKSpriteNode,ball:SKSpriteNode){
        print("HIT")
        
        var myInt1 =  1;
        if(rect0.position.y>=framework.position.y){
            myInt1++;
        }
        if(rect1.position.y>=framework.position.y){
            myInt1++;
        }
        if(doubleTri0.position.y>=framework.position.y){
            myInt1++;
        }
        if(doubleTri1.position.y>=framework.position.y){
            myInt1++;
        }
        if(stick0.position.y>=framework.position.y){
            myInt1++;
        }
        if(stick1.position.y>=framework.position.y){
            myInt1++;
        }
        
        let anotherInt1 = NSUserDefaults.standardUserDefaults().integerForKey("myInt1")
        if(myInt1<anotherInt1 || anotherInt1 == 0){
            NSUserDefaults.standardUserDefaults().setInteger(myInt1, forKey: "myInt1")
            NSUserDefaults.standardUserDefaults().synchronize()
            
        }
        
           //    self.scoreLabel.text = self.assetViewController.scoreSystem(myInt1)

        self.currentScoreLabel.text = "Your Score: " + self.assetViewController.scoreSystem(myInt1)
        
        
     //   self.scoreLabel.text = "Highest Score: " + self.assetViewController.scoreSystem(NSUserDefaults.standardUserDefaults().integerForKey("myInt1"))
        //failed
        self.gameEnd(true)
        
    }
    
//    func sharpRockDidCollideWithBall(basket:SKSpriteNode,ball:SKSpriteNode){
//        println("HIT rock")
//        
//        
//        //transition to gameover or success
//        var transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
//        var YouWinScene:SKScene = youWinScene(size: self.frame.size, won:false)
//        self.view?.presentScene(YouWinScene, transition: transition)
//        self.transitToNextScene()
//        
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
        
        self.scoreLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 60, 150, 200, 50))
        self.scoreLabel.textColor = UIColor.blackColor()
        
       
        
        
        
        self.endBlurView.addSubview(self.scoreLabel)
        
        self.currentScoreLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 50, 200, 200, 50))
        self.currentScoreLabel.textColor = UIColor.blackColor()
        self.endBlurView.addSubview(self.currentScoreLabel)
        
        
        
        

//        let score:SKLabelNode = SKLabelNode(fontNamed: "DamascusBold")
//        score.text = scoreInt1 as String
//        score.color = SKColor.blackColor()
//        score.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
//        print(self.frame.size.width)
//        print(self.frame.size.height)
//        self.addChild(score)

        
        
        
    }
    
    func freezeGame(){
//        self.rect0.hidden = true
//        self.rect1.hidden = true
        self.playButton.hidden = true
        self.menuButton.hidden = true
        //self.transparentButton.hidden = false
        self.blurView.hidden = false
        self.blurView.alpha = 1.0
        
    }
    
    func resumeGame(){
//        self.rect0.hidden = false
//        self.rect1.hidden = false
        self.playButton.hidden = false
        self.menuButton.hidden = false
        self.transparentButton.hidden = true
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
        print("go back game")
        
        self.playButton.hidden = false
        self.menuButton.hidden = false
        
        self.endBlurView.hidden = true
        
        self.resumeGame()
        self.ball.position = CGPointMake(70, self.screenHeight - 130)
        self.ball.physicsBody?.dynamic = false
        self.keepUpdate = true
        
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
    
    }
    

    
    func dismissMenuView(sender: UIButton){
        
        UIView.animateWithDuration(0.8, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.menuView.frame.origin.y = -self.screenHeight / 2 - 150
            }, completion: nil )
        
        
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

        
        let sceneTransition = SKTransition.crossFadeWithDuration(0.5)
        let gameSectionScene:SKScene = GameSelectionScene()
        self.view?.presentScene(gameSectionScene, transition: sceneTransition)
        
        
    }
    
    func resetGame(sender: UIButton){
        self.dismissMenuView(sender)
        self.rect0.position = CGPointMake(50, 30)
        self.rect1.position = CGPointMake(50, 30)
        self.stick0.position = CGPointMake(120, 30)
        self.stick1.position = CGPointMake(120, 30)
        self.stickRotate0.position = CGPointMake(100, -500)
        self.stickRotate1.position = CGPointMake(100, -500)
        self.doubleTri0.position = CGPointMake(200, 35)
        self.doubleTri1.position =  CGPointMake(200, 35)
        
    }
    
    func transitToNextScene(){
        self.menuButton.hidden = true
        self.playButton.hidden = true
        print("hahah")
    }
    
    //end of game
    func gameEnd(didWin:Bool){
        //self.transitToNextScene()
        self.playButton.hidden = true
        self.menuButton.hidden = true
        
        if didWin {
            self.scoreLabel.text = "Highest Score: " + self.assetViewController.scoreSystem(NSUserDefaults.standardUserDefaults().integerForKey("myInt1"))
            mainLabel.text = "You Win!"
            self.nextLevel.hidden = false
            self.playAgain.hidden = true
        }else {
            self.scoreLabel.text = "Highest Score: " + self.assetViewController.scoreSystem(NSUserDefaults.standardUserDefaults().integerForKey("myInt1"))
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
        
        switch CURRENTLEVEL {
        case 1:
            scene = GameScene2(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        case 2:
            scene = GameScene3(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        case 3:
            scene = GameScene4(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        case 4:
            scene = GameScene(size:CGSizeMake(self.screenWidth, self.screenHeight))
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
