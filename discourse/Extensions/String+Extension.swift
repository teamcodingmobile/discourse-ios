//
//  String+Extension.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 14/11/2020.
//

import Foundation

extension String {
  func toDate(withFormat format: String = "yyyy-MM-dd") -> Date {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    guard let date = dateFormatter.date(from: self) else {
      preconditionFailure("Take a look to your format")
    }
    return date
  }
}
