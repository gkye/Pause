//
//  StickyHeader.swift
//  Pause
//
//  Created by George Kye on 2016-10-14.
//  Copyright © 2016 George Kye. All rights reserved.
//

import Foundation
import UIKit


protocol StickyHeader {
  
  var kTableHeaderHeight: CGFloat{ get set}
  var headerView: UIView {get set }
}


//extension UITableViewController: StickyHeader{
//  internal var headerView: UIView {
//    get {
//      return self.headerView
//    }
//    set {
//      self.headerView = UIView()
//    }
//  }
//  
//  internal var kTableHeaderHeight: CGFloat{
//    get {
//      return self.kTableHeaderHeight
//    }
//    set {
//      self.kTableHeaderHeight = 310
//    }
//  }
//  
//  func setStickyHeader(){
//    headerView = tableView.tableHeaderView!
//    tableView.tableHeaderView = nil
//    tableView.addSubview(headerView)
//    tableView.contentInset = UIEdgeInsets(top: kTableHeaderHeight, left: 0, bottom: 0, right: 0)
//    tableView.contentOffset = CGPoint(x: 0, y: -kTableHeaderHeight)
//  }
//  
//  func updateHeaderView(){
//    var headerRect = CGRect(x: 0, y: -kTableHeaderHeight, width: tableView.bounds.width, height: kTableHeaderHeight)
//    if tableView.contentOffset.y < -kTableHeaderHeight{
//      headerRect.origin.y = tableView.contentOffset.y
//      headerRect.size.height = -tableView.contentOffset.y
//    }
//    headerView.frame = headerRect
//  }
//  
//  
//}
