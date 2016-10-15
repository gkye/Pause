//
//  EmbeddedCell.swift
//  Pause
//
//  Created by George Kye on 2016-10-08.
//  Copyright © 2016 George Kye. All rights reserved.
//

import UIKit
import Kingfisher

class EmbeedCollectionViewCell: UICollectionViewCell{  
  @IBOutlet var scrollableCell: EmbeddedCollectionView!
}

class HeaderCell: UICollectionReusableView{
  
  @IBOutlet var title: UILabel!
  @IBOutlet var button: UIButton!
  
}


class EmbeddedCell: UICollectionViewCell {
  
//  @IBOutlet var genreLabel: UIButton!
  @IBOutlet weak var image: UIImageView!
  @IBOutlet weak var title: UILabel!
  
  var dataSource: EmbeddedData!{
    didSet{
      setCell()
    }
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func prepareForReuse() {
    image.image = nil
  }
  
  func setCell(){
    title.text = dataSource.title
    if let url = dataSource.imageURL{
      let u = URL(string: url.createImageURL())
      image.kf.setImage(with: u!)
    }
  }
  
}
