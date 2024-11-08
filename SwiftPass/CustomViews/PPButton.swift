//
//  PPButton.swift
//
//  Created by Michael Ramirez on 9/30/24.
//
import UIKit
class PPButton: UIButton {
    // MARK: Needed the frame and coder to load programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    init(backgroundColor: UIColor, 
         title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        layer.cornerRadius = 10
        configure()
    }
    init(backgroundColor: UIColor, imageSystemName: String, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        setImage(UIImage(systemName: imageSystemName), for: .normal)
        imageEdgeInsets.left = 10
        titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 22.0, bottom: 0.0, right: 0.0)
        contentHorizontalAlignment = .left
        configure()
    }
    init(backgroundColor: UIColor, imageName: UIImage, title: String) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
        setImage(imageName.withRenderingMode(.alwaysOriginal), for: .normal)
        configure()
    }
    private func configure() {
        setTitleColor(.white, for: .normal)
        setTitleColor(.systemGray, for: .highlighted)
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
        tintColor = .white
    }
    func setRaduis(roundingCorner1: UIRectCorner, roundingCorner2: UIRectCorner) {
        let path = UIBezierPath(roundedRect:self.bounds,
                                byRoundingCorners: [roundingCorner1, roundingCorner2],
                                cornerRadii: CGSize(width: 20, height:  20))

        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        layer.mask = maskLayer
    }
}
