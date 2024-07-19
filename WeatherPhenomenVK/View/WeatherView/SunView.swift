//
//  SunView.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/18/24.
//

import UIKit

class SunView: UIView {
    private var showingRays: Bool = false
    private let sunLayer = CALayer()
    private var rayLayers: [CAShapeLayer] = []
    
    init(frame: CGRect, showingRays: Bool) {
        super.init(frame: frame)
        self.showingRays = showingRays
        setupSun()
        setupRays()
        startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSun() {
        let sunDiameter = bounds.width * Constants.sunDiameterMultiplier
        sunLayer.frame = CGRect(x: (bounds.width - sunDiameter) / 2, y: (bounds.height - sunDiameter) / 2, width: sunDiameter, height: sunDiameter)
        sunLayer.backgroundColor = UIColor.yellow.cgColor
        sunLayer.cornerRadius = sunDiameter / 2
        layer.addSublayer(sunLayer)
    }
    
    private func setupRays() {
        let rayCount = 8
        let rayWidth = bounds.width * Constants.rayWidthMultiplier
        let rayLength = bounds.height * Constants.rayLengthMultiplier
        let sunRadius = bounds.width * Constants.sunRadiusMultiplier / 2
        let distanceFromCenterToRay = sunRadius * 1.5
        
        for i in 0..<rayCount {
            let rayLayer = createRayLayer(rayWidth: rayWidth, rayLength: rayLength)
            let angle = CGFloat(i) * (2 * CGFloat.pi / CGFloat(rayCount))
            rayLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
            rayLayer.position = CGPoint(x: bounds.midX, y: bounds.midY)
            rayLayer.transform = CATransform3DTranslate(rayLayer.transform, 0, -distanceFromCenterToRay, 0)
            layer.addSublayer(rayLayer)
            rayLayers.append(rayLayer)
        }
    }
    
    private func createRayLayer(rayWidth: CGFloat, rayLength: CGFloat) -> CAShapeLayer {
        let rayLayer = CAShapeLayer()
        let rayPath = UIBezierPath(roundedRect: CGRect(x: -rayWidth / 2, y: -rayLength / 2, width: rayWidth, height: rayLength), cornerRadius: rayWidth / 2)
        rayLayer.path = rayPath.cgPath
        rayLayer.fillColor = UIColor.yellow.cgColor
        return rayLayer
    }
    
    private func startAnimating() {
        if layer.animation(forKey: "rotate") == nil {
            let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
            rotateAnimation.fromValue = 0
            rotateAnimation.toValue = 2 * Double.pi
            rotateAnimation.duration = 8
            rotateAnimation.repeatCount = .infinity
            layer.add(rotateAnimation, forKey: "rotate")
        }
    }
}
