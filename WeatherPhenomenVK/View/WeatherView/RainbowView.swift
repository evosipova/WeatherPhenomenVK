//
//  RainbowView.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/18/24.
//

import UIKit

class RainbowView: UIView {
    private let colors: [UIColor] = [.red, .orange, .yellow, .green, .systemBlue, .blue, .purple]
    private var rainbowLayers: [CAShapeLayer] = []
    private let cloudSize: CGFloat = Constants.cloudFontSize
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupRainbow()
        setupClouds()
        startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupRainbow() {
        let radius = min(bounds.width, bounds.height) / 2 - 20
        let center = CGPoint(x: bounds.midX, y: bounds.midY + 50)
        
        for (index, color) in colors.enumerated() {
            let rainbowLayer = createRainbowLayer(radius: radius - CGFloat(index) * 15, center: center, color: color)
            layer.addSublayer(rainbowLayer)
            rainbowLayers.append(rainbowLayer)
        }
    }
    
    private func createRainbowLayer(radius: CGFloat, center: CGPoint, color: UIColor) -> CAShapeLayer {
        let rainbowLayer = CAShapeLayer()
        let path = UIBezierPath(arcCenter: center, radius: radius, startAngle: .pi, endAngle: 0, clockwise: true)
        rainbowLayer.path = path.cgPath
        rainbowLayer.strokeColor = color.cgColor
        rainbowLayer.fillColor = UIColor.clear.cgColor
        rainbowLayer.lineWidth = 10
        rainbowLayer.strokeEnd = 0
        return rainbowLayer
    }
    
    private func setupClouds() {
        let leftCloud = createCloudLabel()
        leftCloud.center = CGPoint(x: bounds.midX - (bounds.width / 2) + (cloudSize / 2), y: bounds.midY + 50)
        addSubview(leftCloud)
        
        let rightCloud = createCloudLabel()
        rightCloud.center = CGPoint(x: bounds.midX + (bounds.width / 2) - (cloudSize / 2), y: bounds.midY + 50)
        addSubview(rightCloud)
    }
    
    private func createCloudLabel() -> UILabel {
        let cloud = UILabel()
        cloud.text = "☁️"
        cloud.font = UIFont.systemFont(ofSize: cloudSize)
        cloud.sizeToFit()
        return cloud
    }
    
    private func startAnimating() {
        for (index, rainbowLayer) in rainbowLayers.enumerated() {
            let animation = CABasicAnimation(keyPath: "strokeEnd")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 2
            animation.beginTime = CACurrentMediaTime() + Double(index) * 0.3
            animation.fillMode = .forwards
            animation.isRemovedOnCompletion = false
            rainbowLayer.add(animation, forKey: "rainbowAnimation")
        }
    }
}
