//
//  RoundImageExt.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 14/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func roundedImage() {
        self.layer.cornerRadius = self.frame.size.width / 2
        self.clipsToBounds = true
    }
    
}
