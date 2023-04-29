import UIKit

/// Экран со списком категорий
final class ChoiceOfCategoryViewController: UIViewController {
    
    // MARK: - Свойства
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.distribution = .fillProportionally
        stack.spacing = 8.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let categoriesTable: UITableView = {
        let table = UITableView()
        table.register(ChoiceOfCategoryCellsViewController.self, forCellReuseIdentifier: "category")
        table.isScrollEnabled = true
        table.separatorStyle = .singleLine
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 16
        table.allowsMultipleSelection = false
        return table
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Категория"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starImage: UIImageView = {
        let image = UIImageView(image: UIImage(named: "star"))
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = """
        Привычки и события можно
        объединить по смыслу
        """
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let addCategoryButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Добавить категорию", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        //button.addTarget(nil, action: #selector(), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Метод жизненного цикла viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Настройка внешнего вида
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(stackView)
        view.addSubview(addCategoryButton)
        view.addSubview(categoriesTable)
        categoriesTable.dataSource = self
        categoriesTable.delegate = self
        stackView.addArrangedSubview(starImage)
        stackView.addArrangedSubview(questionLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addCategoryButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            addCategoryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addCategoryButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            addCategoryButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            addCategoryButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        if !categories.isEmpty {
            stackView.isHidden = true
            NSLayoutConstraint.activate([
                categoriesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                categoriesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                categoriesTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
                categoriesTable.heightAnchor.constraint(equalToConstant: CGFloat(75 * categories.count))
            ])
        }
    }

}

// MARK: - Расширение для UITableViewDataSource
extension ChoiceOfCategoryViewController: UITableViewDataSource {
    
    // MARK: Метод, возвращающий количество строк в секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    // MARK: Метод создания и настройки ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        guard let categoryCell = cell as? ChoiceOfCategoryCellsViewController else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        categoryCell.title.text = categories[indexPath.row]
        return categoryCell
    }
    
    // MARK: Метод, определяющий, может ли строка таблицы быть редактируемой
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    // MARK: Метод, обрабатывающий удаление строки таблицы
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            categories.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        if categories.isEmpty {
            categoriesTable.isHidden = true
            stackView.isHidden = false
        }
    }
    
}

// MARK: - Расширение для UITableViewDelegate
extension ChoiceOfCategoryViewController: UITableViewDelegate {
    
    // MARK: Метод, определяющий высоту строки таблицы
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    // MARK: Метод конфигурации ячеек перед их отображением
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.bounds.size.width)
        }
    }
    
    // MARK: Метод, вызываемый при нажатии на строку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ChoiceOfCategoryCellsViewController
        cell?.checkbox.image = UIImage(systemName: "checkmark")
        dismiss(animated: true) {
            categoryName = cell?.title.text ?? ""
            let notification = Notification(name: Notification.Name("category_changed"))
            NotificationCenter.default.post(notification)
        }
    }
    
    // MARK: Метод, вызываемый при повторном нажатии (снятии выделения) на строку таблицы
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ChoiceOfCategoryCellsViewController
        cell?.checkbox.image = UIImage()
    }
    
}
