import UIKit

/// Экран с добавлением новой категории
final class AdditionNewCategoryViewController: UIViewController {
    
    // MARK: - Свойства
    let categoryViewModel: CategoryViewModel
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Новая категория"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Готово", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(create), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let enterNameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите название категории"
        field.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
        field.layer.cornerRadius = 16
        field.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        return field
    }()
    
    // MARK: - Методы
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        setupView()
        bind()
    }
    
    init(categoryViewModel: CategoryViewModel) {
        self.categoryViewModel = categoryViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Настройка внешнего вида
    private func setupView() {
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterNameTextField.heightAnchor.constraint(equalToConstant: 71),
            enterNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 24),
            enterNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            createButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            createButton.heightAnchor.constraint(equalToConstant: 60),
            
        ])
        createButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    /// Настройка свойств и жестов
    private func setupProperties() {
        view.addSubview(titleLabel)
        view.addSubview(enterNameTextField)
        view.addSubview(createButton)
        enterNameTextField.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    /// Активация кнопки
    private func activateButton() {
        if enterNameTextField.hasText {
            createButton.backgroundColor = .black
            createButton.isEnabled = true
        }
    }
    
    /// Деактивация кнопки
    private func deactivateButton() {
        if !enterNameTextField.hasText {
            createButton.backgroundColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
            createButton.isEnabled = false
        }
    }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.3) {
                self.createButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height)
            }
        }
    }

    @objc
    private func keyboardWillHide(_ notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.createButton.transform = .identity
        }
    }

    private func bind() {
        categoryViewModel.isCategoryAdded = { result in
            switch result {
            case true: self.dismiss(animated: true)
                let notification = Notification(name: Notification.Name("categories_added"))
                NotificationCenter.default.post(notification)
            case false: AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка добавления категории")
            }
        }
    }
    
    /// Метод, прячущий клавиатуру при нажатии вне её области
    @objc
    private func dismissKeyboard() {
        enterNameTextField.resignFirstResponder()
    }
    
    @objc
    private func create() {
        if let newCategory = enterNameTextField.text {
            categoryViewModel.addCategory(newCategory: newCategory)
        }
    }
    
}

// MARK: - Расширение для UITextFieldDelegate
extension AdditionNewCategoryViewController: UITextFieldDelegate {
    
    /// Метод, вызываемый при нажатии на "Return" на клавиатуре
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /// Метод, используемый для проверки наличия текста в UITextField
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.hasText {
            activateButton()
        } else {
            deactivateButton()
        }
    }
    
}
