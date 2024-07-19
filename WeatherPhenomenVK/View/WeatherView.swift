//
//  WeatherView.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/18/24.
//

import UIKit

class WeatherView: UIView {
    func animateWeather(for type: WeatherType) {
        UIView.animate(withDuration: 0.5, animations: {
            self.alpha = 0
        }) { [weak self] _ in
            guard let self = self else { return }
            self.clearAnimations()
            self.addEffect(for: type)
            self.addWeatherLabel(for: type)
            UIView.animate(withDuration: 0.5) {
                self.alpha = 1
            }
        }
    }
    
    func clearAnimations() {
        self.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
        self.subviews.forEach { $0.removeFromSuperview() }
    }

    func addWeatherLabel(for type: WeatherType) {
        weatherLabel.text = type.localizedString
        addSubview(weatherLabel)

        NSLayoutConstraint.activate([
            weatherLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            weatherLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            weatherLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),
            weatherLabel.heightAnchor.constraint(equalToConstant: 50)
        ])
    }

    private func addEffect(for type: WeatherType) {
        switch type {
        case .clear:
            addEffectView(SunView(frame: self.bounds, showingRays: true))
        case .rain:
            addPrecipitationEffect(symbol: "drop.fill")
        case .rainbow:
            addEffectView(RainbowView(frame: self.bounds))
        case .lightning:
            addEffectView(LightningView(frame: self.bounds))
        case .starry:
            addEffectView(StarrySkyView(frame: self.bounds))
        case .snow:
            addPrecipitationEffect(symbol: "snowflake")
        case .moon:
            addEffectView(MoonStarView(frame: self.bounds))
        }
    }
    
    private func addEffectView(_ effectView: UIView) {
        effectView.alpha = 0
        addSubview(effectView)
        UIView.animate(withDuration: 0.5) {
            effectView.alpha = 1
        }
    }
    
    private func addPrecipitationEffect(symbol: String) {
        let weatherEffectView = PrecipitationView(frame: self.bounds, effectSymbol: symbol)
        addEffectView(weatherEffectView)
    }
    
    private lazy var weatherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        label.layer.borderColor = UIColor.black.cgColor
        label.layer.borderWidth = 2
        label.layer.cornerRadius = 10
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
}
