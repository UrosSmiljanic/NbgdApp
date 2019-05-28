//
//  LeftPadding.swift
//   EY Tax Serbia
//
//  Created by Uros Smiljanic on 26/02/2019.
//  Copyright © 2019 Uros Smiljanic. All rights reserved.
//

import UIKit

public class LeftPaddedTextField: UITextField {
    public override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }

    public override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + 10, y: bounds.origin.y, width: bounds.width + 10, height: bounds.height)
    }
}
