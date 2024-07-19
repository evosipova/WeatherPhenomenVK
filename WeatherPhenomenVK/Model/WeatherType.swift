//
//  WeatherModel.swift
//  WeatherPhenomenVK
//
//  Created by Elizaveta Osipova on 7/18/24.
//

import Foundation

enum WeatherModel {
    case clear
    
    var symbolName: String {
        switch self {
        case .clear: return "sun.max.fill"
        }
    }
}
