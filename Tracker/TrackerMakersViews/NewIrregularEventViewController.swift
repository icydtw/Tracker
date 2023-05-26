import UIKit

/// Экран создания нового "Нерегулярного события"
final class NewIrregularEventViewController: UIViewController {
    
    // MARK: - Свойства
    let dataProvider = DataProvider()
    
    let categoryViewModel: CategoryViewModel
    
    let colorCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ColorCell.self, forCellWithReuseIdentifier: "colorCell")
        collection.register(CollectionHeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return collection
    }()
    
    let emojiCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(EmojiCell.self, forCellWithReuseIdentifier: "emojiCell")
        collection.register(CollectionHeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return collection
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Новое нерегулярное событие"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let enterNameTextField: UITextField = {
        let field = UITextField()
        field.placeholder = "Введите название трекера"
        field.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
        field.layer.cornerRadius = 16
        field.translatesAutoresizingMaskIntoConstraints = false
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: field.frame.height))
        field.leftView = paddingView
        field.leftViewMode = .always
        return field
    }()
    
    let categoriesTable: UITableView = {
        let table = UITableView()
        table.register(IrregularCategoryCell.self, forCellReuseIdentifier: "category")
        table.isScrollEnabled = false
        table.separatorStyle = .none
        return table
    }()
    
    let firstStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 8.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(UIColor(red: 0.961, green: 0.42, blue: 0.424, alpha: 1), for: .normal)
        button.layer.borderColor = UIColor(red: 0.961, green: 0.42, blue: 0.424, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(create), for: .touchUpInside)
        button.isEnabled = false
        return button
    }()
    
    let secondStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.indicatorStyle = .white
        return scroll
    }()
    
    // MARK: - Методы
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        setupView()
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
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            enterNameTextField.heightAnchor.constraint(equalToConstant: 71),
            firstStack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 24),
            firstStack.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            firstStack.heightAnchor.constraint(equalToConstant: 150),
            firstStack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 16),
            emojiCollection.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 24),
            emojiCollection.heightAnchor.constraint(equalToConstant: 200),
            emojiCollection.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 16),
            emojiCollection.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            emojiCollection.widthAnchor.constraint(equalTo: firstStack.widthAnchor),
            colorCollection.topAnchor.constraint(equalTo: emojiCollection.bottomAnchor),
            colorCollection.heightAnchor.constraint(equalToConstant: 200),
            colorCollection.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 16),
            colorCollection.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            colorCollection.widthAnchor.constraint(equalTo: firstStack.widthAnchor),
            secondStack.heightAnchor.constraint(equalToConstant: 60),
            secondStack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 28),
            secondStack.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            secondStack.topAnchor.constraint(equalTo: colorCollection.bottomAnchor, constant: 24),
        ])
    }
    
    /// Настройка свойств, жестов и нотификаций
    private func setupProperties() {
        categoryViewModel.didChooseCategory(name: "")
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        NotificationCenter.default.addObserver(self, selector: #selector(showCategory), name: Notification.Name("category_changed"), object: nil)
        firstStack.addArrangedSubview(enterNameTextField)
        firstStack.addArrangedSubview(categoriesTable)
        secondStack.addArrangedSubview(cancelButton)
        secondStack.addArrangedSubview(createButton)
        view.addSubview(scroll)
        view.addSubview(titleLabel)
        scroll.addSubview(firstStack)
        scroll.addSubview(emojiCollection)
        scroll.addSubview(colorCollection)
        scroll.addSubview(secondStack)
        scroll.contentSize = CGSize(width: view.frame.width, height: 708)
        colorCollection.delegate = self
        colorCollection.dataSource = self
        emojiCollection.delegate = self
        emojiCollection.dataSource = self
        categoriesTable.dataSource = self
        categoriesTable.delegate = self
        enterNameTextField.delegate = self
    }
    
    /// Метод, вызываемый при нажатии на кнопку "Отмена"
    @objc
    private func cancel() {
        dismiss(animated: true)
    }
    
    /// Метод, прячущий клавиатуру при нажатии вне её области
    @objc
    func dismissKeyboard() {
        enterNameTextField.resignFirstResponder()
    }
    
    /// Метод, вызываемый при нажатии на кнопку "Создать"
    @objc
    private func create() {
        let name = enterNameTextField.text ?? ""
        let category = categoryViewModel.getChoosedCategory()
        let emojiIndex = emojiCollection.indexPathsForSelectedItems?.first
        let emoji = emojiCollectionData[emojiIndex?.row ?? 0]
        let colorIndex = colorCollection.indexPathsForSelectedItems?.first
        let color = colorCollectionData[colorIndex?.row ?? 0]
        let event = Event(name: name, emoji: emoji, color: color, day: nil)
        dismiss(animated: true)
        categoryViewModel.didChooseCategory(name: "")
        dataProvider.addTracker(event: event, category: category)
        vibrate()
    }
    
    /// Проверка заполнения всех полей при создании трекера
    private func activateButton() {
        if enterNameTextField.hasText && !categoryViewModel.getChoosedCategory().isEmpty && !(emojiCollection.indexPathsForSelectedItems?.isEmpty ?? false) && !(colorCollection.indexPathsForSelectedItems?.isEmpty ?? false) {
            createButton.backgroundColor = .black
            createButton.isEnabled = true
        }
    }
    
    /// Метод, нужный для включения вибрации
    private func vibrate() {
        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactFeedbackGenerator.prepare()
        impactFeedbackGenerator.impactOccurred()
    }
    
    /// Метод, обновлящий название выбранной категории при срабатывании нотификации
    @objc
    private func showCategory() {
        categoriesTable.reloadData()
        activateButton()
    }
    
}

// MARK: - Расширение для UITextFieldDelegate
extension NewIrregularEventViewController: UITextFieldDelegate {
    
    /// Метод, вызываемый при нажатии на "Return" на клавиатуре
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    /// Метод, используемый для проверки наличия текста в UITextField
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.hasText {
            activateButton()
        }
        return true
    }
    
}

// MARK: - Расширение для UICollectionViewDataSource
extension NewIrregularEventViewController: UICollectionViewDataSource {
    
    /// Метод, определяющий количество ячеек в секции коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorCollection {
            return colorCollectionData.count
        } else {
            return emojiCollectionData.count
        }
    }
    
    /// Метод создания и настройки ячейки для indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == colorCollection {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorCell else {
                return UICollectionViewCell()
            }
            cell.color.backgroundColor = colorCollectionData[indexPath.row]
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath) as? EmojiCell else {
                return UICollectionViewCell()
            }
            cell.emojiLabel.text = emojiCollectionData[indexPath.row]
            return cell
        }
    }
    
    /// Метод создания и настройки Supplementary View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == colorCollection {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? CollectionHeaderSupplementaryView else {
                fatalError("Unable to dequeue CollectionHeaderSupplementaryView")
            }
            header.title.text = "Цвет"
            return header
        } else {
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? CollectionHeaderSupplementaryView else {
                fatalError("Unable to dequeue CollectionHeaderSupplementaryView")
            }
            header.title.text = "Emoji"
            return header
        }
    }
    
}

// MARK: - Расширение для UICollectionViewDelegateFlowLayout
extension NewIrregularEventViewController: UICollectionViewDelegateFlowLayout {
    
    /// Метод, определяющий размер элемента коллекции для indexPath
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    
    /// Метод, определяющий минимальное расстояние между элементами в секции коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return (collectionView.bounds.width - 300) / 6
    }
    
    /// Метод, определяющий минимальное расстояние между строками элементов в секции коллекции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    /// Метод, определяющий размер заголовка секции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }
    
}

// MARK: - Расширение для UICollectionViewDelegate
extension NewIrregularEventViewController: UICollectionViewDelegate {
    
    /// Метод, вызываемый при выборе ячейки коллекции
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == colorCollection {
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.layer.borderWidth = 3
            cell?.layer.borderColor = cell?.color.backgroundColor?.cgColor.copy(alpha: 0.3)
            cell?.layer.cornerRadius = 8
            cell?.layer.masksToBounds = true
            activateButton()
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as? EmojiCell
            cell?.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 1)
            cell?.layer.cornerRadius = 16
            cell?.layer.masksToBounds = true
            activateButton()
        }
    }
    
    /// Метод, вызываемый при снятии выделения с ячейки коллекции
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if collectionView == colorCollection {
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCell
            cell?.layer.borderColor = CGColor(gray: 0, alpha: 0)
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as? EmojiCell
            cell?.backgroundColor = UIColor.clear
        }
    }
    
}

// MARK: - Расширение для UITableViewDataSource
extension NewIrregularEventViewController: UITableViewDataSource {
    
    /// Метод, определяющий количество строк в секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /// Метод создания и настройки ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        guard let categoryCell = cell as? IrregularCategoryCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        categoryCell.categoryName.text = categoryViewModel.getChoosedCategory()
        return categoryCell
    }
    
}

// MARK: - Расширение для UITableViewDelegate
extension NewIrregularEventViewController: UITableViewDelegate {
    
    /// Метод, определяющий высоту строки таблицы
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    /// Метод, вызываемый при нажатии на строку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let choiceOfCategoryViewController = ChoiceOfCategoryViewController(viewModel: categoryViewModel)
        show(choiceOfCategoryViewController, sender: self)
    }
    
}
