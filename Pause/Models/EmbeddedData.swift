//
//  EmbeddedData.swift
//  Pause
//
//  Created by George Kye on 2016-10-08.
//  Copyright © 2016 George Kye. All rights reserved.
//

import Foundation
import TMDBSwift

let key = "8a7a49369d1af6a70ec5a6787bbfcf79"

extension String{
  func createImageURL(size: Int = 500)->String{
    return  "https://image.tmdb.org/t/p/w\(size)"+self
  }
}

struct EmbeddedData{
  
  var id: Int!
  var title: String!
  var imageURL: String?
  var data: Any!
  var subtitle: String?
  
  init(movie: MovieMDB){
    id = movie.id
    title = movie.title
    imageURL = movie.poster_path
  }
  
  init(tv: TVMDB){
    id = tv.id
    title = tv.name
    imageURL = tv.backdrop_path
  }
  
  init(cast: MovieCastMDB){
    title = cast.name
    subtitle = cast.character
    imageURL = cast.profile_path
  }
  
  init(crew: CrewMDB){
    title = crew.name
    subtitle = crew.department
    imageURL = crew.profile_path
  }
  
  init(images: Images_MDB){
    title = ""
    subtitle = ""
    imageURL = images.file_path
  }
  
  //MOVIE
  static func createData(movie: [MovieMDB])->[EmbeddedData]{
    var data = [EmbeddedData]()
    movie.forEach{
      data.append(EmbeddedData(movie: $0))
    }
    return data
  }
  //TV
  static func createData(tv: [TVMDB])->[EmbeddedData]{
    var data = [EmbeddedData]()
    tv.forEach{
      data.append(EmbeddedData(tv: $0))
    }
    return data
  }
  //Movie Cast
  static func createData(cast: [MovieCastMDB])->[EmbeddedData]{
    var data = [EmbeddedData]()
    cast.forEach{
      data.append(EmbeddedData(cast: $0))
    }
    return data
  }
  
  //TVCast **TODO**
  
  //Crew
  static func createData(crew: [CrewMDB])->[EmbeddedData]{
    var data = [EmbeddedData]()
    crew.forEach{
      data.append(EmbeddedData(crew: $0))
    }
    return data
  }
  
  static func createData(images: [Images_MDB])->[EmbeddedData]{
    var data = [EmbeddedData]()
    images.forEach{
      data.append(EmbeddedData(images: $0))
    }
    return data
  }
}


