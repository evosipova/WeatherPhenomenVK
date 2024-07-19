//
//  PrecipitationView.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/19/24.
//

import UIKit

class PrecipitationView: UIView {
    private let cloudLabel = UILabel()
    private var effectLayer: CAEmitterLayer!
    private var effectSymbol: String

    init(frame: CGRect, effectSymbol: String) {
        self.effectSymbol = effectSymbol
        super.init(frame: frame)
        setupCloud()
        setupEffect()
        startEffect()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupCloud() {
        cloudLabel.text = "☁️"
        cloudLabel.font = UIFont.systemFont(ofSize: 200)
        cloudLabel.sizeToFit()
        cloudLabel.center = CGPoint(x: bounds.midX, y: bounds.midY - 150)
        addSubview(cloudLabel)
    }

    private func setupEffect() {
        effectLayer = CAEmitterLayer()
        effectLayer.emitterPosition = CGPoint(x: bounds.midX, y: cloudLabel.frame.maxY)
        effectLayer.emitterSize = CGSize(width: cloudLabel.frame.width, height: 1)
        effectLayer.emitterShape = .line

        let cell = CAEmitterCell()
        cell.contents = UIImage(systemName: effectSymbol)?.cgImage
        cell.birthRate = 5
        cell.lifetime = 1.5
        cell.velocity = 70
        cell.scale = 0.7
        cell.scaleRange = 0.05
        cell.emissionLongitude = CGFloat.pi

        effectLayer.emitterCells = [cell]
        layer.addSublayer(effectLayer)
    }

    private func startEffect() {
        effectLayer.beginTime = CACurrentMediaTime()
        effectLayer.setValue(10, forKeyPath: "emitterCells.cell.birthRate")
    }

    private func stopEffect() {
        effectLayer.setValue(0, forKeyPath: "emitterCells.cell.birthRate")
    }
}
