//
//  EditableTextView.swift
//  discourse
//
//  Created by Gerardo Rico Botella on 10/11/2020.
//

import UIKit

@IBDesignable
class TextInput: UIView {

    @IBOutlet var containerView: UIView!
    @IBOutlet weak var textView: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    
    @IBInspectable var placeholder: String? {
        get {
            return textView.placeholder
        }
        set(placeholder) {
            textView.placeholder = placeholder
        }
    }
    
    var textContentType: UITextContentType {
        get {
            return textView.textContentType
        }
        set(textContentType) {
            textView.textContentType = textContentType
        }
    }
    
    var keyboardType: UIKeyboardType {
        get {
            return textView.keyboardType
        }
        set(keyboardType) {
            textView.keyboardType = keyboardType
        }
    }
    
    var returnKeyType: UIReturnKeyType {
        get {
            return textView.returnKeyType
        }
        set(returnKeyType) {
            textView.returnKeyType = returnKeyType
        }
    }
    
    var value: String? {
        get {
            return textView.text
        }
    }
    
    var error: String? {
        get {
            return errorLabel.text
        }
        set(error) {
            errorLabel.text = error
        }
    }
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            initNib()
        }

        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            initNib()
        }

    func initNib() {
        let bundle = Bundle(for: TextInput.self)
        bundle.loadNibNamed("TextInput", owner: self, options: nil)
        addSubview(containerView)
        containerView.frame = bounds
        containerView.autoresizingMask = [.flexibleWidth]
    }
    
    override func becomeFirstResponder() -> Bool {
        return textView.becomeFirstResponder()
    }
}
