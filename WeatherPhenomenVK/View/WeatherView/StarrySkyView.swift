//
//  StarrySkyView.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/18/24.
//

import UIKit

class StarrySkyView: UIView {
    private var starLayer: CAEmitterLayer!
    private var cometLayer: CAEmitterLayer!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupStars()
        setupComet()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStars() {
        starLayer = createStarLayer()
        layer.addSublayer(starLayer)
    }
    
    private func createStarLayer() -> CAEmitterLayer {
        let starLayer = CAEmitterLayer()
        starLayer.emitterPosition = CGPoint(x: bounds.midX, y: bounds.midY)
        starLayer.emitterSize = bounds.size
        starLayer.emitterShape = .rectangle
        starLayer.renderMode = .additive
        
        let starCell1 = createStarCell(imageName: "star", birthRate: 10, lifetime: 3)
        let starCell2 = createStarCell(imageName: "sparkle", birthRate: 20, lifetime: 3)
        
        starLayer.emitterCells = [starCell1, starCell2]
        return starLayer
    }
    
    private func createStarCell(imageName: String, birthRate: Float, lifetime: Float) -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: imageName)?.cgImage
        cell.birthRate = birthRate
        cell.lifetime = lifetime
        cell.scale = 0.2
        cell.scaleRange = 0.05
        cell.alphaRange = 0.8
        return cell
    }
    
    private func setupComet() {
        cometLayer = createCometLayer()
        layer.addSublayer(cometLayer)
        startCometAnimation()
    }
    
    private func createCometLayer() -> CAEmitterLayer {
        let cometLayer = CAEmitterLayer()
        cometLayer.emitterPosition = CGPoint(x: -50, y: -50)
        cometLayer.emitterSize = CGSize(width: 1, height: 1)
        cometLayer.emitterShape = .point
        
        let cometCell = createCometCell()
        cometLayer.emitterCells = [cometCell]
        return cometLayer
    }
    
    private func createCometCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "comet")?.cgImage
        cell.birthRate = 1
        cell.lifetime = 1.5
        cell.velocity = 300
        cell.velocityRange = 50
        cell.scale = 0.2
        cell.scaleRange = 0.1
        cell.alphaRange = 0.8
        cell.alphaSpeed = -0.5
        return cell
    }
    
    private func startCometAnimation() {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: -50, y: -50))
        path.addCurve(to: CGPoint(x: bounds.width / 2, y: bounds.height / 2),
                      controlPoint1: CGPoint(x: bounds.width / 4, y: bounds.height / 4),
                      controlPoint2: CGPoint(x: bounds.width / 3, y: bounds.height / 3))
        
        let cometAnimation = CAKeyframeAnimation(keyPath: "position")
        cometAnimation.path = path.cgPath
        cometAnimation.duration = 2
        cometAnimation.repeatCount = .infinity
        cometAnimation.isRemovedOnCompletion = false
        cometAnimation.fillMode = .forwards
        
        cometLayer.add(cometAnimation, forKey: "cometAnimation")
    }
}
