//
//  GameScene.swift
//  jumpy
//
//  Created by luis castillo on 7/5/16.
//  Copyright (c) 2016 luis castillo. All rights reserved.
//

import SpriteKit

struct physics {static let police : UInt32 = 1
    static let sprite : UInt32 = 2
}

class GameScene: SKScene {
    
    let sprite = SKSpriteNode(imageNamed: "Mini_truck")
    var scrollLayer: SKNode!
    var scrollSpeed: CGFloat = 1300
    let fixedDelta : CGFloat = 1.0/60.0
    var touchLocation = CGPoint?()
    let cone = SKSpriteNode(imageNamed: "cone")
    
    /* let there be light */
    let lightSprite = SKLightNode()
    
    
    
    
    
    override func didMoveToView(view: SKView) {
        /* Set up your scene here */
       
        
        /* LOOK FOR CAR */
        
        scrollLayer = self.childNodeWithName("scrollLayer")
        //police = self.childNodeWithName("police")! as! SKSpriteNode
        /*car position */
        sprite.xScale = 0.7
        sprite.yScale = 0.7
        sprite.position = CGPoint(x: frame.width / 2, y: frame.height / 2)
        
        self.addChild(sprite)
        
        sprite.physicsBody = SKPhysicsBody(circleOfRadius: sprite.size.width / 3)
        sprite.physicsBody!.dynamic = true
        physicsWorld.gravity = CGVector(dx: 0.00, dy: 0.01);
        sprite.physicsBody?.allowsRotation = true
        

        /*keeps car within the screen */
        
       let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        
        /* spawn enemy */
        _ = NSTimer.scheduledTimerWithTimeInterval(0.85, target: self, selector: #selector(GameScene.spawnEnemies), userInfo: nil, repeats: true)
        _ = NSTimer.scheduledTimerWithTimeInterval(1.9, target: self, selector: #selector(GameScene.spawnEnemiesRight), userInfo: nil, repeats: true)
        
        
        /* adds particle to scene */
        let particle = NSBundle.mainBundle().pathForResource("spark", ofType: "sks")
        let particleX = NSKeyedUnarchiver.unarchiveObjectWithFile(particle!) as? SKEmitterNode
       
        
        particleX?.xScale = 0.05
        particleX?.yScale = 0.3
        
        sprite.addChild(particleX!)
        
        
      
        
    
        

    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        let rangeX = SKRange(lowerLimit: 80, upperLimit: 620)
        let rangeY = SKRange(lowerLimit: 190, upperLimit: 220)
        
        
        
        for touch in (touches) {
            let location = touch.locationInNode(self)

            
            //if sprite.containsPoint(location) {sprite.position = location}
            if sprite.containsPoint(location) {
                
                sprite.constraints = [SKConstraint.positionX(rangeX, y: rangeY)]
                
                
            }
            
        }
        
    }
            
    
    func spawnEnemies() {
        let police = SKSpriteNode(imageNamed: "Police")
        
        let borderBody = SKPhysicsBody(edgeLoopFromRect: police.frame)
        borderBody.friction = 0
        self.physicsBody = borderBody
        
        police.position = CGPoint(x:CGFloat.random(min: self.size.width * 0.09, max: self.size.width * 0.4), y : self.size.height * 2.2)

        //(x:CGFloat(arc4random_uniform(UInt32(self.size.width * 0.43))), y: self.size.height )
        self.addChild(police)
        
        let action = SKAction.moveToY(-1000, duration: 3)
        
        
        police.runAction(SKAction.repeatActionForever(action))
        police.xScale = 0.7
        police.yScale = 0.7
        police.physicsBody?.dynamic = false
        police.zRotation = 179.075
        police.physicsBody = SKPhysicsBody(circleOfRadius: police.size.width / 7)
    }
    
    
    override func touchesMoved(touches: Set< UITouch >, withEvent event: UIEvent?) {
        
        for touch in touches{ let location = touch.locationInNode(self)
            
            sprite.position = location
            
            
        }
        
    }
    
    func spawnEnemiesRight() {
        let Car = SKSpriteNode(imageNamed: "Car")
         self.addChild(Car)
        
        let borderBody = SKPhysicsBody(edgeLoopFromRect: Car.frame)
         borderBody.friction = 0
        self.physicsBody = borderBody
        

        Car.position = CGPoint(x:CGFloat.random(min: self.size.width * 0.6, max: self.size.width * 0.9), y : self.size.height * 1.5)
        
        
        let action = SKAction.moveToY(-1000, duration: 8)
        
        
        Car.runAction(SKAction.repeatActionForever(action))
        Car.xScale = 0.7
        Car.yScale = 0.7
        Car.physicsBody?.dynamic = false
        
        Car.physicsBody = SKPhysicsBody(circleOfRadius: Car.size.width / 6)
        
    }

    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        scrollWorld()
    }
        
    
    func scrollWorld() {
        /* scroll World */
        
        scrollLayer.position.y -= scrollSpeed * CGFloat(fixedDelta)
        
        for road in scrollLayer.children as! [SKSpriteNode] {
            
            /* Get ground node posiiton, convert node posiiton to scene space */
            let roadPosition = scrollLayer.convertPoint(road.position, toNode: self)
            
            /* Check if ground sprite has left the scene */
            if roadPosition.y <= -road.size.height / 2 {
                
                road.position.y += road.size.height * 2
                
                
            }
            
        }
        
        
    }
    
    
    
    func updateObstacles() {
        /* Update obstacles */
        
        
    }
    
    func addObstacles() {
        
        
    }
    
    
}




                













    

