//
//  ImageAndTextCell.swift
//  Pause
//
//  Created by George Kye on 2016-10-09.
//  Copyright © 2016 George Kye. All rights reserved.
//

import UIKit


class MovieCell: UICollectionViewCell{
  
  @IBOutlet var title: UILabel!
  @IBOutlet var imageV: UIImageView!
  @IBOutlet var darkView: UIView!

  override func prepareForReuse() {
    imageV.image = nil
  }
}

class ImageAndTextTableCell: UITableViewCell{
  @IBOutlet var scrollableCell: EmbeddedCollectionView!
}

class TBHeaderCell: UITableViewCell{
  @IBOutlet var headerLbl: UILabel!
  @IBOutlet var btnImg: UIButton!
  
}

class ImageAndTextCell: UICollectionViewCell {

  @IBOutlet var image: UIImageView!
  @IBOutlet var title: UILabel!
  @IBOutlet var subtitle: UILabel!
  @IBOutlet weak var imgHeight: NSLayoutConstraint!
  var type: CellType! = .cast
  
  override func prepareForReuse() {
    image.image = #imageLiteral(resourceName: "image")
  }
  
  var dataSource: EmbeddedData!{
    didSet{
      updateUI()
    }
  }
  
  func updateUI(){
    if let sub = dataSource.subtitle{
      subtitle.text = sub
    }else{
      subtitle.text = "N/A"
    }
    if let url = dataSource.imageURL{
      var createdURL = ""
      
      if type == .image{
        createdURL = url.createImageURL()
      }else{
        createdURL = url.createImageURL(size: 300)
      }
      let u = URL(string: createdURL)
      image.kf.setImage(with: u!)
    }
    title.text = dataSource.title
  }
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
  }

}
