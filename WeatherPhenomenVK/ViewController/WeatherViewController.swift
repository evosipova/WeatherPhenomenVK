//
//  WeatherViewController.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/18/24.
//

import UIKit

class WeatherViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    private var weatherTypes: [WeatherType] = [.clear, .rain, .rainbow, .lightning, .starry, .snow, .moon]
    private var collectionView: UICollectionView!
    private var weatherView: WeatherView!
    private var isAnimating = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        selectRandomWeather()
        view.backgroundColor = .white
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return weatherTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeatherCollectionViewCell
        cell.configure(with: weatherTypes[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard !isAnimating else { return }
        isAnimating = true
        let weatherType = weatherTypes[indexPath.row]
        weatherView.animateWeather(for: weatherType)
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.isAnimating = false
        }
    }
    
    private func setupViews() {
        setupCollectionView()
        setupWeatherView()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = Constants.collectionViewItemSize
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(WeatherCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: Constants.collectionViewHeight)
        ])
    }
    
    private func setupWeatherView() {
        weatherView = WeatherView(frame: view.bounds)
        view.addSubview(weatherView)
        view.sendSubviewToBack(weatherView)
    }
    
    private func selectRandomWeather() {
        let randomIndex = Int.random(in: 0..<weatherTypes.count)
        let randomWeather = weatherTypes[randomIndex]
        weatherView.animateWeather(for: randomWeather)
    }
}
