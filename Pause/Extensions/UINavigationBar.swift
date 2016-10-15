//
//  UINavigationBar.swift
//  Pause
//
//  Created by George Kye on 2016-10-09.
//  Copyright © 2016 George Kye. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar{
  
  func setTransNavBar(){
    self.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
    self.shadowImage = UIImage()
    self.isTranslucent = true
  }
  
  func unsetTransNavBar(){
    self.setBackgroundImage(nil, for: UIBarMetrics.default)
    self.shadowImage = nil
    self.tintColor = nil
    self.isTranslucent = false
  }
}
