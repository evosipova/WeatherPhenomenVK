//
//  WeatherType.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/18/24.
//

import Foundation

enum WeatherType {
    case clear
    case rain
    case rainbow
    case lightning
    case starry
    case snow
    case moon
    
    var symbolName: String {
        switch self {
        case .clear: return "sun.max.fill"
        case .rain: return "cloud.rain.fill"
        case .rainbow: return "cloud.sun.rain"
        case .lightning: return "cloud.bolt.rain.fill"
        case .starry: return "star.fill"
        case .snow: return "cloud.snow"
        case .moon: return "moon.stars"
        }
    }
    
    var localizedString: String {
        switch self {
        case .clear: return NSLocalizedString("sun", comment: "")
        case .rain: return NSLocalizedString("rain", comment: "")
        case .rainbow: return NSLocalizedString("rainbow", comment: "")
        case .lightning: return NSLocalizedString("lightning", comment: "")
        case .starry: return NSLocalizedString("starry", comment: "")
        case .snow: return NSLocalizedString("snow", comment: "")
        case .moon: return NSLocalizedString("moon", comment: "")
        }
    }
}
