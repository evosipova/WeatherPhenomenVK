//
//  WeatherTypeTests.swift
//  WeatherPhenomenVKTests
//
//  Created by Elizaveta Osipova on 7/19/24.
//

import XCTest
@testable import WeatherPhenomenVK

class WeatherTypeTests: XCTestCase {

    func testWeatherTypeSymbols() {
        XCTAssertEqual(WeatherType.clear.symbolName, "sun.max.fill")
        XCTAssertEqual(WeatherType.rain.symbolName, "cloud.rain.fill")
        XCTAssertEqual(WeatherType.rainbow.symbolName, "cloud.sun.rain")
        XCTAssertEqual(WeatherType.lightning.symbolName, "cloud.bolt.rain.fill")
        XCTAssertEqual(WeatherType.starry.symbolName, "star.fill")
        XCTAssertEqual(WeatherType.snow.symbolName, "cloud.snow")
        XCTAssertEqual(WeatherType.moon.symbolName, "moon.stars")
    }

    func testWeatherTypeLocalizedStrings() {
        XCTAssertEqual(WeatherType.clear.localizedString, NSLocalizedString("sun", comment: ""))
        XCTAssertEqual(WeatherType.rain.localizedString, NSLocalizedString("rain", comment: ""))
        XCTAssertEqual(WeatherType.rainbow.localizedString, NSLocalizedString("rainbow", comment: ""))
        XCTAssertEqual(WeatherType.lightning.localizedString, NSLocalizedString("lightning", comment: ""))
        XCTAssertEqual(WeatherType.starry.localizedString, NSLocalizedString("starry", comment: ""))
        XCTAssertEqual(WeatherType.snow.localizedString, NSLocalizedString("snow", comment: ""))
        XCTAssertEqual(WeatherType.moon.localizedString, NSLocalizedString("moon", comment: ""))
    }
}
