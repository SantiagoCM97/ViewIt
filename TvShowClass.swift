//
//  TvShowClass.swift
//  ViewIt
//
//  Created by Santiago Castaño M on 7/19/16.
//  Copyright © 2016 Santiago Castano. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
enum TvShowCharacteristics: String {
    case iD = "id"
    case Name = "name"
    case Genres = "genres"
    case Status = "status"
    case Premiered = "premiered"
    case Schedule = "schedule"
    case Rating = "rating"
    case Summary = "summary"
    case Network = "network"
    case Language = "language"
    case Image = "image"
    case Embedded = "_embedded"
}

class tvShow {
    var idNumber: Int?
    var name: String?
    var premiered: String?
    //To do: Add Schedule
    var summary: String?
    var poster: UIImage?

    
    init(name: String, idNumber: Int, summary: String){
        self.name = name
        self.idNumber = idNumber
        self.summary = summary
    }
    
    init(name: String, idNumber: Int, summary: String, premiered: String){
        self.name = name
        self.idNumber = idNumber
        self.summary = summary
        self.premiered = premiered
    }
    class func endpointForSearchQuery() -> String {
        return "http://api.tvmaze.com/search/shows?q=flash"
    }
    
    class func urlForPopularShows() -> String {
        return "http://api.themoviedb.org/3/discover/tv?sort_by=popularity.desc&api_key=2bea769ebf770be4e864a1e455f02852"
    }
    
}

