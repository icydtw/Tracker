import UIKit

/// Экран "Статистика" в таб-баре
final class StatisticsViewController: UIViewController {
    
    // MARK: - Свойства
    let statisticsLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("StatisticsViewController.title", comment: "Заголовок экрана")
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let faceImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "face"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("StatisticsViewController.nothingToAnalize", comment: "Надпись посередине экрана")
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
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
    
    /// Найстройка внешнего вида
    private func setupView() {
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            statisticsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statisticsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
    }
    
    /// Настройка свойств
    private func setupProperties() {
        view.addSubview(statisticsLabel)
        view.addSubview(faceImage)
        view.addSubview(questionLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(faceImage)
        stackView.addArrangedSubview(questionLabel)
    }
    
}
