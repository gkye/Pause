//
//  MovieDetailViewController.swift
//  Pause
//
//  Created by George Kye on 2016-10-08.
//  Copyright © 2016 George Kye. All rights reserved.
//

import UIKit
import TMDBSwift

class MovieDetailViewController: UITableViewController {
  
  var data: MovieMDB!
  var credits: MovieCreditsMDB?
  var cast: [MovieCastMDB]?
  var crew: [CrewMDB]?
  var images: [Images_MDB]!
  var recommended: [MovieMDB]!
  
  //EmebeddedData
  var imagesData = [EmbeddedData]()
  var castData = [EmbeddedData]()
  var crewData = [EmbeddedData]()
  var recommendedData = [EmbeddedData]()
  
  var movieDetails: MovieDetailedMDB?{
    didSet{ updateHeaderUI() }
  }
  
  let sections = ["", "Cast", "Crew"]
  
  fileprivate let kTableHeaderHeight: CGFloat = 300
  var headerView: UIView!
  
  @IBOutlet var backgroundImg: UIImageView!
  @IBOutlet var movieTitle: UILabel!
  @IBOutlet var subTitle: UILabel!
  @IBOutlet var rating: UILabel!
  @IBOutlet var runtime: UILabel!
  @IBOutlet var releaseDate: UILabel!
  
  override func viewDidAppear(_ animated: Bool) {
    updateHeaderUI()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    navigationController?.navigationBar.setTransNavBar()
    self.navigationController?.navigationBar.topItem?.title = "";
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    MovieMDB.movie(key, movieID: data.id){
      if let mv = $0.1{ self.movieDetails = mv}
    }
    
    MovieMDB.credits(key, movieID: data.id){
      if let creds = $0.1{
        self.cast = creds.cast
        self.castData = EmbeddedData.createData(cast: self.cast!)
        self.crew = creds.crew
        self.crewData = EmbeddedData.createData(crew: self.crew!)
        self.tableView.reloadData()
      }
    }
    
    MovieMDB.images(key, movieID: data.id){
      if let imgs = $0.1{
        self.images = imgs.createImagesArray()
        self.imagesData = EmbeddedData.createData(images: self.images)
        self.tableView.reloadData()
      }
    }
    
    MovieMDB.similar(key, movieID: data.id, page: 1){
      if let movs = $0.1{
        self.recommended = movs
        self.recommendedData = EmbeddedData.createData(movie: movs)
        self.tableView.reloadData()
      }
    }
    
    self.tableView.estimatedRowHeight = 44.0 ;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    setStickyHeader()
    
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    switch section {
    case 0:
      return 1
    case 1:
      if imagesData.count > 0 { return 1}else{ return 0}
    case 2:
      if castData.count > 0{ return 2 }else { return 0 }
    case 3:
      if crewData.count > 0{ return 2 }else { return 0 }
    default:
      if recommendedData.count > 0{ return 2 }else { return 0 }
      
    }
  }
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 5
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    switch indexPath.section {
    case 0:
      let cell = tableView.dequeueReusableCell(withIdentifier: "basic", for: indexPath)
      cell.textLabel?.text = data.overview
      return cell

    case 1:
      let cell = tableView.dequeueReusableCell(withIdentifier: "scroller", for: indexPath) as! ImageAndTextTableCell
      cell.scrollableCell.cellWidth = 1.3
      cell.scrollableCell.cellSpacing = 2
      cell.scrollableCell.cellType = .image
      cell.scrollableCell.dataSource = imagesData
      cell.scrollableCell.tag = indexPath.section
      cell.scrollableCell.delegate = self
      return cell
      
    case 2:
      if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! TBHeaderCell
        cell.headerLbl.text = "Cast"
        cell.btnImg.setImage(#imageLiteral(resourceName: "cast"), for: .normal)
        return cell
      }
      let cell = tableView.dequeueReusableCell(withIdentifier: "scroller", for: indexPath) as! ImageAndTextTableCell
      cell.scrollableCell.cellWidth = 2.5
      cell.scrollableCell.cellSpacing = 4
      cell.scrollableCell.cellType = .cast
      if let _ = self.cast{
        cell.scrollableCell.dataSource = castData
      }
      cell.scrollableCell.tag = indexPath.section
      cell.scrollableCell.delegate = self

      return cell
      
    case 3:
      if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! TBHeaderCell
        cell.headerLbl.text = "Crew"
        cell.btnImg.setImage(#imageLiteral(resourceName: "crew"), for: .normal)
        return cell
      }
      let cell = tableView.dequeueReusableCell(withIdentifier: "scroller", for: indexPath) as! ImageAndTextTableCell
      cell.scrollableCell.cellWidth = 2.5
      cell.scrollableCell.cellSpacing = 4
      cell.scrollableCell.cellType = .cast
      if let _ = self.crew{
        cell.scrollableCell.dataSource = crewData
      }
      cell.scrollableCell.tag = indexPath.section
      cell.scrollableCell.delegate = self

      return cell
      
    default:
      if indexPath.row == 0{
        let cell = tableView.dequeueReusableCell(withIdentifier: "header", for: indexPath) as! TBHeaderCell
        cell.headerLbl.text = "Similar Movies"
        cell.btnImg.setImage(#imageLiteral(resourceName: "similar"), for: .normal)
        return cell
      }
      let cell = tableView.dequeueReusableCell(withIdentifier: "scroller", for: indexPath) as! ImageAndTextTableCell
      cell.scrollableCell.cellWidth = 2.5
      cell.scrollableCell.cellSpacing = 4
      cell.scrollableCell.cellType = .main
      if let _ = self.crew{
        cell.scrollableCell.dataSource = recommendedData
      }
      cell.scrollableCell.tag = indexPath.section
      cell.scrollableCell.delegate = self

      return cell
    }
    
  }
  
  override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    switch indexPath.section {
    case 1:
      return 200
    case 2, 3, 4:
      if indexPath.row == 0 { return 40 }
      return 250
    default:
      return UITableViewAutomaticDimension
    }
  }
}

extension MovieDetailViewController: EmbeddedCollectionViewDelegate{
  func didSelect(view: EmbeddedCollectionView, index: Int, section: Int) {
    
    switch view.tag{
    case 1:
      print("show images")
    case 2:
      print("show cast info")
    case 3:
      print("show crew info")
    default:
      print("show movieDetail")
      let vc = storyboard?.instantiateViewController(withIdentifier: "MovieDetailViewController") as! MovieDetailViewController
      vc.data = recommended[index]
      self.navigationController?.pushViewController(vc, animated: true)
    }
  }
}

extension MovieDetailViewController{
  
  func setStickyHeader(){
    headerView = tableView.tableHeaderView
    tableView.tableHeaderView = nil
    tableView.addSubview(headerView)
    tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
    tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
  }
  
  func updateHeaderUI(){
    if let url = data.poster_path{
      backgroundImg.kf.setImage(with: URL(string: url.createImageURL())!)
    }else{
      if let u = data.backdrop_path{
        backgroundImg.kf.setImage(with: URL(string: u.createImageURL())!)
      }
    }
    movieTitle.text = data.title
    if let d = movieDetails{
      guard let tag = d.tagline else{
        subTitle.text = ""
        return
      }
      subTitle.text = tag
      rating.text = d.vote_average?.description
      if let r = d.runtime{
        runtime.text = "\(r) mins"
      }
      if let date = d.release_date{
        releaseDate.text = date
      }
    }
  }
  
  
  func updateHeaderView(){
    var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
    if tableView.contentOffset.y < -kTableHeaderHeight{
      headerRect.origin.y = tableView.contentOffset.y
      headerRect.size.height = -tableView.contentOffset.y
    }
    headerView.frame = headerRect
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    if scrollView.contentOffset.y > -140{
      navigationController?.navigationBar.unsetTransNavBar()
    }else{
      navigationController?.navigationBar.setTransNavBar()
    }
    updateHeaderView()
  }
  
}
