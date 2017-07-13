//
//  GameScene.swift
//  elements2
//
//  Created by Tyler Goodwyn on 7/12/17.
//  Copyright © 2017 Tyler Goodwyn. All rights reserved.
//

import SpriteKit
import Foundation

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    
    var greenCircle: SKShapeNode!
    var redCircle: SKShapeNode!
    var yellowCircle: SKShapeNode!
    var blackCircle: SKShapeNode!
    var blueCircle: SKShapeNode!
    
    var greenCenter: CGPoint!
    var redCenter: CGPoint!
    var yellowCenter: CGPoint!
    var blackCenter: CGPoint!
    var blueCenter: CGPoint!
    
    var greenLabel: SKLabelNode!
    var redLabel: SKLabelNode!
    var yellowLabel: SKLabelNode!
    var blackLabel: SKLabelNode!
    var blueLabel: SKLabelNode!
    
    var greenValue = 0
    var redValue = 0
    var yellowValue = 0
    var blackValue = 0
    var blueValue = 0
    
    
    var objectGrabbed: SKShapeNode!
    var objectMovable:Bool = true
    
    var resetButton: MSButtonNode!
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        self.backgroundColor = UIColor.white
        self.anchorPoint = CGPoint(x: 0, y: 0)
        
        greenCenter = CGPoint(x: size.width / 2, y: size.height / 2  + 300)
        redCenter = CGPoint(x: greenCenter.x + 300 * sin(54 * .pi / 180), y: greenCenter.y - 300 * cos(54 * .pi / 180))
        yellowCenter = CGPoint(x: redCenter.x - 300 * cos(72 * .pi / 180), y: redCenter.y - 300 * sin(72 * .pi / 180))
        blackCenter = CGPoint(x: yellowCenter.x - 300, y: yellowCenter.y)
        blueCenter = CGPoint(x: blackCenter.x - 300 * sin(18 * .pi / 180), y: blackCenter.y + 300 * cos(18 * .pi / 180))
        
        makeCircle(location: greenCenter, color: .green, name: "greenCircle")
        makeCircle(location: redCenter, color: .red, name: "redCircle")
        makeCircle(location: yellowCenter, color: .orange, name: "yellowCircle")
        makeCircle(location: blackCenter, color: .black, name: "blackCircle")
        makeCircle(location: blueCenter, color: .blue, name: "blueCircle")
        
        greenCircle = childNode(withName: "greenCircle") as! SKShapeNode
        redCircle = childNode(withName: "redCircle") as! SKShapeNode
        yellowCircle = childNode(withName: "yellowCircle") as! SKShapeNode
        blackCircle = childNode(withName: "blackCircle") as! SKShapeNode
        blueCircle = childNode(withName: "blueCircle") as! SKShapeNode
        
        makeLabel(location: greenCenter, text: greenValue, name: "greenLabel")
        makeLabel(location: redCenter, text: redValue, name: "redLabel")
        makeLabel(location: yellowCenter, text: yellowValue, name: "yellowLabel")
        makeLabel(location: blackCenter, text: blackValue, name: "blackLabel")
        makeLabel(location: blueCenter, text: blueValue, name: "blueLabel")
        
        greenLabel = childNode(withName: "greenLabel") as! SKLabelNode
        redLabel = childNode(withName: "redLabel") as! SKLabelNode
        yellowLabel = childNode(withName: "yellowLabel") as! SKLabelNode
        blackLabel = childNode(withName: "blackLabel") as! SKLabelNode
        blueLabel = childNode(withName: "blueLabel") as! SKLabelNode

        randomizeValues()
        
        makeButton(name: "resetButton", text: "Reset", location: CGPoint(x: self.size.width / 2, y: self.size.height/2))
        
        resetButton = childNode(withName: "resetButton") as! MSButtonNode
        resetButton.selectedHandler = {
            self.randomizeValues()
        }
    }
    
    func makeCircle(location: CGPoint, color: UIColor, name: String) {
        
        let circle = SKShapeNode(circleOfRadius: 70 ) // Size of Circle = Radius setting.
        circle.position = location  //touch location passed from touchesBegan.
        circle.name = name
        circle.strokeColor = UIColor.black
        circle.glowWidth = 50.0
        circle.fillColor = color
        circle.zPosition = 1
        
        circle.physicsBody = SKPhysicsBody(circleOfRadius: 70)
        circle.physicsBody?.affectedByGravity = false
        circle.physicsBody?.contactTestBitMask = 1
        circle.physicsBody?.categoryBitMask = 1
        circle.physicsBody?.collisionBitMask = 0
        
        self.addChild(circle)
    
    }
    
    func makeLabel(location: CGPoint, text: Int, name: String) {
        
        let label = SKLabelNode()
        label.text = String(text)
        label.position = location
        label.fontColor = .white
        label.fontSize = 48
        label.fontName = "Arial"
        label.zPosition = 2
        label.name = name
        
        label.isUserInteractionEnabled = false
        self.addChild(label)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        objectMovable = true
        let touch = touches.first!
        let location = touch.location(in: self)
        let nodeAtPoint = atPoint(location)
        if nodeAtPoint.name == "greenCircle" || nodeAtPoint.name == "redCircle" || nodeAtPoint.name == "yellowCircle" || nodeAtPoint.name == "blackCircle" || nodeAtPoint.name == "blueCircle" {
            objectGrabbed = atPoint(location) as! SKShapeNode
        } else {
            objectGrabbed = nil
        }
        

        
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if objectGrabbed != nil {
        
            if objectGrabbed.name == "greenCircle" {
                greenLabel.fontColor = .black
            }
            if objectGrabbed.name == "redCircle" {
                redLabel.fontColor = .black
            }
            if objectGrabbed.name == "yellowCircle" {
                yellowLabel.fontColor = .black
            }
            if objectGrabbed.name == "blackCircle" {
                blackLabel.fontColor = .black
            }
            if objectGrabbed.name == "blueCircle" {
                blueLabel.fontColor = .black
            }
            
            if objectMovable == true {
                objectGrabbed.position = (touches.first?.location(in: self))!
            }
            
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        greenCircle.position = greenCenter
        redCircle.position = redCenter
        yellowCircle.position = yellowCenter
        blackCircle.position = blackCenter
        blueCircle.position = blueCenter
        
        greenLabel.fontColor = .white
        redLabel.fontColor = .white
        yellowLabel.fontColor = .white
        blackLabel.fontColor = .white
        blueLabel.fontColor = .white
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        print("contact!")
        objectMovable = false
        
        // supporting interactions
        if (contact.bodyA.node?.name == "greenCircle" || contact.bodyB.node?.name == "greenCircle")
            && (contact.bodyA.node?.name == "redCircle" || contact.bodyB.node?.name == "redCircle") {
            redValue += 1
        }
        if (contact.bodyA.node?.name == "redCircle" || contact.bodyB.node?.name == "redCircle")
            && (contact.bodyA.node?.name == "yellowCircle" || contact.bodyB.node?.name == "yellowCircle") {
            yellowValue += 1
        }
        if (contact.bodyA.node?.name == "yellowCircle" || contact.bodyB.node?.name == "yellowCircle")
            && (contact.bodyA.node?.name == "blackCircle" || contact.bodyB.node?.name == "blackCircle") {
            blackValue += 1
        }
        if (contact.bodyA.node?.name == "blackCircle" || contact.bodyB.node?.name == "blackCircle")
            && (contact.bodyA.node?.name == "blueCircle" || contact.bodyB.node?.name == "blueCircle") {
            blueValue += 1
        }
        if (contact.bodyA.node?.name == "blueCircle" || contact.bodyB.node?.name == "blueCircle")
            && (contact.bodyA.node?.name == "greenCircle" || contact.bodyB.node?.name == "greenCircle") {
            greenValue += 1
        }
        
        // damaging interactions 
        if (contact.bodyA.node?.name == "greenCircle" || contact.bodyB.node?.name == "greenCircle")
            && (contact.bodyA.node?.name == "yellowCircle" || contact.bodyB.node?.name == "yellowCircle") {
            yellowValue -= 1
        }
        if (contact.bodyA.node?.name == "yellowCircle" || contact.bodyB.node?.name == "yellowCircle")
            && (contact.bodyA.node?.name == "blueCircle" || contact.bodyB.node?.name == "blueCircle") {
            blueValue -= 1
        }
        if (contact.bodyA.node?.name == "blueCircle" || contact.bodyB.node?.name == "blueCircle")
            && (contact.bodyA.node?.name == "redCircle" || contact.bodyB.node?.name == "redCircle") {
            redValue -= 1
        }
        if (contact.bodyA.node?.name == "redCircle" || contact.bodyB.node?.name == "redCircle")
            && (contact.bodyA.node?.name == "blackCircle" || contact.bodyB.node?.name == "blackCircle") {
            blackValue -= 1
        }
        if (contact.bodyA.node?.name == "blackCircle" || contact.bodyB.node?.name == "blackCircle")
            && (contact.bodyA.node?.name == "greenCircle" || contact.bodyB.node?.name == "greenCircle") {
            greenValue -= 1
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        greenLabel.text = String(greenValue)
        redLabel.text = String(redValue)
        yellowLabel.text = String(yellowValue)
        blackLabel.text = String(blackValue)
        blueLabel.text = String(blueValue)
        
    }
    
    func randomizeValues() {
        
        var availableNumbers: [Int] = [2, 4, 6, 8, 10]
        
        greenValue = availableNumbers.remove(at: Int(arc4random_uniform(UInt32(availableNumbers.count))))
        redValue = availableNumbers.remove(at: Int(arc4random_uniform(UInt32(availableNumbers.count))))
        yellowValue = availableNumbers.remove(at: Int(arc4random_uniform(UInt32(availableNumbers.count))))
        blackValue = availableNumbers.remove(at: Int(arc4random_uniform(UInt32(availableNumbers.count))))
        blueValue = availableNumbers.remove(at: Int(arc4random_uniform(UInt32(availableNumbers.count))))
    }
    
    func makeButton(name: String, text: String, location: CGPoint) {
        
        var button = MSButtonNode()
        self.addChild(button)
        button.state = .MSButtonNodeStateActive
        button.name = name
        button.text = text
        button.position = location
        button.fontColor = .black
        button.fontSize = 48
        button.zPosition = 2
    }
    
}
