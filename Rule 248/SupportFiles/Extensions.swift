//
//  Extensions.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

extension UIView {
    /// add multiple subviews at once
    func addSubviews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
}
