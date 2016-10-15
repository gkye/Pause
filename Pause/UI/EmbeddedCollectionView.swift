//
//  EmbeddedCollectionView.swift
//  Pause
//
//  Created by George Kye on 2016-10-08.
//  Copyright © 2016 George Kye. All rights reserved.
//

import Foundation
import UIKit


enum CellType{
  case main, cast, image
}

protocol EmbeddedCollectionViewDelegate: class{
  
  func didSelect(view: EmbeddedCollectionView, index: Int, section: Int)
}

class EmbeddedCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
  
  open var dataSource = [EmbeddedData](){
    didSet{
      collectionView.reloadData()
    }
  }
  
  open var delegate: EmbeddedCollectionViewDelegate?
  
  open var selectedBorderWidth: CGFloat = 2
  /// Set spacing between cells
  open var cellSpacing: CGFloat = 2
  
  open var cellWidth: CGFloat = 2.5{
    didSet{ collectionView.reloadData() }
  }
  
  open var cellType: CellType = .main{
    didSet{ collectionView.reloadData() }
  }
  
  //Setup collectionview and flow layout
  lazy var collectionView: UICollectionView = {
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//    layout.itemSize = CGSize(width: (self.bounds.width / 5) - 1, height: self.bounds.height - 1)
    layout.minimumInteritemSpacing = 1
    layout.minimumLineSpacing = 1
    layout.scrollDirection = .horizontal
    let collectionView = UICollectionView(frame: self.frame, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.delegate = self
//    collectionView.register(EmbeddedCell.self, forCellWithReuseIdentifier: "cell")
    collectionView.register(UINib(nibName: "EmbeddedCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    collectionView.register(UINib(nibName: "ImageAndTextCell", bundle: nil), forCellWithReuseIdentifier: "imageCell")
    collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "basic")


    collectionView.backgroundColor = UIColor.clear
    collectionView.showsVerticalScrollIndicator = false
    collectionView.showsHorizontalScrollIndicator = false
    return collectionView
  }()
  
  open override func layoutSubviews() {
    super.layoutSubviews()
    initialize()
    addContrains(self, subView: collectionView)
  }
  
  fileprivate func initialize() {
    collectionView.removeFromSuperview()
    self.addSubview(self.collectionView)
  }
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return dataSource.count
  }
  
  open func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    switch cellType {
    case .main:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! EmbeddedCell
      cell.dataSource = dataSource[indexPath.row]
      return cell
      
    case .image:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageAndTextCell
      cell.type = cellType
      cell.imgHeight.constant = cell.bounds.height - 1
      cell.dataSource = dataSource[indexPath.row]
      return cell
      
    default:
      let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as! ImageAndTextCell
      cell.type = cellType
      cell.dataSource = dataSource[indexPath.row]
      return cell
    }  
  }
  
  fileprivate func addContrains(_ superView: UIView, subView: UIView){
    subView.translatesAutoresizingMaskIntoConstraints = false
    let views = ["myView" : subView]
    superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[myView]|", options:[] , metrics: nil, views: views))
    superView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[myView]|", options:[] , metrics: nil, views: views))
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: (collectionView.bounds.width / cellWidth) - cellSpacing, height: collectionView.bounds.height - 1)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    delegate?.didSelect(view: self, index: indexPath.row, section: self.tag)
  }
}
