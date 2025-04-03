//
//  PPTextField.swift
//
//
//  Created by Michael Ramirez on 9/30/24.
//

import UIKit
class PPTextField: UITextField, UITextFieldDelegate {
    let paddingWidth: CGFloat = 14 // Indent width
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius          = 10
        layer.borderWidth           = 1
        layer.borderColor           = UIColor.systemGray4.cgColor
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .left
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        returnKeyType               = .done
        clearButtonMode             = .whileEditing
        keyboardType                = .asciiCapable
        tintColor                   = .systemBlue
        isUserInteractionEnabled    = true
        delegate                    = self
        addPadding()
        
    }
    private func addPadding() {
        let paddingView = UIView(frame: CGRect(x: 0,
                                               y: 0,
                                               width: paddingWidth,
                                               height: frame.height))
        leftView = paddingView
        leftViewMode = .always
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        let newText = (textField.text as NSString?)?.replacingCharacters(in: range, with: string) ?? string
        
        if newText.isEmpty {
            addPadding() // Re-add padding when text is empty
        } else if leftView != nil {
            leftView = nil // Remove padding after first character
            leftViewMode = .never
        }
    
        return true
    }
}
