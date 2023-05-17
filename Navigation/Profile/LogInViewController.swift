//
//  LogInViewController.swift
//  Navigation
//
//  Created by Никита on 28.04.2023.
//

import UIKit

class LogInViewController: UIViewController {
    
    var logo: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "logo")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var loginTF: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        textField.layer.borderWidth = 0.5
        textField.placeholder = "E-mail or phone"
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height)) // Добавляем маленькую вьюшку(белый прямоугольник) - для отступа от края textField
        textField.leftViewMode = .always
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.systemGray5
        //textField.tintColor =
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.delegate = self
        return textField
        
    }()
    
    private lazy var passwordTF: UITextField = { [unowned self] in
        let textField = UITextField()
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.cornerRadius = 10
        textField.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        textField.layer.borderWidth = 0.5
        textField.placeholder = "Password"
        /////////////////////////////
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: textField.frame.height)) // Добавляем маленькую вьюшку(белый прямоугольник) - для отступа от края textField
        textField.leftViewMode = .always
        /////////////////////////////
        textField.textColor = .black
        textField.font = .systemFont(ofSize: 16)
        textField.backgroundColor = UIColor.systemGray5
        //textField.tintColor =
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        textField.autocorrectionType = UITextAutocorrectionType.no
        textField.keyboardType = UIKeyboardType.default
        textField.returnKeyType = UIReturnKeyType.done
        textField.clearButtonMode = UITextField.ViewMode.whileEditing
        textField.delegate = self
        return textField
        
    }()
    
    let logInButton: UIButton = {
        
        let button = UIButton()
        
        let alphaImage = UIImage(named: "pixelImage")
        
        button.setTitle("Log in", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 10 // Поправить до нужного радиуса
        
        button.setBackgroundImage(UIImage(named: "pixelImage"), for: .normal)
        button.layer.masksToBounds = true
        //button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Обработка нажатия кнопки
    @objc func buttonPressed() {
        
        let vc = ProfileViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }

    let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .green
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    let contentView: UIView = {
        
        let contentView = UIView()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = .white
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = false
        setupView()
        
        print(#function)
    }
    /////////////////////////////
   /* override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            view.endEditing(false) // Скрывает клавиатуру, вызванную для любого объекта
        }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(#function)
        setupKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print(#function)
        removeKeyboardObservers()
    }
    
    private func setupKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willShowKeyboard(_:)),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        notificationCenter.addObserver(
            self,
            selector: #selector(self.willHideKeyboard(_:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
        let notificationCenter = NotificationCenter.default
        notificationCenter.removeObserver(self)
    }
    
    
    @objc func willShowKeyboard(_ notification: NSNotification) {
        let keyboardHeight = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.height
        let contentInsets: UIEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardHeight ?? 0, right: 0.0)
        //scrollView.contentInset.bottom += keyboardHeight ?? 0
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        print(#function, keyboardHeight)
        

        var aRect: CGRect = self.view.frame

             aRect.size.height -= keyboardHeight ?? 0

            // if !aRect.contains(activeField!.frame.origin) {

               //   self.myScrollView.scrollRectToVisible(activeField!.frame, animated: true)

          //   }
        
    }
    
    @objc func willHideKeyboard(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0
        print(#function)
    }
    
    
    
    /////////////////////////////
    private func setupView() {
        
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(logo)
        
        self.contentView.addSubview(loginTF)
        self.contentView.addSubview(passwordTF)
        self.contentView.addSubview(logInButton)
        self.setupConstraints()
        // Обязательно обозначаем нижние границы contentView
        contentView.subviews.last?.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            //contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor), // Задаем ширину обязательно
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            
            logo.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            logo.heightAnchor.constraint(equalToConstant: 100),
            logo.widthAnchor.constraint(equalToConstant: 100),
            
            loginTF.topAnchor.constraint(equalTo: logo.bottomAnchor, constant: 80),
            loginTF.heightAnchor.constraint(equalToConstant: 50),
            loginTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            passwordTF.topAnchor.constraint(equalTo: loginTF.bottomAnchor, constant: -0.5),
            passwordTF.heightAnchor.constraint(equalToConstant: 50),
            passwordTF.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTF.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            logInButton.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 16),
            logInButton.heightAnchor.constraint(equalToConstant: 50),
            logInButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            logInButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            
        ])
    }
    
}

extension LogInViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(
        _ textField: UITextField
    ) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
