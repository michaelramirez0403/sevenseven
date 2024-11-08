//
//  PPAvatarImageView.swift
//  
//
//  Created by Michael Ramirez on 9/30/24.
//

import UIKit
class PPAvatarImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureRegular()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureRegular() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        clipsToBounds = true
        contentMode = .scaleAspectFit
    }
    func configureCircular() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.borderWidth = 2.0
        layer.masksToBounds = false
        layer.borderColor = UIColor.white.cgColor
        layer.cornerRadius = self.frame.height / 2
        clipsToBounds = true
        contentMode = .scaleAspectFit
    }
}
