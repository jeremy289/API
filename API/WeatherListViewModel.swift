//
//  WeatherListViewModel.swift
//  API
//
//  Created by User20 on 2020/6/1.
//  Copyright © 2020 stryyhhhhhh. All rights reserved.
//

import Foundation
import SwiftyJSON
//let urlStr = "http://api.openweathermap.org/data/2.5/group?id=1665148,1678228,1548444,1668399,1668355,1673820&units=metric&appid=bdb56bc1ef58c981e76bd0a4d7c6dbd1"



class getweather:ObservableObject{
    @Published var data = [WeatherResults]()
    init(){
        let url = "http://api.openweathermap.org/data/2.5/group?id=1665148,1678228,1548444,1668399,1668355,1673820&units=metric&appid=bdb56bc1ef58c981e76bd0a4d7c6dbd1"
        let session = URLSession(configuration: .default)
               session.dataTask(with: URL(string: url)!){(data, _, err) in
                   if err != nil{
                       print((err?.localizedDescription)!)
                       return
                   }
                   let json = try! JSON(data: data!)
                   let children = json["data"].array!
                   for i in children{
                       let id = i["id"].stringValue
                       let name = i["name"].stringValue
                       let coord = i["coord"].floatValue
                       let wind = i["wind"].stringValue
                       let weather = i["weather"].stringValue
                       DispatchQueue.main.async {
                           self.data.append(WeatherResults(id: id, name: name, coord: coord , weather: weather,wind: wind))
                       }
                   }
                   
               }.resume()
    }
}
