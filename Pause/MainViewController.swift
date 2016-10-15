//
//  MainViewController.swift
//  Pause
//
//  Created by George Kye on 2016-10-08.
//  Copyright © 2016 George Kye. All rights reserved.
//

import UIKit
import TMDBSwift
import XLActionController
import Kingfisher


enum DataType{
  case nowplaying, upcoming, popular, toprated
}

class MainViewController: UICollectionViewController {
  
  var data = [MovieMDB]()
  var dataType: DataType = .nowplaying
  var page: Int = 1
  @IBOutlet var sortBtn: UIBarButtonItem!
  
  typealias MenuOptions = (title: String, img: UIImage, option: DataType)
  var menuData: [MenuOptions] = [
    MenuOptions("Upcoming", #imageLiteral(resourceName: "upcoming"), .upcoming),
    MenuOptions("Now Playing", #imageLiteral(resourceName: "nowplaying"), .nowplaying),
    MenuOptions("Popular", #imageLiteral(resourceName: "popular"), .popular),
    MenuOptions("Top Rated", #imageLiteral(resourceName: "topRated"), .toprated)
  ]
  
  var selectedOption:MenuOptions!
  
  var transitionController: TransitionController = TransitionController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let mosaicLayout = TRMosaicLayout()
    self.collectionView?.collectionViewLayout = mosaicLayout
    mosaicLayout.delegate = self
    selectedOption = menuData[1]
    loadData()
  }
  
  override func viewDidAppear(_ animated: Bool) {
    navigationController?.navigationBar.unsetTransNavBar()
  }
  
  //MARK: Sorting menu
  @IBAction func createMenu(){
    let actionController = YoutubeActionController()
    
    for i in 0..<menuData.count{
      let item = menuData[i]
      actionController.addAction(Action(ActionData(title: item.title, image: item.img), style: .default, handler: { action in
        self.selectedOption = self.menuData[i]
        self.title = self.selectedOption.title
        self.dataType = self.selectedOption.option
        self.page = 1
        self.data.removeAll()
        self.collectionView?.reloadData()
        self.loadData()
      }))
    }
    present(actionController, animated: true, completion: nil)
  }
  
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return data.count
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return 1
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "main", for: indexPath) as! MovieCell
    
    cell.title.text = data[indexPath.row].title
    cell.darkView.isHidden = false
    if let url = data[indexPath.row].poster_path{
      let u = url.createImageURL()
      cell.imageV.kf.setImage(with: URL(string: u)!)
      cell.title.text = ""
      cell.darkView.isHidden = true
    }
    return cell
  }
}

extension MainViewController{
  
  override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
    vc.data = data[indexPath.row]
    self.navigationController?.pushViewController(vc, animated: true)
  }

}

extension MainViewController: UICollectionViewDataSourcePrefetching{
  func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
    var urls = [URL]()
    for i in indexPaths{
      if let u = data[i.row].poster_path{
        urls.append(URL(string: u.createImageURL())!)
      }
    }
    ImagePrefetcher(urls: urls).start()
  }
}

extension MainViewController: TRMosaicLayoutDelegate {
  
  func collectionView(_ collectionView:UICollectionView, mosaicCellSizeTypeAtIndexPath indexPath:IndexPath) -> TRMosaicCellType {
    return indexPath.item % 3 == 0 ? TRMosaicCellType.big : TRMosaicCellType.small
  }
  
  func collectionView(_ collectionView:UICollectionView, layout collectionViewLayout: TRMosaicLayout, insetAtSection:Int) -> UIEdgeInsets {
    return UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
  }
  
  func heightForSmallMosaicCell() -> CGFloat {
    return 170
  }
}

extension MainViewController{
  
  func appendData(movies: [MovieMDB]){
    if page == 1{
      data.removeAll()
    }
    movies.forEach{
      let mv = $0.id
      let contains = data.contains(where: {
        return $0.id == mv
      })
      
      if contains == false{
        data.append($0)
      }
    }
    self.title = selectedOption.title
    sortBtn.isEnabled = true
    collectionView?.reloadData()
  }
  
  func loadData(){
    sortBtn.isEnabled = false
    switch dataType{
    case .nowplaying:
      MovieMDB.nowplaying(key, page: page){
        if let np = $0.1{
          self.appendData(movies: np)
        }
      }
    case .toprated:
      MovieMDB.toprated(key, page: page){
        if let tr = $0.1{
          self.appendData(movies: tr)
        }
      }
    case .upcoming:
      MovieMDB.upcoming(key, page: page){
        if let up = $0.1{
          self.appendData(movies: up)
        }
      }
    case .popular:
      MovieMDB.popular(key, page: page){
        if let p = $0.1{
          self.appendData(movies: p)
        }
      }
    }
  }
  
}

extension MainViewController: UICollectionViewDelegateFlowLayout{
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: collectionView.bounds.width / 2, height: 250)
  }
  
  override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
    if indexPath.row == data.count - 5{
      print("loading more")
      page += 1
      loadData()
    }
  }
}
