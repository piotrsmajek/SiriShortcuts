//
//  DefaultTextField.swift
//  SiriShotcutDemo
//
//  Created by Piotr Smajek on 05/04/2019.
//  Copyright © 2019 Miquido. All rights reserved.
//

import Foundation
import UIKit

class DefaultTextField: UITextField {
    
    override func caretRect(for position: UITextPosition) -> CGRect {
        return super.caretRect(for: endOfDocument)
    }
    
    override func selectionRects(for range: UITextRange) -> [UITextSelectionRect] {
        return []
    }
    
    override func canPerformAction(_ action: Selector,
                                   withSender sender: Any?) -> Bool {
        return false
    }
    
}
