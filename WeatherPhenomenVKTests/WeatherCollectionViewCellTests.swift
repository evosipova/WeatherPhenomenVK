//
//  WeatherCollectionViewCellTests.swift
//  WeatherPhenomenVKTests
//
//  Created by Elizaveta Osipova on 7/19/24.
//

import XCTest
@testable import WeatherPhenomenVK

class WeatherCollectionViewCellTests: XCTestCase {

    var cell: WeatherCollectionViewCell!

    override func setUp() {
        super.setUp()
        cell = WeatherCollectionViewCell(frame: CGRect(x: 0, y: 0, width: 55, height: 55))
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    func testConfigureCell() {
        cell.configure(with: .rain)
        XCTAssertEqual(cell.iconImageView.image, UIImage(systemName: WeatherType.rain.symbolName))
    }
}
