//
//  ExtractURL.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 21/03/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import Foundation

extension String {
    func extractURLs() -> [URL] {
        var urls : [URL] = []
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
            detector.enumerateMatches(in: self, options: [], range: NSMakeRange(0, self.count), using: { (result, _, _) in
                if let match = result, let url = match.url {
                    urls.append(url)
                }
            })
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return urls
    }
}

