//
//  WeatherCollectionViewCell.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/18/24.
//

import UIKit

class WeatherCollectionViewCell: UICollectionViewCell {
    lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.center = contentView.center
        contentView.addSubview(imageView)
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupIconImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with weatherType: WeatherType) {
        iconImageView.image = UIImage(systemName: weatherType.symbolName)
    }
    
    private func setupIconImageView() {
        _ = iconImageView
    }
}
