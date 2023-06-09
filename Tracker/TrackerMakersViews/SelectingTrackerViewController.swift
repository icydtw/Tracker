import UIKit

/// Экран выбора типа трекера
final class SelectingTrackerViewController: UIViewController {
    
    // MARK: - Свойства
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("SelectingTrackerViewController.title", comment: "Заголовок экрана")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let habitButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle(NSLocalizedString("SelectingTrackerViewController.habit", comment: "Первая кнопка"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.addTarget(nil, action: #selector(habitTapped), for: .touchUpInside)
        return button
    }()
    
    let irregularEventButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle(NSLocalizedString("SelectingTrackerViewController.irregularEvent", comment: "Вторая кнопка"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.addTarget(nil, action: #selector(irregularTapped), for: .touchUpInside)
        return button
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    // MARK: - Методы
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        setupView()
    }
    
    /// Настройка внешнего вида
    private func setupView() {
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            habitButton.heightAnchor.constraint(equalToConstant: 60),
            irregularEventButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    /// Настройка свойств
    private func setupProperties() {
        stackView.addArrangedSubview(habitButton)
        stackView.addArrangedSubview(irregularEventButton)
        view.addSubview(titleLabel)
        view.addSubview(stackView)
    }
    
    /// Метод, вызываемый при выборе пользователем "Нерегулярного события"
    @objc
    private func irregularTapped() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let categoryViewModel = appDelegate?.categoryViewModel
        let trackersViewModel = appDelegate?.trackersViewModel
        categoryViewModel?.getCategories()
        let irregularEventVC = NewIrregularEventViewController(categoryViewModel: categoryViewModel ?? CategoryViewModel(), trackersViewModel: trackersViewModel ?? TrackersViewModel())
        show(irregularEventVC, sender: self)
    }
    
    /// Метод, вызываемый при выборе пользователем "Привычки"
    @objc
    private func habitTapped() {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        let categoryViewModel = appDelegate?.categoryViewModel
        let trackersViewModel = appDelegate?.trackersViewModel
        categoryViewModel?.getCategories()
        let habitVC = NewHabitViewController(categoryViewModel: categoryViewModel ?? CategoryViewModel(), trackersViewModel: trackersViewModel ?? TrackersViewModel())
        show(habitVC, sender: self)
    }
    
}
