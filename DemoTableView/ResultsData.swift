//
//  ResultsData.swift
//  DemoTableView
//
//  Created by JONG DEOK KIM on 2022/10/03.
//

import Foundation
import UIKit

struct Root:Decodable
{
    let results:[ResultsData]
}

struct ResultsData:Decodable {
    let name:NameData
    let location:LocationData
    let cell:String
    let picture:PictureData
    
    func retrieveImage(completionHandler: @escaping
                       (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with:
                                                URL(string: picture.large)!)
        {
            data, _, error in
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            completionHandler(UIImage(data: data), nil)
        }
        task.resume()
    }
}

struct NameData:Decodable {
    let first:String
    let last:String
}

struct LocationData:Decodable {
    let street:StreetData
}

struct StreetData:Decodable {
    let name:String
}

struct PictureData:Decodable {
    let large:String
}
