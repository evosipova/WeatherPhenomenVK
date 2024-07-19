//
//  MoonStarView.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/19/24.
//

import UIKit

class MoonStarView: UIView {
    private let moonLabel = UILabel()
    private var starLayers: [CATextLayer] = []
    private var pulseLayers: [CAShapeLayer] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupMoon()
        setupStars()
        startStarAnimations()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupMoon() {
        moonLabel.text = "🌙"
        moonLabel.font = UIFont.systemFont(ofSize: Constants.moonFontSize)
        moonLabel.sizeToFit()
        moonLabel.center = CGPoint(x: bounds.midX, y: bounds.midY)
        addSubview(moonLabel)
    }
    
    private func setupStars() {
        for _ in 0..<Constants.starCount {
            let starCenter = CGPoint(x: CGFloat.random(in: 0...bounds.width), y: CGFloat.random(in: 0...bounds.height))
            let starLayer = createStarLayer(center: starCenter)
            layer.addSublayer(starLayer)
            starLayers.append(starLayer)
            
            let pulseLayer = createPulseLayer(center: starCenter)
            layer.addSublayer(pulseLayer)
            pulseLayers.append(pulseLayer)
        }
    }
    
    private func createStarLayer(center: CGPoint) -> CATextLayer {
        let starLayer = CATextLayer()
        starLayer.string = NSAttributedString(string: "★", attributes: [
            .font: UIFont.systemFont(ofSize: Constants.starFontSize),
            .foregroundColor: UIColor.black.cgColor
        ])
        starLayer.alignmentMode = .center
        starLayer.contentsScale = UIScreen.main.scale
        starLayer.frame = CGRect(x: center.x - 15, y: center.y - 15, width: 30, height: 30)
        return starLayer
    }
    
    private func createPulseLayer(center: CGPoint) -> CAShapeLayer {
        let pulseLayer = CAShapeLayer()
        let starPath = createStarPath(center: .zero, radius: Constants.starRadius, sides: 5, pointyness: Constants.starPointyness)
        pulseLayer.path = starPath.cgPath
        pulseLayer.position = center
        pulseLayer.fillColor = UIColor.yellow.withAlphaComponent(0.3).cgColor
        return pulseLayer
    }
    
    private func startStarAnimations() {
        for (starLayer, pulseLayer) in zip(starLayers, pulseLayers) {
            animateStar(starLayer: starLayer)
            animatePulse(pulseLayer: pulseLayer)
        }
    }
    
    private func animateStar(starLayer: CATextLayer) {
        let opacityAnimation = CABasicAnimation(keyPath: "opacity")
        opacityAnimation.fromValue = 0.5
        opacityAnimation.toValue = 1.0
        opacityAnimation.duration = 0.5
        opacityAnimation.repeatCount = .infinity
        opacityAnimation.autoreverses = true
        starLayer.add(opacityAnimation, forKey: "opacityAnimation")
    }
    
    private func animatePulse(pulseLayer: CAShapeLayer) {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale")
        scaleAnimation.fromValue = 1.0
        scaleAnimation.toValue = 2.0
        scaleAnimation.duration = 1.0
        scaleAnimation.repeatCount = .infinity
        scaleAnimation.autoreverses = true
        pulseLayer.add(scaleAnimation, forKey: "scaleAnimation")
    }
    
    private func createStarPath(center: CGPoint, radius: CGFloat, sides: Int, pointyness: CGFloat) -> UIBezierPath {
        let path = UIBezierPath()
        let adjustment = CGFloat(Double.pi / 2)
        let angle = CGFloat(Double.pi * 2) / CGFloat(sides * 2)
        
        var currentAngle = -adjustment
        
        for i in 0..<sides * 2 {
            let length = i % 2 == 0 ? radius : radius * pointyness
            let x = center.x + length * cos(currentAngle)
            let y = center.y + length * sin(currentAngle)
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
            currentAngle += angle
        }
        path.close()
        return path
    }
}
