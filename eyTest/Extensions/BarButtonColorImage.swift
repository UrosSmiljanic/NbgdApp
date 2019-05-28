//
//  BarButtonColorImage.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 13/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

extension UIBarButtonItem {
    class func itemWith(colorfulImage: UIImage?, target: AnyObject, action: Selector?) -> UIBarButtonItem {
        let button = UIButton(type: .custom)
        button.isUserInteractionEnabled = true
        button.setImage(colorfulImage, for: .normal)
        button.frame = CGRect(x: 0.0, y: 0.0, width: 50.0, height: 50.0)
        
        button.addTarget(target, action: #selector(BaseViewController.handleHomeButton), for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}
