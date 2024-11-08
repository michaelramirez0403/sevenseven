//
//  ViewController.swift
//  SwiftPass
//
//  Created by Macky Ramirez on 11/5/24.
//
import UIKit
import SnapKit
class LoginView: BaseViewController {
    let viewModel = LoginViewModel()
    lazy var logoImageView = PPAvatarImageView(frame: .zero)
    let signInLabel = PPTitleLabel(textAlignment: .left, fontSize: 24)
    let emailTextField = PPTextField()
    let passwordTextField = PPTextField()
    let signUpButton = PPButton(backgroundColor: .systemOrange,
                                title: TitleLabel.signInButton)
    let forgotButton = PPButton(backgroundColor: .clear,
                                title: TitleLabel.forgotPasswordButton)
    let connectLabel = PPTitleLabel(textAlignment: .left, fontSize: 17)
    let fIconButton = PPButton(backgroundColor: .clear,
                               imageName: Images.fImage!,
                               title: blank_)
    let gIconButton = PPButton(backgroundColor: .clear,
                               imageName: Images.gImage!,
                               title: blank_)
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray2
        return view
    }()
    lazy var fancyIconView = PPAvatarImageView(frame: .zero)
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
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
        view.addSubviews(logoImageView,
                         signInLabel,
                         emailTextField,
                         passwordTextField,
                         signUpButton,
                         forgotButton,
                         connectLabel,
                         lineView,
                         fancyIconView,
                         fIconButton,
                         gIconButton)
        customViews()
    }
    override func makeConstrainst() {
        let padding = 30
        let height = 50
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(120)
            make.centerX.equalTo(view.snp.centerX)
            make.width.height.equalTo(200)
        }
        signInLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(18)
            make.leading.equalTo(view.snp.leading).offset(padding)
            make.height.equalTo(28)
        }
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(signInLabel.snp.bottom).offset(18)
            make.leading.equalTo(view.snp.leading).offset(padding)
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.height.equalTo(height)
        }
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(emailTextField.snp.bottom).offset(18)
            make.leading.equalTo(view.snp.leading).offset(padding)
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.height.equalTo(height)
        }
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(18)
            make.leading.equalTo(view.snp.leading).offset(padding)
            make.trailing.equalTo(view.snp.trailing).offset(-padding)
            make.height.equalTo(height)
        }
        forgotButton.snp.makeConstraints { make in
            make.top.equalTo(signUpButton.snp.bottom).offset(8)
            make.trailing.equalTo(signUpButton.snp.trailing)
            make.width.equalTo(180)
            make.height.equalTo(35)
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
        viewModel.delegate = self
        createNavigationBackButton()
        logoImageView.image = Images.burgerImage
        fancyIconView.image = Images.fancyImage
        signInLabel.text = TitleLabel.signIn
        emailTextField.placeholder = TitleLabel.username
        emailTextField.tag = 1
        passwordTextField.placeholder = TitleLabel.password
        passwordTextField.tag = 2
        connectLabel.text = TitleLabel.connectWith
        gIconButton.addTarget(self,
                              action: #selector(notAvailableButtonTapped),
                              for: .touchUpInside)
        fIconButton.addTarget(self,
                              action: #selector(notAvailableButtonTapped),
                              for: .touchUpInside)
        signUpButton.addTarget(self,
                               action: #selector(signInAction),
                               for: .touchUpInside)
        forgotButton.addTarget(self,
                               action: #selector(notAvailableButtonTapped),
                               for: .touchUpInside)
        forgotButton.setTitleColor(.systemGray, for: .normal)
        emailTextField.delegate = self
        passwordTextField.delegate = self
    }
    @objc func notAvailableButtonTapped(){
        print("Clicked RegisterViewController")
        DispatchQueue.main.async {
            self.presentGFAlertOnMainThread(title: TitleLabel.title,
                                            message: TitleLabel.notAvailable,
                                            buttonTitle: TitleLabel.ok)
        }
    }
    @objc func signInAction() {
        guard viewModel.isUsernameEntered else {
            DispatchQueue.main.async {
                self.presentGFAlertOnMainThread(title: TitleLabel.title,
                                                message: TitleLabel.enterUserName,
                                                buttonTitle: TitleLabel.ok)
            }
            return
        }
        guard viewModel.isPasswordEntered else {
            DispatchQueue.main.async {
                self.presentGFAlertOnMainThread(title: TitleLabel.title,
                                                message: TitleLabel.enterPassword,
                                                buttonTitle: TitleLabel.ok)
            }
            return
        }
        viewModel.login()
    }
    func pushToHomeView() {
        let homeVC = HomeView()
        self.navigationController?.pushViewController(homeVC, animated: true)
    }
}
extension LoginView: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        switch UIDevice.current.screenType {
        case .iPhone5:
            print("iPhone 5, iPod Touch")
            if textField.tag == 1 ||
                textField.tag == 2 {
                adjustTextfield()
            }
        default:
            break
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        switch textField.tag {
        case 1:
            if let first = textField.text {
                guard let toDoRange = Range(range,
                                            in: first) else { return false }
                let toDoText = first.replacingCharacters(in: toDoRange,
                                                         with: string)
                viewModel.usernameText = toDoText
                print("\(toDoText)")
            }
            return stopText(range,
                            string,
                            emailTextField,
                            stop: 100)
            
        case 2:
            if let password = passwordTextField.text {
                guard let toDoRange = Range(range,
                                            in: password) else { return false }
                let toDoText = password.replacingCharacters(in: toDoRange,
                                                            with: string)
                viewModel.passwordText = toDoText
                print("\(toDoText)")
            }
            return stopText(range,
                            string,
                            passwordTextField,
                            stop: 225)
        default: break
        }
        return true
    }
}
extension LoginView: BaseViewModelDelegate {
    func loading() { showLoadingView() }
    func dismiss() { dismissLoadingView() }
    func didRequestSuccess(_ msg: String) {
        //
        print("Success Login")
        dismiss()
        // PUSH to another viewcontroller
        DispatchQueue.main.async {
            self.pushToHomeView()
            self.emailTextField.text = blank_
            self.passwordTextField.text = blank_
            self.view.endEditing(true)
        }
    }
    func didRequestFailed(_ error: String) {
        DispatchQueue.main.async {
            self.presentGFAlertOnMainThread(title: TitleLabel.error,
                                            message: error,
                                            buttonTitle: TitleLabel.ok)
        }
    }
}
