//
//  WeatherViewTests.swift
//  WeatherPhenomenVKTests
//
//  Created by Elizaveta Osipova on 7/19/24.
//

import XCTest
@testable import WeatherPhenomenVK

class WeatherViewTests: XCTestCase {

    var weatherView: WeatherView!

    override func setUp() {
        super.setUp()
        weatherView = WeatherView(frame: CGRect(x: 0, y: 0, width: 375, height: 667))
    }

    override func tearDown() {
        weatherView = nil
        super.tearDown()
    }

    func testClearAnimations() {
        let sunView = SunView(frame: weatherView.bounds, showingRays: true)
        weatherView.addSubview(sunView)
        weatherView.clearAnimations()
        XCTAssertTrue(weatherView.subviews.isEmpty)
        XCTAssertTrue(weatherView.layer.sublayers?.isEmpty ?? true)
    }

    func testAddWeatherLabel() {
        weatherView.addWeatherLabel(for: .clear)
        let label = weatherView.subviews.compactMap { $0 as? UILabel }.first
        XCTAssertNotNil(label)
        XCTAssertEqual(label?.text, WeatherType.clear.localizedString)
    }
}
