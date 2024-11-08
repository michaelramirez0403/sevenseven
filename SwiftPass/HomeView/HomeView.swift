//
//  HomeView.swift
//  SwiftPass
//
//  Created by Macky Ramirez on 11/8/24.
//

import UIKit
import SnapKit
class HomeView: BaseViewController {
    let welcomeLabel = PPTitleLabel(textAlignment: .left, fontSize: 34)
    let descLabel = PPSecondaryTitleLabel(fontSize: 17)
    lazy var logoImageView = PPAvatarImageView(frame: .zero)
    let logOutButton = PPButton(backgroundColor: .systemOrange,
                                title: TitleLabel.logOutButton)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        logoImageView.configureRegular()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        makeConstrainst()
    }
    override func configureUI() {
        super.configureUI()
        view.addSubviews(welcomeLabel,
                         logoImageView,
                         descLabel,
                         logOutButton)
        customViews()
    }
    override func makeConstrainst() {
        let padding = 30
        let height = 50
        welcomeLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(130)
            make.leading.equalTo(view.snp.leading).offset(padding)
            make.height.equalTo(28)
        }
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(padding)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(300)
        }
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(padding)
            make.leading.equalTo(view.snp.leading).offset(padding)
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.height.equalTo(20)
        }
        logOutButton.snp.makeConstraints { make in
            make.top.equalTo(view.snp.bottom).offset(-120)
            make.leading.equalTo(view.snp.leading).offset(padding)
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.height.equalTo(height)
        }
    }
    func customViews() {
        welcomeLabel.text = TitleLabel.welcome
        descLabel.text = TitleLabel.foodDescription
        logoImageView.image = Images.fancyImage
        logOutButton.addTarget(self,
                               action: #selector(logOutAction),
                               for: .touchUpInside)
    }
    @objc func logOutAction() {
        backAction()
    }
}
