//
//  LandingView.swift
//  SwiftPass
//
//  Created by Macky Ramirez on 11/6/24.
//
import UIKit
import SnapKit
class LandingView: BaseViewController {
    lazy var logoImageView = PPAvatarImageView(frame: .zero)
    lazy var fancyIconView = PPAvatarImageView(frame: .zero)
    let fIconButton = PPButton(backgroundColor: .clear,
                               imageName: Images.fImage!,
                               title: blank_)
    let gIconButton = PPButton(backgroundColor: .clear,
                               imageName: Images.gImage!,
                               title: blank_)
    let connectLabel = PPTitleLabel(textAlignment: .left, fontSize: 17)
    let signInButton = PPButton(backgroundColor: .systemOrange,
                                title: TitleLabel.signInButton)
    let signUpButton = PPButton(backgroundColor: .systemGray3,
                                title: TitleLabel.signUpButton)
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        makeConstrainst()
    }
    override func configureUI() {
        super.configureUI()
        view.addSubviews(logoImageView,
                         signInButton,
                         signUpButton,
                         lineView,
                         connectLabel,
                         fancyIconView,
                         fIconButton,
                         gIconButton)
        customViews()
    }
    override func makeConstrainst() {
        super.makeConstrainst()
        let padding = 30
        let height = 50
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(120)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(300)
        }
        signInButton.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(60)
            make.leading.equalTo(view.snp.leading).offset(padding)
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.height.equalTo(height)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(signInButton.snp.bottom).offset(20)
            make.leading.equalTo(view.snp.leading).offset(padding)
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.height.equalTo(height)
        }
        fancyIconView.snp.makeConstraints { make in
            make.bottom.equalTo(view.snp.bottom).offset(-10)
            make.centerX.equalTo(view.snp.centerX).offset(-125)
            make.width.equalTo(282)
            make.height.equalTo(150)
        }
        connectLabel.snp.makeConstraints { make in
            make.bottom.equalTo(fancyIconView.snp.top).offset(-20)
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.height.equalTo(20)
        }
        lineView.snp.makeConstraints { make in
            make.centerY.equalTo(connectLabel.snp.centerY)
            make.trailing.equalTo(connectLabel.snp.leading).offset(-10)
            make.leading.equalTo(view.snp.leading)
            make.height.equalTo(2)
        }
        fIconButton.snp.makeConstraints { make in
            make.top.equalTo(connectLabel.snp.bottom).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.width.height.equalTo(40)
        }
        gIconButton.snp.makeConstraints { make in
            make.centerY.equalTo(fIconButton.snp.centerY)
            make.trailing.equalTo(fIconButton.snp.leading).offset(-10)
            make.width.height.equalTo(40)
        }
    }
    func customViews() {
        logoImageView.image = Images.burgerImage
        fancyIconView.image = Images.fancyImage
        connectLabel.text = TitleLabel.connectWith
        signInButton.addTarget(self,
                               action: #selector(signInButtonTapped),
                               for: .touchUpInside)
        signUpButton.addTarget(self,
                               action: #selector(signUpButtonTapped),
                               for: .touchUpInside)
        gIconButton.addTarget(self,
                               action: #selector(notAvailableButtonTapped),
                               for: .touchUpInside)
        fIconButton.addTarget(self,
                               action: #selector(notAvailableButtonTapped),
                               for: .touchUpInside)
    }
    @objc func signInButtonTapped(){
        print("Clicked LoginViewController")
        let signInVC = LoginView()
        navigationController?.pushViewController(signInVC, animated: true)
    }
    @objc func signUpButtonTapped(){
        print("Clicked RegisterViewController")
        let signUpVC = RegisterView()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    @objc func notAvailableButtonTapped(){
        print("Clicked RegisterViewController")
        DispatchQueue.main.async {
            self.presentGFAlertOnMainThread(title: TitleLabel.title,
                                            message: TitleLabel.notAvailable,
                                            buttonTitle: TitleLabel.ok)
        }
    }
}
