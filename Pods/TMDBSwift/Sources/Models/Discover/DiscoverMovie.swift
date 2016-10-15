//
//  DiscoverMovie.swift
//  TheMovieDBWrapperSwift
//
//  Created by George Kye on 2016-02-05.
//  Copyright © 2016 George KyeKye. All rights reserved.
//

import Foundation

public enum MovieGenres: String{
  case Action = "28";
  case Adventure = "12";
  case Animation = "16";
  case Comedy = "35";
  case Crime = "80";
  case Documentary = "99";
  case Drama = "18";
  case Family = "10751";
  case Fantasy = "14";
  case Foreign = "10769";
  case History = "36";
  case Horror = "27";
  case Music = "10402";
  case Mystery = "9648";
  case Romance = "10749";
  case ScienceFiction = "878";
  case TvMovie = "10770";
  case Thriller = "53";
  case War = "10752";
  case Western = "37";
}

open class DiscoverMovieMDB: DiscoverMDB{
  
  
  ////DiscoverMovie query.  Language must be an ISO 639-1 code. Page must be greater than one. sort_by expected values can be found in DiscoverSortBy() and DiscoverSortByMovie. ALL parameters are optional.
  open class func discoverMovies(_ api_key: String, language: String?, page: Double?, sort_by: String? = nil, completion: @escaping (_ clientReturn: ClientReturn, _ data: [MovieMDB]?) -> ()) -> (){
    
    Client.discover(api_key, baseURL:"movie", sort_by: sort_by, certification_country: nil, certification: nil, certification_lte: nil, include_adult: nil, include_video: nil, primary_release_year: nil, primary_release_date_gte: nil, primary_release_date_lte: nil, release_date_gte: nil, release_date_lte: nil, air_date_gte: nil, air_date_lte: nil, first_air_date_gte: nil, first_air_date_lte: nil, first_air_date_year: nil, language: language, page: page, timezone: nil, vote_average_gte: nil, vote_average_lte: nil, vote_count_gte: nil, vote_count_lte: nil, with_genres: nil, with_cast: nil, with_crew: nil, with_companies: nil, with_keywords: nil, with_people: nil, with_networks: nil, year: nil, certification_gte: nil){
      apiReturn in
      var data: [MovieMDB]?
      if(apiReturn.error == nil){ data = MovieMDB.initialize(json: apiReturn.json!["results"]) }
      completion(apiReturn, data)
    }
    
  }
  ///DiscoverMovie query.  Language must be an ISO 639-1 code. Page must be greater than one. sort_by expected values can be found in DiscoverSortBy() and DiscoverSortByMovie. You must specify a valid 'certification_country' and a valid certification for the specified value. all `_with` values-> comma separated indicates an 'AND' query, while a pipe (|) separated value indicates an 'OR'. ALL parameters are optional.
  open class func discoverMovies(_ api_key: String, sort_by: String? = nil, certification_country: String? = nil, certification: String? = nil, certification_lte: String? = nil, certification_gte: String? = nil, include_adult: Bool?, include_video: Bool? = nil, primary_release_year: String? = nil, primary_release_date_gte: String? = nil, primary_release_date_lte: String? = nil, release_date_gte: String? = nil, release_date_lte: String? = nil, language: String?, page: Double?, vote_average_gte: Double? = nil, vote_average_lte: Double? = nil, vote_count_gte: Double? = nil, vote_count_lte: Double? = nil, with_cast: String? = nil, with_crew: String? = nil, with_companies: String? = nil, with_genres: String?, with_keywords: String?, with_people: String?, with_networks: String?, year: Float?, completion: @escaping (_ clientReturn: ClientReturn, _ data: [MovieMDB]?) -> ()) -> (){
    
    Client.discover(api_key, baseURL:"movie", sort_by: sort_by, certification_country: certification_country, certification: certification, certification_lte: certification_lte, include_adult: include_adult, include_video: include_video, primary_release_year: primary_release_year, primary_release_date_gte: primary_release_date_gte, primary_release_date_lte: primary_release_date_lte, release_date_gte: release_date_gte, release_date_lte: release_date_lte, air_date_gte: nil, air_date_lte: nil, first_air_date_gte: nil, first_air_date_lte: nil, first_air_date_year: nil, language: language, page: page,  timezone: nil, vote_average_gte: vote_average_gte, vote_average_lte: vote_average_lte, vote_count_gte: vote_count_gte, vote_count_lte: vote_count_lte, with_genres: with_genres, with_cast: with_cast, with_crew: with_crew, with_companies: with_companies , with_keywords: with_keywords, with_people: with_people, with_networks: with_networks , year: year, certification_gte: certification_gte){
      apiReturn in
      var data: [MovieMDB]?
      if(apiReturn.error == nil){ data = MovieMDB.initialize(json: apiReturn.json!["results"]) }
      completion(apiReturn, data)
    }
  }
  
  ///Expected date format = "YYYY-MM-DD -> 2015-01-8". ALL parameters are optional
  open class func discoverMovies(_ api_key: String, primary_release_date_gte: String? = nil, primary_release_date_lte: String? = nil, language: String? = nil, page: Double? = nil, sort_by: String? = nil, completion: @escaping (_ clientReturn: ClientReturn, _ data: [MovieMDB]?) -> ()) -> (){
    Client.discover(api_key, baseURL:"movie", sort_by: sort_by, certification_country: nil, certification: nil, certification_lte: nil, include_adult: nil, include_video: nil, primary_release_year: nil, primary_release_date_gte: primary_release_date_gte, primary_release_date_lte: primary_release_date_lte, release_date_gte: nil, release_date_lte: nil, air_date_gte: nil, air_date_lte: nil, first_air_date_gte: nil, first_air_date_lte: nil, first_air_date_year: nil, language: language, page: page, timezone: nil, vote_average_gte: nil, vote_average_lte: nil, vote_count_gte: nil, vote_count_lte: nil, with_genres: nil, with_cast: nil, with_crew: nil, with_companies: nil, with_keywords: nil, with_people: nil, with_networks: nil, year: nil, certification_gte: nil){
      apiReturn in
      var data: [MovieMDB]?
      if(apiReturn.error == nil){ data = MovieMDB.initialize(json: apiReturn.json!["results"]) }
      completion(apiReturn, data)
    }
  }
  
  
  ///all `_with` values-> comma separated indicates an 'AND' query, while a pipe (|) separated value indicates an 'OR'. ALL parameters are optional
  open class func discoverMoviesWith(_ api_key: String, with_genres: String? = nil, with_cast: String? = nil, with_crew: String? = nil, with_companies: String? = nil, with_keywords: String? = nil, with_people: String? = nil, with_networks: String? = nil, year: Float? = nil, sort_by: String? = nil, page: Double, language: String, completion: @escaping (_ clientReturn: ClientReturn, _ data: [MovieMDB]?) -> ()) -> (){
    Client.discover(api_key, baseURL:"movie", sort_by: sort_by, certification_country: nil, certification: nil, certification_lte: nil, include_adult: nil, include_video: nil, primary_release_year: nil, primary_release_date_gte: nil, primary_release_date_lte: nil, release_date_gte: nil, release_date_lte: nil, air_date_gte: nil, air_date_lte: nil, first_air_date_gte: nil, first_air_date_lte: nil, first_air_date_year: nil, language: language, page: page, timezone: nil, vote_average_gte: nil, vote_average_lte: nil, vote_count_gte: nil, vote_count_lte: nil, with_genres: with_genres, with_cast: with_cast, with_crew: with_crew, with_companies: with_companies , with_keywords: with_keywords, with_people: with_people, with_networks: with_networks , year: year, certification_gte: nil){
      apiReturn in
      var data: [MovieMDB]?
      if(apiReturn.error == nil){ data = MovieMDB.initialize(json: apiReturn.json!["results"]) }
      completion(apiReturn, data)
    }
  }
  
  ///Get the list of movies associated with a particular company.
  open class func companyMovies(_ api_key: String!, companyId: Int!, language: String?, page: Int?, completion: @escaping (_ clientReturn: ClientReturn, _ data: [MovieMDB]?) -> ()) -> (){
    Client.Company(api_key, companyId: companyId!, language: language, page: page){
      apiReturn in
      var data: [MovieMDB]?
      if(apiReturn.error == nil){ data = MovieMDB.initialize(json: apiReturn.json!["results"]) }
      completion(apiReturn, data)
    }
  }
  
  ///Get the list of movies for a particular keyword by id.
  //    class func keyword(api_key: String!, keywordId: Int!, page: Int?, completion: (ClientReturn) -> ()) -> (){
  //        Client.keyword(api_key, api_key: keywordId, page: page, language: true){
  //            apiReturn in
  //            completion(apiReturn)
  //        }
  //    }
  
  ///Get the list of movies for a particular genre by id. By default, only movies with 10 or more votes are included.
  open class func genreList(_ api_key: String!, genreId: Int, page: Double?, include_all_movies: Bool? = nil, include_adult: Bool? = nil, movieList: Bool? = nil, completion: @escaping (_ clientReturn: ClientReturn, _ data: [MovieMDB]?) -> ()) -> (){
    Client.Genres(api_key, listType: "movie", language: nil, genreId: genreId, page: page, include_all_movies: include_all_movies, include_adult: nil, movieList: true){
      apiReturn in
      var data: [MovieMDB]?
      if(apiReturn.error == nil){ data = MovieMDB.initialize(json: apiReturn.json!["results"]) }
      completion(apiReturn, data)
    }
  }
  
  
}
