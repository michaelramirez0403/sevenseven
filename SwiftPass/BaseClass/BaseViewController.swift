//
//  BaseViewController.swift
//  SwiftPass
//
//  Created by Michael Ramirez on 11/5/24.
//
import UIKit
class BaseViewController: UIViewController {
    var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.systemBackground]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        view.backgroundColor = CustomColor.backgroundColor
        createDismissKeyboardTapGesture()
    }
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view,
                                         action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    func configureUI() { }
    func makeConstrainst() { }
    func push() { }
    // MARK: - Navigation Function
    func createNavigationBackButton() {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 24,
                                                      weight: .bold,
                                                      scale: .medium)
        let backButton = UIBarButtonItem(image: UIImage(systemName: TitleLabel.backArrow,
                                                           withConfiguration: largeConfig),
                                                  style: .done,
                                                  target: self,
                                                  action: #selector(backAction))
        backButton.tintColor = UIColor.systemOrange
        self.navigationItem.leftBarButtonItem = backButton
    }
    @objc func backAction(){
        self.navigationController?.popViewController(animated: true)
    }
    // MARK: - Loading View
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView.addSubview(activityIndicator)
        activityIndicator.color = .systemOrange
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.snp.makeConstraints { make in
            make.centerX.equalTo(containerView.snp.centerX)
            make.centerY.equalTo(containerView.snp.centerY)
        }
        activityIndicator.startAnimating()
    }
    func dismissLoadingView() {
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    // MARK: - View frame
    func adjustToOriginalFrame() {
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.view.frame.origin.y = 0 // Move view to original position
                       })
    }
    func adjustTextfield() {
        UIView.animate(withDuration: 0.25,
                       delay: 0,
                       options: .curveEaseIn,
                       animations: {
                        self.view.frame.origin.y = -150 // Move view 150 points upward
                       })
    }
    //
    func inRangeString(_ range: NSRange,
                       in textfield: String,
                       replacementString string: String,
                       index: Int) {
        guard let toDoRange = Range(range,
                                    in: textfield) else { return }
        let _ = textfield.replacingCharacters(in: toDoRange,
                                              with: string)
    }
    func stopText(_ range: NSRange,
                  _ string: String,
                  _ textfield: UITextField,
                  stop: Int) -> Bool {
        // Stop text in 25 characters
        guard let text = textfield.text,
              let rangeOfTextToReplace = Range(range,
                                               in: text) else {
                  return false
              }
        let substringToReplace = text[rangeOfTextToReplace]
        let count = text.count - substringToReplace.count + string.count
        return count <= stop
    }
}
