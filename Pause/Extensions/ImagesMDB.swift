//
//  ImagesMDB.swift
//  Pause
//
//  Created by George Kye on 2016-10-10.
//  Copyright © 2016 George Kye. All rights reserved.
//

import Foundation
import TMDBSwift


extension ImagesMDB{
  
  func createImagesArray()->[Images_MDB]{
    var images = [Images_MDB]()
   
    if backdrops.count > 0{
      backdrops.forEach { images.append($0) }
    }
    
    if posters.count > 0{
      posters.forEach { images.append($0) }
    }
    
    if stills.count > 0{
      stills.forEach { images.append($0) }
    }
    return images
  }
}
