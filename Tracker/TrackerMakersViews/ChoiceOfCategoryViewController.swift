import UIKit

/// Экран со списком категорий
final class ChoiceOfCategoryViewController: UIViewController {
    
    // MARK: - Свойства
    let categoryViewModel: CategoryViewModel
    
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
        table.register(ChoiceOfCategoryCell.self, forCellReuseIdentifier: "category")
        table.isScrollEnabled = true
        table.separatorStyle = .singleLine
        table.translatesAutoresizingMaskIntoConstraints = false
        table.layer.cornerRadius = 16
        table.allowsMultipleSelection = false
        return table
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("ChoiceOfCategoryViewController.title", comment: "Заголовок экрана")
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
        button.setTitle(NSLocalizedString("ChoiceOfCategoryViewController.addCategory", comment: "Кнопка добавления категории"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(showAdditionCategoryViewController), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Методы
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bind()
    }
    
    init(viewModel: CategoryViewModel) {
        self.categoryViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Настройка внешнего вида
    private func setupView() {
        NotificationCenter.default.addObserver(self, selector: #selector(updateCategories), name: Notification.Name("categories_added"), object: nil)
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
            addCategoryButton.heightAnchor.constraint(equalToConstant: 60),
            categoriesTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoriesTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            categoriesTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            categoriesTable.bottomAnchor.constraint(equalTo: addCategoryButton.topAnchor, constant: -46)
        ])
        showCategories()
    }
    
    @objc
    private func updateCategories() {
        showCategories()
        categoriesTable.reloadData()
    }
    
    private func showCategories() {
        if !categoryViewModel.getCategories().isEmpty {
            stackView.isHidden = true
            categoriesTable.isHidden = false
        } else {
            stackView.isHidden = false
            categoriesTable.isHidden = true
        }
    }
    
    private func bind() {
        categoryViewModel.isCategoryChoosed = { [weak self] isOk in
            guard let self = self else { return }
            if isOk {
                self.dismiss(animated: true)
            } else {
                AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка выбора категории")
            }
        }
        
        categoryViewModel.isCategoryDeleted = { [weak self] index in
            guard let self = self else { return }
            self.categoriesTable.deleteRows(at: [index], with: .fade)
            self.categoriesTable.reloadData()
            if self.categoryViewModel.getCategories().isEmpty {
                self.categoriesTable.isHidden = true
                self.stackView.isHidden = false
            }
            categoriesTable.cellForRow(at: IndexPath(row: categoryViewModel.getCategories().count - 1, section: 0))?.contentView.layer.cornerRadius = 16
            categoriesTable.cellForRow(at: IndexPath(row: categoryViewModel.getCategories().count - 1, section: 0))?.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            categoriesTable.cellForRow(at: IndexPath(row: categoryViewModel.getCategories().count - 1, section: 0))?.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: categoriesTable.bounds.size.width)
        }
    }
    
    @objc
    private func showAdditionCategoryViewController() {
        let viewController = AdditionNewCategoryViewController(categoryViewModel: categoryViewModel)
        show(viewController, sender: self)
    }

}

// MARK: - Расширение для UITableViewDataSource
extension ChoiceOfCategoryViewController: UITableViewDataSource {
    
    /// Метод, возвращающий количество строк в секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryViewModel.getCategories().count
    }
    
    /// Метод создания и настройки ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        cell.separatorInset = .zero
        cell.contentView.layer.cornerRadius = .zero
        guard let categoryCell = cell as? ChoiceOfCategoryCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        categoryCell.title.text = categoryViewModel.getCategories()[indexPath.row]
        return categoryCell
    }
    
    /// Метод, определяющий, может ли строка таблицы быть редактируемой
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    /// Метод, обрабатывающий удаление строки таблицы
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        categoryViewModel.deleteCategory(at: indexPath)
    }
    
}

// MARK: - Расширение для UITableViewDelegate
extension ChoiceOfCategoryViewController: UITableViewDelegate {
    
    /// Метод, определяющий высоту строки таблицы
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    /// Метод конфигурации ячеек перед их отображением
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.bounds.size.width)
            cell.contentView.layer.cornerRadius = 16
            cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMinYCorner]
            cell.contentView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            cell.layer.masksToBounds = true
        }
    }
    
    /// Метод, вызываемый при нажатии на строку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? ChoiceOfCategoryCell
        cell?.checkbox.image = UIImage(systemName: "checkmark")
        categoryViewModel.didChooseCategory(name: cell?.title.text ?? "-")
    }
    
    /// Метод, определяющий заголовок для удаления строки таблицы
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return NSLocalizedString("ChoiceOfCategoryViewController.deleteCategory", comment: "Удаление строки категории")
    }
    
}
