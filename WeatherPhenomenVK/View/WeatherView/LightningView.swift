//
//  FogView.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/18/24.
//

import UIKit

import UIKit

class FogView: UIView {

    private var fogLayer: CAEmitterLayer!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupFog()
        startAnimating()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupFog() {
        fogLayer = CAEmitterLayer()
        fogLayer.emitterPosition = CGPoint(x: -50, y: bounds.midY)
        fogLayer.emitterSize = CGSize(width: bounds.width, height: bounds.height)
        fogLayer.emitterShape = .line

        let cell = CAEmitterCell()
        cell.contents = UIImage(systemName: "cloud.fill")?.cgImage
        cell.birthRate = 10
        cell.lifetime = 10.0
        cell.velocity = 30
        cell.velocityRange = 10
        cell.scale = 0.5
        cell.scaleRange = 0.2
        cell.alphaRange = 0.5
        cell.alphaSpeed = -0.05

        fogLayer.emitterCells = [cell]
        layer.addSublayer(fogLayer)
    }

    private func startAnimating() {
        let moveAnimation = CABasicAnimation(keyPath: "emitterPosition.x")
        moveAnimation.fromValue = -50
        moveAnimation.toValue = bounds.width + 50
        moveAnimation.duration = 10
        moveAnimation.repeatCount = .infinity
        fogLayer.add(moveAnimation, forKey: "moveAnimation")
    }
}
