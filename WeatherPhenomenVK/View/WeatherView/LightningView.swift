//
//  LightningView.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/18/24.
//

import UIKit

class LightningView: UIView {
    private let cloudLabel = UILabel()
    private var lightningLayers: [CAShapeLayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCloud()
        setupLightning()
        startLightning()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCloud() {
        cloudLabel.text = "☁️"
        cloudLabel.font = UIFont.systemFont(ofSize: Constants.cloudFontSize)
        cloudLabel.sizeToFit()
        cloudLabel.center = CGPoint(x: bounds.midX, y: bounds.midY - 150)
        addSubview(cloudLabel)
    }
    
    private func setupLightning() {
        for _ in 0..<3 {
            let lightningLayer = createLightningLayer()
            layer.addSublayer(lightningLayer)
            lightningLayers.append(lightningLayer)
        }
    }
    
    private func createLightningLayer() -> CAShapeLayer {
        let lightningLayer = CAShapeLayer()
        lightningLayer.strokeColor = UIColor.yellow.cgColor
        lightningLayer.lineWidth = 3.0
        lightningLayer.lineJoin = .round
        lightningLayer.lineCap = .round
        lightningLayer.opacity = 0
        return lightningLayer
    }
    
    private func startLightning() {
        for lightningLayer in lightningLayers {
            animateLightning(layer: lightningLayer)
        }
    }
    
    private func animateLightning(layer: CAShapeLayer) {
        let path = createLightningPath()
        
        layer.path = path.cgPath
        
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.fromValue = 0
        fadeInAnimation.toValue = 1
        fadeInAnimation.duration = 0.1
        
        let fadeOutAnimation = CABasicAnimation(keyPath: "opacity")
        fadeOutAnimation.fromValue = 1
        fadeOutAnimation.toValue = 0
        fadeOutAnimation.duration = 0.1
        fadeOutAnimation.beginTime = 0.1
        
        let groupAnimation = CAAnimationGroup()
        groupAnimation.animations = [fadeInAnimation, fadeOutAnimation]
        groupAnimation.duration = 0.2
        groupAnimation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        groupAnimation.repeatCount = .infinity
        groupAnimation.beginTime = CACurrentMediaTime() + Double(arc4random_uniform(3))
        
        layer.add(groupAnimation, forKey: "lightningAnimation")
    }
    
    private func createLightningPath() -> UIBezierPath {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: cloudLabel.center.x, y: cloudLabel.center.y))
        
        let lightningSegments = 6
        var currentPoint = cloudLabel.center
        
        for _ in 0..<lightningSegments {
            let randomXOffset = CGFloat(arc4random_uniform(20)) - 10.0
            let randomYOffset = CGFloat(arc4random_uniform(40)) + 20.0
            let nextPoint = CGPoint(x: currentPoint.x + randomXOffset, y: currentPoint.y + randomYOffset)
            path.addLine(to: nextPoint)
            currentPoint = nextPoint
        }
        return path
    }
}
