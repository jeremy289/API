//
//  WeatherResults.swift
//  API
//
//  Created by User20 on 2020/6/1.
//  Copyright © 2020 stryyhhhhhh. All rights reserved.
//

import Foundation

struct WeatherResults: Identifiable {
   var id: String
   let name:String
   let coord: Float
   let weather: String
   let wind: String
}

