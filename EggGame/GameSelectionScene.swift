//
//  GameSelectionScene.swift
//  inEggGame2
//
//  Created by Yuxiang Tang on 9/21/15.
//  Copyright (c) 2015 Yuxiang Tang. All rights reserved.
//

import UIKit
import SpriteKit

extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.CGPath
        self.layer.mask = mask
    }
}

class GameSelectionScene: SKScene {
    
    var mainView: UIView!
    
    var backButton: UIButton!
    
    let screenWidth = UIScreen.mainScreen().bounds.width
    let screenHeight = UIScreen.mainScreen().bounds.height
    
    var levelOne: UIButton!
    var levelOneLabel: UILabel!
    
    var levelTwo: UIButton!
    var levelTwoLabel: UILabel!
    
    var levelThree: UIButton!
    var levelThreeLabel: UILabel!
    
    var levelFour: UIButton!
    var levelFourLabel: UILabel!
    
    var levelFive: UIButton!
    var levelFiveLabel: UILabel!
    
    var lineLayer: CAShapeLayer!
    var bezierPath: UIBezierPath!
    
    var lineLayer2: CAShapeLayer!
    var lineLayer3: CAShapeLayer!
    var lineLayer4: CAShapeLayer!
    
    var backgroundImageView: UIImageView!
    
    var navigationLabel: UIView!
    var rightButton: UIButton!
    var rightButtonView: UIView!
    var leftButton: UIButton!
    var leftButtonView: UIView!
    
    
    //addscoreSystem
    var levelStarScoreImageView1: UIImageView!
    var levelStarScoreImageView2: UIImageView!
    var levelStarScoreImageView3: UIImageView!
    var levelStarScoreImageView4: UIImageView!
    var levelStarScoreImageView5: UIImageView!
    
    var levelStarImage1: UIImageView!
    var levelStarImage2: UIImageView!
    var levelStarImage3: UIImageView!
    var levelStarImage4: UIImageView!
    var levelStarImage5: UIImageView!
    
    
    override func didMoveToView(view: SKView) {
        let background = SKSpriteNode(imageNamed: "background_blue")
        background.alpha = 0.8
        //    background.position = CGpoint (x: screenWidth/2, y: screenHeight/2 )
        background.position = CGPointMake(screenWidth/2, screenHeight/2)
        background.size.width = self.screenWidth / 2 * 3
        
        background.size.height = self.screenHeight
        background.zPosition = -1
        self.addChild(background)

        
        print(NSUserDefaults.standardUserDefaults().integerForKey("myInt1"))
        
        //        self.backgroundImageView = UIImageView(frame: CGRectMake(0, 0, self.screenWidth, self.screenHeight))
        //        self.backgroundImageView.image = UIImage(named: "background")
        //self.view.addSubview(self.backgroundImageView)
        
        self.mainView = UIView(frame: CGRectMake(0, 0, self.screenWidth, self.screenHeight))
        self.mainView.backgroundColor = UIColor.clearColor()
        self.view?.addSubview(self.mainView)
        
        
        self.navigationLabel = UIView(frame: CGRectMake(0, -20, self.screenWidth, 80))
        self.navigationLabel.layer.cornerRadius = 20
        self.navigationLabel.backgroundColor = UIColor.lightGrayColor()
        self.view!.addSubview(self.navigationLabel)
        
        self.rightButtonView = UIView(frame: CGRectMake(self.screenWidth - 60 , 20, 60, 60))
        self.rightButtonView.backgroundColor = UIColor.grayColor()
        self.rightButtonView.roundCorners([.TopLeft, .BottomRight], radius: 20)
        self.navigationLabel.addSubview(self.rightButtonView)
        
        self.rightButton = UIButton(frame: CGRectMake(15, 15, 30, 30))
        self.rightButton.setBackgroundImage(UIImage(named: "menu"), forState: UIControlState.Normal)
        //self.rightButton.addTarget(self, action: "goToLevel", forControlEvents: UIControlEvents.TouchUpInside)
        self.rightButtonView.addSubview(self.rightButton)
        
        self.leftButtonView = UIView(frame: CGRectMake(0, 20,60 , 60))
        self.leftButtonView.backgroundColor = UIColor.grayColor()
        self.leftButtonView.roundCorners( [.TopRight, .BottomLeft], radius: 20)
        self.navigationLabel.addSubview(self.leftButtonView)
        
        
        
        
        
        //        self.backButton = UIButton(frame: CGRectMake(0.0, self.screenHeight - 60, 80.0, 60.0))
        //        self.backButton.setBackgroundImage(UIImage(named: "backButton"), forState: UIControlState.Normal)
        //        self.backButton.addTarget(self, action: "goBack:", forControlEvents: UIControlEvents.TouchUpInside)
        //        self.view!.addSubview(self.backButton)
        
        self.levelOne = UIButton(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 80.0, 60.0, 60.0))
        self.levelOne.setBackgroundImage(UIImage(named: "circle"), forState: UIControlState.Normal)
        self.levelOne.addTarget(self, action: "goToLevel:", forControlEvents: UIControlEvents.TouchUpInside)
        self.levelOne.tag = 1
        self.levelOneLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 20.0, self.screenHeight - 70.0, 40.0, 40.0))
        self.levelOneLabel.text = "1"
        self.levelOneLabel.textAlignment = .Center
        
        self.levelTwo = UIButton(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 200.0, 60.0, 60.0))
        self.levelTwo.setBackgroundImage(UIImage(named: "circle"), forState: UIControlState.Normal)
        self.levelTwo.addTarget(self, action: "goToLevel:", forControlEvents: UIControlEvents.TouchUpInside)
        self.levelTwo.tag = 2
        self.levelTwoLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 20.0, self.screenHeight - 190.0, 40.0, 40.0))
        self.levelTwoLabel.text = "2"
        self.levelTwoLabel.textAlignment = .Center
        
        self.levelThree = UIButton(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 320.0, 60.0, 60.0))
        self.levelThree.setBackgroundImage(UIImage(named: "circle"), forState: UIControlState.Normal)
        self.levelThree.addTarget(self, action: "goToLevel:", forControlEvents: UIControlEvents.TouchUpInside)
        self.levelThree.tag = 3
        self.levelThreeLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 20.0, self.screenHeight - 310.0, 40.0, 40.0))
        self.levelThreeLabel.text = "3"
        self.levelThreeLabel.textAlignment = .Center
        
        self.levelFour = UIButton(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 440.0, 60.0, 60.0))
        self.levelFour.setBackgroundImage(UIImage(named: "circle"), forState: UIControlState.Normal)
        self.levelFour.addTarget(self, action: "goToLevel:", forControlEvents: UIControlEvents.TouchUpInside)
        self.levelFour.tag = 4
        self.levelFourLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 20.0, self.screenHeight - 430.0, 40.0, 40.0))
        self.levelFourLabel.text = "4"
        self.levelFourLabel.textAlignment = .Center
        
        self.levelFive = UIButton(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 560.0, 60.0, 60.0))
        self.levelFive.setBackgroundImage(UIImage(named: "circle"), forState: UIControlState.Normal)
        self.levelFive.addTarget(self, action: "goToLevel:", forControlEvents: UIControlEvents.TouchUpInside)
        self.levelFive.tag = 5
        self.levelFiveLabel = UILabel(frame: CGRectMake(self.screenWidth / 2 - 20.0, self.screenHeight - 550.0, 40.0, 40.0))
        self.levelFiveLabel.text = "5"
        self.levelFiveLabel.textAlignment = .Center
        
        
        self.lineLayer = CAShapeLayer()
        self.bezierPath = self.drawLineFromPoint(CGPointMake(self.screenWidth / 2 , self.screenHeight - 75.0), toPoint: CGPointMake(self.screenWidth / 2, self.screenHeight - 145.0))
        self.lineLayer.path = self.bezierPath.CGPath
        self.lineLayer.strokeColor = UIColor.purpleColor().CGColor
        self.lineLayer.lineWidth = 4.0
        
        
        self.lineLayer2 = CAShapeLayer()
        self.bezierPath = self.drawLineFromPoint(CGPointMake(self.screenWidth / 2 , self.screenHeight - 190.0), toPoint: CGPointMake(self.screenWidth / 2, self.screenHeight - 260.0))
        self.lineLayer2.path = self.bezierPath.CGPath
        self.lineLayer2.strokeColor = UIColor.purpleColor().CGColor
        self.lineLayer2.lineWidth = 4.0
        
        self.lineLayer3 = CAShapeLayer()
        self.bezierPath = self.drawLineFromPoint(CGPointMake(self.screenWidth / 2 , self.screenHeight - 310.0), toPoint: CGPointMake(self.screenWidth / 2, self.screenHeight - 380.0))
        self.lineLayer3.path = self.bezierPath.CGPath
        self.lineLayer3.strokeColor = UIColor.purpleColor().CGColor
        self.lineLayer3.lineWidth = 4.0
        
        self.lineLayer4 = CAShapeLayer()
        self.bezierPath = self.drawLineFromPoint(CGPointMake(self.screenWidth / 2 , self.screenHeight - 430.0), toPoint: CGPointMake(self.screenWidth / 2, self.screenHeight - 500.0))
        self.lineLayer4.path = self.bezierPath.CGPath
        self.lineLayer4.strokeColor = UIColor.purpleColor().CGColor
        self.lineLayer4.lineWidth = 4.0
        
        
        //addScoreSYstem
        var starLevel1 = UIImage(named:"points_stars_compressed_1")
        var starLevel2 = UIImage(named:"points_stars_compressed_2")
        var starLevel3 = UIImage(named:"points_stars_compressed_3")
        var starLevel4 = UIImage(named:"points_stars_compressed_4")
        
        
        
        var level1 = NSUserDefaults.standardUserDefaults().integerForKey("1")
        var level2 = NSUserDefaults.standardUserDefaults().integerForKey("2")
        var level3 = NSUserDefaults.standardUserDefaults().integerForKey("3")
        var level4 = NSUserDefaults.standardUserDefaults().integerForKey("4")
        var level5 = NSUserDefaults.standardUserDefaults().integerForKey("5")
        
        self.levelStarScoreImageView1 = UIImageView(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 80.0, 60.0, 60.0))
        self.levelStarScoreImageView2 = UIImageView(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 200.0, 60.0, 60.0))
        self.levelStarScoreImageView3 = UIImageView(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 320.0, 60.0, 60.0))
        self.levelStarScoreImageView4 = UIImageView(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 440.0, 60.0, 60.0))
        self.levelStarScoreImageView5 = UIImageView(frame: CGRectMake(self.screenWidth / 2 - 30.0, self.screenHeight - 560.0, 60.0, 60.0))
        
        
        levelStarImage1 = UIImageView(frame: CGRectMake(50, 0, 40, 20))
        levelStarImage2 = UIImageView(frame: CGRectMake(50, 0, 40, 20))
        levelStarImage3 = UIImageView(frame: CGRectMake(50, 0, 40, 20))
        levelStarImage4 = UIImageView(frame: CGRectMake(50, 0, 40, 20))
        levelStarImage5 = UIImageView(frame: CGRectMake(50, 0, 40, 20))
        
        
        switch level1 {
        case 0:
            self.levelStarImage1.image = starLevel1
            
            break
        case 1:
            self.levelStarImage1.image = starLevel2
            
            break
        case 2:
            self.levelStarImage1.image = starLevel3
            
            break
        case 3:
            self.levelStarImage1.image = starLevel4
            
            break
        default:
            break
        }
        
        switch level2 {
        case 0:
            self.levelStarImage2.image = starLevel1
            
            break
        case 1:
            self.levelStarImage2.image = starLevel2
            
            break
        case 2:
            self.levelStarImage2.image = starLevel3
            
            break
        case 3:
            self.levelStarImage2.image = starLevel4
            
            break
        default:
            break
        }
        
        switch level3 {
        case 0:
            self.levelStarImage3.image = starLevel1
            
            break
        case 1:
            self.levelStarImage3.image = starLevel2
            
            break
        case 2:
            self.levelStarImage3.image = starLevel3
            
            break
        case 3:
            self.levelStarImage3.image = starLevel4
            
            break
        default:
            break
        }
        
        
        switch level4 {
        case 0:
            self.levelStarImage4.image = starLevel1
            
            break
        case 1:
            self.levelStarImage4.image = starLevel2
            
            break
        case 2:
            self.levelStarImage4.image = starLevel3
            
            break
        case 3:
            self.levelStarImage4.image = starLevel4
            
            break
        default:
            break
        }
        
        switch level5 {
        case 0:
            self.levelStarImage5.image = starLevel1
            
            break
        case 1:
            self.levelStarImage5.image = starLevel2
            
            break
        case 2:
            self.levelStarImage5.image = starLevel3
            
            break
        case 3:
            self.levelStarImage5.image = starLevel4
            
            break
        default:
            break
        }
        
        
        self.levelStarScoreImageView1.addSubview(levelStarImage1)
        self.levelStarScoreImageView2.addSubview(levelStarImage2)
        self.levelStarScoreImageView3.addSubview(levelStarImage3)
        self.levelStarScoreImageView4.addSubview(levelStarImage4)
        self.levelStarScoreImageView5.addSubview(levelStarImage5)
        
        self.mainView.addSubview(self.levelStarScoreImageView1)
        self.mainView.addSubview(self.levelStarScoreImageView2)
        self.mainView.addSubview(self.levelStarScoreImageView3)
        self.mainView.addSubview(self.levelStarScoreImageView4)
        self.mainView.addSubview(self.levelStarScoreImageView5)
        
        
        
        //endofscoresystem
        
        
        self.mainView.layer.addSublayer(self.lineLayer)
        self.mainView.layer.addSublayer(self.lineLayer2)
        self.mainView.layer.addSublayer(self.lineLayer3)
        self.mainView.layer.addSublayer(self.lineLayer4)
        self.mainView.addSubview(self.levelOne)
        self.mainView.addSubview(self.levelOneLabel)
        self.mainView.addSubview(self.levelTwo)
        self.mainView.addSubview(self.levelTwoLabel)
        self.mainView.addSubview(self.levelThree)
        self.mainView.addSubview(self.levelThreeLabel)
        self.mainView.addSubview(self.levelFour)
        self.mainView.addSubview(self.levelFourLabel)
        self.mainView.addSubview(self.levelFive)
        self.mainView.addSubview(self.levelFiveLabel)
    }
    
    func drawLineFromPoint(start: CGPoint, toPoint end: CGPoint) -> UIBezierPath {
        let path = UIBezierPath()
        path.moveToPoint(start)
        path.addLineToPoint(end)
        path.stroke()
        
        return path
        
    }
    
    func goToLevel(sender: UIButton){
        
        let transition:SKTransition = SKTransition.flipHorizontalWithDuration(0.5)
        var gameScene:SKScene!
        switch sender.tag {
        case 1:
            gameScene = Level_One(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        case 2:
            gameScene = Level_Two(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        case 3:
            gameScene = Level_Three(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        case 4:
            gameScene = Level_Four(size:CGSizeMake(self.screenWidth, self.screenHeight))
            break
        case 5:
            gameScene = Level_Five(size: CGSizeMake(self.screenWidth, self.screenHeight))
        default:
            break
        }
        
        
        
        self.mainView.hidden = true
        self.navigationLabel.hidden = true
        self.view?.presentScene(gameScene, transition: transition)
    }
    
    
    
}
