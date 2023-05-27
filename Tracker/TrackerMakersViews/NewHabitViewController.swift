import UIKit

/// Экран создания новой "Привычки"
final class NewHabitViewController: UIViewController {

    // MARK: - Свойства
    
    let categoryViewModel: CategoryViewModel
    
    let trackersViewModel: TrackersViewModel
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Новая привычка"
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
        table.register(HabitCategoryCell.self, forCellReuseIdentifier: "category")
        table.isScrollEnabled = false
        table.separatorStyle = .singleLine
        table.layer.cornerRadius = 16
        table.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
        return table
    }()
    
    let firstStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
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
        bind()
    }
    
    init(categoryViewModel: CategoryViewModel, trackersViewModel: TrackersViewModel) {
        self.categoryViewModel = categoryViewModel
        self.trackersViewModel = trackersViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Настройка внешнего вида
    private func setupView() {
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
            firstStack.heightAnchor.constraint(equalToConstant: 225),
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
        NotificationCenter.default.addObserver(self, selector: #selector(changeCategoryCell), name: Notification.Name("category_changed"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeScheduleCell), name: Notification.Name("schedule_changed"), object: nil)
        view.backgroundColor = .white
        firstStack.addArrangedSubview(enterNameTextField)
        firstStack.addArrangedSubview(categoriesTable)
        secondStack.addArrangedSubview(cancelButton)
        secondStack.addArrangedSubview(createButton)
        scroll.addSubview(firstStack)
        scroll.addSubview(emojiCollection)
        scroll.addSubview(colorCollection)
        scroll.addSubview(secondStack)
        view.addSubview(titleLabel)
        view.addSubview(scroll)
        view.addGestureRecognizer(tapGesture)
        scroll.contentSize = CGSize(width: view.frame.width, height: 779)
        categoriesTable.dataSource = self
        categoriesTable.delegate = self
        colorCollection.delegate = self
        colorCollection.dataSource = self
        emojiCollection.delegate = self
        emojiCollection.dataSource = self
        enterNameTextField.delegate = self
    }
    
    private func bind() {
        trackersViewModel.isTrackerAdded = { result in
            print(result)
            switch result {
            case true: self.dismiss(animated: true)
            case false: AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка добавления трекера")
            }
        }
    }
    
    private func activateButton() {
        if enterNameTextField.hasText && !categoryViewModel.getChoosedCategory().isEmpty && !selectedDays.isEmpty && !(emojiCollection.indexPathsForSelectedItems?.isEmpty ?? false) && !(colorCollection.indexPathsForSelectedItems?.isEmpty ?? false) {
            createButton.backgroundColor = .black
            createButton.isEnabled = true
        }
    }
    
    private func deactivateButton() {
        if !enterNameTextField.hasText || categoryViewModel.getChoosedCategory().isEmpty || selectedDays.isEmpty || (emojiCollection.indexPathsForSelectedItems?.isEmpty ?? false) || (colorCollection.indexPathsForSelectedItems?.isEmpty ?? false) {
            createButton.backgroundColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
            createButton.isEnabled = false
        }
    }
    
    private func vibrate() {
        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactFeedbackGenerator.prepare()
        impactFeedbackGenerator.impactOccurred()
    }
    
    /// Метод, вызываемый при нажатии на кнопку "Отмена"
    @objc
    private func cancel() {
        dismiss(animated: true)
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
        let day = selectedDays
        let event = Event(name: name, emoji: emoji, color: color, day: day)
        categoryViewModel.didChooseCategory(name: "")
        selectedDays = []
        shortSelectedDays = []
        trackersViewModel.addTracker(event: event, category: category, categoryViewModel: categoryViewModel)
        vibrate()
    }
    
    /// Метод, меняющий первую строку таблицы ("категория") при срабатывании нотификации
    @objc
    private func changeCategoryCell() {
        let cell = categoriesTable.cellForRow(at: [0,0]) as? HabitCategoryCell
        cell?.title.removeFromSuperview()
        cell?.addSubview(cell!.title)
        cell?.categoryName.text = categoryViewModel.getChoosedCategory()
        cell?.categoryName.topAnchor.constraint(equalTo: cell!.title.bottomAnchor, constant: 2).isActive = true
        cell?.categoryName.leadingAnchor.constraint(equalTo: cell!.leadingAnchor, constant: 16).isActive = true
        cell?.title.leadingAnchor.constraint(equalTo: cell!.leadingAnchor, constant: 16).isActive = true
        cell?.title.topAnchor.constraint(equalTo: cell!.topAnchor, constant: 15).isActive = true
        activateButton()
    }
    
    /// Метод, меняющий вторую строку таблицы ("расписание") при срабатывании нотификации
    @objc
    private func changeScheduleCell() {
        let cell = categoriesTable.cellForRow(at: [0,1]) as? HabitCategoryCell
        cell?.title.removeFromSuperview()
        cell?.addSubview(cell!.title)
        cell?.categoryName.text = shortSelectedDays.joined(separator: ", ")
        cell?.categoryName.topAnchor.constraint(equalTo: cell!.title.bottomAnchor, constant: 2).isActive = true
        cell?.categoryName.leadingAnchor.constraint(equalTo: cell!.leadingAnchor, constant: 16).isActive = true
        cell?.title.leadingAnchor.constraint(equalTo: cell!.leadingAnchor, constant: 16).isActive = true
        cell?.title.topAnchor.constraint(equalTo: cell!.topAnchor, constant: 15).isActive = true
        activateButton()
    }
    
    /// Метод, прячущий клавиатуру при нажатии вне её области
    @objc
    func dismissKeyboard() {
        enterNameTextField.resignFirstResponder()
    }
    
}

// MARK: - Расширение для UITextFieldDelegate
extension NewHabitViewController: UITextFieldDelegate {
    
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

// MARK: - Расширение для UITableViewDataSource
extension NewHabitViewController: UITableViewDataSource {
    
    /// Метод, возвращающий количество строк в секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    /// Метод создания и настройки ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        guard let categoryCell = cell as? HabitCategoryCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            categoryCell.title.text = "Категория"
        default:
            categoryCell.title.text = "Расписание"
        }
        return categoryCell
    }
    
}

// MARK: - Расширение для UITableViewDelegate
extension NewHabitViewController: UITableViewDelegate {
    
    /// Метод, определяющий высоту строки таблицы
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    /// Метод конфигурации ячеек перед их отображением
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.bounds.size.width)
        }
    }
    
    /// Метод, вызываемый при нажатии на строку таблицы
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let choiceOfCategoryViewController = ChoiceOfCategoryViewController(viewModel: categoryViewModel)
            show(choiceOfCategoryViewController, sender: self)
        } else {
            let scheduleViewController = ScheduleViewController()
            show(scheduleViewController, sender: self)
        }
    }
    
}

// MARK: - Расширение для UICollectionViewDataSource
extension NewHabitViewController: UICollectionViewDataSource {
    
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
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? CollectionHeaderSupplementaryView {
                header.title.text = "Цвет"
                return header
            } else {
                assertionFailure("Unable to dequeue CollectionHeaderSupplementaryView")
            }
        } else {
            if let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? CollectionHeaderSupplementaryView {
                header.title.text = "Emoji"
                return header
            } else {
                fatalError("Unable to dequeue CollectionHeaderSupplementaryView")
            }
        }
        return UICollectionReusableView()
    }
}

// MARK: - Расширение для UICollectionViewDelegateFlowLayout
extension NewHabitViewController: UICollectionViewDelegateFlowLayout {
    
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
extension NewHabitViewController: UICollectionViewDelegate {
    
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
