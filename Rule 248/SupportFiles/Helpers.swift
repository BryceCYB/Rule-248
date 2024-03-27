//
//  Helpers.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

/// Get UIColor from RGB in hex
/// - Parameter rgbValue: takes input in the form of a hex color code
/// - Returns: UIColor
func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
