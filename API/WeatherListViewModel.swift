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
    /*@State var show = false
    @State var url = ""*/
    var body: some View {
        ForEach(results.records){ result in
            VStack(alignment: .leading, spacing: 10){
                Text(result.locationName)
                    .font(.system(size: 12))
                    .foregroundColor(Color.gray)
                Text(result.startTime)
                    .fontWeight(.black)
                Text(result.parameterName)
                    .fontWeight(.black)
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
    @Published var records = [WeatherResultsdata]()
    init(){
        let url = "https://opendata.cwb.gov.tw/api/v1/rest/datastore/F-C0032-001?Authorization=CWB-C3E3EB7A-B9F3-471F-81BB-E75BC74A6463&locationName=%E8%87%BA%E5%8C%97%E5%B8%82,%E6%96%B0%E5%8C%97%E5%B8%82,%E6%A1%83%E5%9C%92%E5%B8%82,%E8%87%BA%E4%B8%AD%E5%B8%82,%E8%87%BA%E5%8D%97%E5%B8%82,%E9%AB%98%E9%9B%84%E5%B8%82,%E5%9F%BA%E9%9A%86%E5%B8%82"
        let session = URLSession(configuration: .default)
               session.dataTask(with: URL(string: url)!){(records, _, err) in
                    let decoder = JSONDecoder()
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-ddthh:mm:ss"
                    decoder.dateDecodingStrategy = .formatted(dateFormatter)
                   if err != nil{
                       print((err?.localizedDescription)!)
                       return
                   }
                   let json = try! JSON(data: records!)
                   print("1")
                   let temp = json["records"]["location"].array!
                   
                   
                for i in temp {
                    let id = i["locationName"].stringValue
                    let locationName = i["locationName"].stringValue
                    let temp2 = json["records"]["location"]["weatherElement"].array!
                    for j in temp2{
                        let elementName = j["weatherElement"]["elementName"].stringValue
                        let temp3 = json["time"].array!
                        for k in temp3{
                            let startTime = k["startTime"].stringValue
                            let parameterName = k["parameter"]["parameterName"].stringValue
                            DispatchQueue.main.async {
                                self.records.append(WeatherResultsdata(id: id, locationName: locationName, startTime: startTime,parameterName: parameterName,elementName:elementName))
                            }
                        }
                    }
                    /*let startTime = i["weatherElement"]["time"]["startTime"].stringValue
                    let parameterName = i["weatherElement"]["time"]["parameter"]["parameterName"].stringValue
                    let elementName = i["weatherElement"]["elementName"].stringValue
                    DispatchQueue.main.async {
                        self.records.append(WeatherResultsdata(id: id, locationName: locationName, startTime: startTime,parameterName: parameterName,elementName:elementName))
                    }
                    print(parameterName)*/
                }
               
                   
            }.resume()
    }
}
