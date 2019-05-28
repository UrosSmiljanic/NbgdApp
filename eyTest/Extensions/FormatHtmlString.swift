//
//  FormatHtmlString.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 13/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

func formatHtmlString(htmlString: String) -> NSAttributedString {
    let data = htmlString.data(using: String.Encoding.unicode)!
    let attrStr = try? NSAttributedString(
        data: data,
        options: [NSAttributedString.DocumentReadingOptionKey.documentType: NSAttributedString.DocumentType.html],
        documentAttributes: nil)
    
    let attriString = NSAttributedString(string: (attrStr?.string)!, attributes:
        [NSAttributedString.Key.foregroundColor: UIColor.black,
         NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 15)!])
    return attriString
}
