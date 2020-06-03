//
//  WeatherListViewModel.swift
//  API
//
//  Created by User20 on 2020/6/1.
//  Copyright © 2020 stryyhhhhhh. All rights reserved.
//

import SwiftUI
import SwiftyJSON

struct WeatherListViewModel: View {
    @ObservedObject var results = getweather()
    @State var show = false
    @State var url = ""
    var body: some View {
                List(results.data){result in
            VStack(alignment: .leading, spacing: 10){
                
                Text(result.name).font(.system(size: 12)).foregroundColor(Color.gray)
                Text(result.weather).fontWeight(.black)
                //Text("winds: "+result.wind).font(.system(size: 15)).padding()
                
                
            }
        }
        }
        
    
    }



struct WeatherListViewModel_Previews: PreviewProvider {
    static var previews: some View {
        WeatherListViewModel()
    }
}


class getweather:ObservableObject{
    @Published var data = [WeatherResults]()
    init(){
        let url = "http://api.openweathermap.org/data/2.5/group?id=1665148,1678228,1548444,1668399,1668355,1673820&units=metric&appid=bdb56bc1ef58c981e76bd0a4d7c6dbd1"
        let session = URLSession(configuration: .default)
               session.dataTask(with: URL(string: url)!){(list, _, err) in
                   if err != nil{
                       print((err?.localizedDescription)!)
                       return
                   }
                   let json = try! JSON(data: list!)
                   let temp = json["list"].array!
                for i in temp {
                    let id = i["id"].intValue
                    let country = i["sys"]["country"].stringValue
                    let name = i["name"].stringValue
                    let weather = i["weather"]["main"].stringValue
                    DispatchQueue.main.async {
                        self.data.append(WeatherResults(id: id, country:country, name: name, weather: weather))
                    }
                }
               
                   
               }.resume()
    }
}
