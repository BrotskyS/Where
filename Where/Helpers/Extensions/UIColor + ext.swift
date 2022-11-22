//
//  UIColor + ext.swift
//  Where
//
//  Created by Sergiy Brotsky on 03.11.2022.
//

import Foundation
import UIKit

extension UIColor {
  struct theme {
      static var background: UIColor  { return UIColor(named: "Background") ?? UIColor.systemBackground }
      static var secondary: UIColor { return UIColor(named: "Secondary") ?? UIColor.secondarySystemFill }
  }
}
