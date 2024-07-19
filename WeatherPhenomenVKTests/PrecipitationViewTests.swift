//
//  PrecipitationViewTests.swift
//  WeatherPhenomenVKTests
//
//  Created by Elizaveta Osipova on 7/19/24.
//

import XCTest
@testable import WeatherPhenomenVK

class PrecipitationViewTests: XCTestCase {

    var precipitationView: PrecipitationView!

    override func setUp() {
        super.setUp()
        precipitationView = PrecipitationView(frame: CGRect(x: 0, y: 0, width: 375, height: 667), effectSymbol: "drop.fill")
    }

    override func tearDown() {
        precipitationView = nil
        super.tearDown()
    }

    func testSetupCloud() {
        let cloudLabel = precipitationView.subviews.compactMap { $0 as? UILabel }.first
        XCTAssertNotNil(cloudLabel)
        XCTAssertEqual(cloudLabel?.text, "☁️")
    }
}
