//
//  Constant.swift
//  Rule 248
//
//  Created by Bryce Chan on 7/11/2023.
//

import UIKit

enum Constants {
    // MARK: - Constraints
    static let segmentedControlHeight: CGFloat = 110
    static let underlineViewHeight: CGFloat = 2
    static let inputBoxCornerRadius: CGFloat = 10
    static let numberBoxWidth: CGFloat = 80
    static let numberBoxHeight: CGFloat = 40
    static let buttonHeight: CGFloat = 45
    
    // MARK: - Colors
    static let underlineViewColor: UIColor = .white
    static let backgroundGreen = UIColorFromRGB(rgbValue: 0x35C759)
    static let backgroundRed = UIColorFromRGB(rgbValue: 0xF78484)
    static let buttonGray = UIColorFromRGB(rgbValue: 0x8E8E93)
    static let buttonGreen = UIColorFromRGB(rgbValue: 0x35C759)
    
    // MARK: - Texts
    static let introductionText = "We've chosen a rule that some sequences of three numbers obey - and some do not. Your job is to guess what the rule is."
    
    static let ruleText = "We'll start by telling you that the sequence 2, 4, 8 obeys the rule:"
    
    static let startText = "Now it's your turn. Enter a number sequence in the boxes in next tab, and we'll tell you whether it satisfies the rule or not. You can test as many sequences as you want."
    
    static let resultText = "When you think you know the rule, describe it in words below and then submit your answer. "
    
    static let resultBoldText = "Make sure you're right; you won't get a second chance."
    
    static let guessNumMaxLength: Int = 6
}
