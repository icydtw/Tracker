import UIKit

protocol TrackersViewControllerProtocol {
    func saveDoneEvent(id: UUID, index: IndexPath)
    var filteredTrackers: [TrackerCategory] {get set }
}

/// Экран "Трекеры" в таб-баре
class TrackersViewController: UIViewController {
    
    // MARK: - Свойства
    var choosenDay = "" // день в формате "понедельник"
    
    var dateString = "" // день в формате "2023/05/07"
    
    var trackers: [TrackerCategory] = []
    
    var trackerRecords: [TrackerRecord] = []
    
    lazy var filteredTrackers: [TrackerCategory] = trackers
    
    var trackersViewModel: TrackersViewModel
    
    var recordViewModel: RecordViewModel
    
    var dataProvider = DataProvider()
    
    var trackersCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(TrackersCell.self, forCellWithReuseIdentifier: "trackers")
        collection.register(CollectionHeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collection.showsVerticalScrollIndicator = false
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 9
            return layout
        }()
        collection.collectionViewLayout = layout
        return collection
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 19, height: 18))
        button.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(pointSize: 18, weight: .bold)), for: .normal)
        button.tintColor = .black
        button.addTarget(nil, action: #selector(plusTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let trackersLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("TrackersViewController.title", comment: "Заголовок экрана")
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.preferredDatePickerStyle = .compact
        datePicker.datePickerMode = .date
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.calendar = Calendar(identifier: .iso8601)
        datePicker.maximumDate = Date()
        datePicker.locale = Locale.current
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return datePicker
    }()
    
    let starImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "star"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("TrackersViewController.whatWeWillTrace", comment: "Надпись посередине экрана")
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
    
    let searchBar: UISearchBar = {
        let search = UISearchBar()
        search.placeholder = NSLocalizedString("TrackersViewController.search", comment: "Плейсхолдер в строке поиска")
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    // MARK: - Методы
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.delegate = self
        hideCollection()
        setupProperties()
        setupView()
        bind()
        dataProvider.updateCollectionView()
        do {
            try dataProvider.fetchedResultsController.performFetch()
        } catch {
            AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка запроса")
        }
    }
    
    init(trackersViewModel: TrackersViewModel, recordViewModel: RecordViewModel) {
        self.trackersViewModel = trackersViewModel
        self.recordViewModel = recordViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Настройка внешнего вида
    private func setupView() {
        dataProvider.updateCollectionView()
        datePickerValueChanged(sender: datePicker)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 13),
            plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            plusButton.widthAnchor.constraint(equalToConstant: 19),
            plusButton.heightAnchor.constraint(equalToConstant: 18),
            trackersLabel.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 13),
            trackersLabel.leadingAnchor.constraint(equalTo: plusButton.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePicker.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 13),
            datePicker.widthAnchor.constraint(equalToConstant: 120),
            searchBar.topAnchor.constraint(equalTo: trackersLabel.bottomAnchor, constant: 7),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            trackersCollection.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 7),
            trackersCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trackersCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            trackersCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        trackersCollection.isHidden = true
        if !filteredTrackers.isEmpty {
            stackView.isHidden = true
            trackersCollection.isHidden = false
        }
    }
    
    /// Настройка свойств, жестов и нотификаций
    private func setupProperties() {
        dataProvider.delegate = self
        makeDate(dateFormat: "EEEE")
        NotificationCenter.default.addObserver(self, selector: #selector(addEvent), name: Notification.Name("addEvent"), object: nil)
        stackView.addArrangedSubview(starImage)
        stackView.addArrangedSubview(questionLabel)
        view.addSubview(plusButton)
        view.addSubview(trackersLabel)
        view.addSubview(datePicker)
        view.addSubview(stackView)
        view.addSubview(trackersCollection)
        view.addSubview(searchBar)
        trackersCollection.dataSource = self
        trackersCollection.delegate = self
        searchBar.delegate = self
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(_:)))
        trackersCollection.addGestureRecognizer(longPressGestureRecognizer)

    }
    
    @objc
    func handleLongPressGesture(_ gestureRecognizer: UILongPressGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: trackersCollection)
        if let indexPath = trackersCollection.indexPathForItem(at: touchPoint) {
            showMenuForCell(at: indexPath)
        }
    }
    
    func showMenuForCell(at indexPath: IndexPath) {
        let alertController = UIAlertController(title: "Меню", message: "Выберите действие", preferredStyle: .actionSheet)
        let action1 = UIAlertAction(title: "Удалить", style: .destructive) { [weak self] (action) in
            guard let self = self else { return }
            let cell = self.trackersCollection.cellForItem(at: indexPath) as? TrackersCell
            let id = self.filteredTrackers[indexPath.section].trackers[indexPath.row].id
            self.trackersViewModel.deleteTracker(id: id)
        }
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: nil)
        alertController.addAction(action1)
        alertController.addAction(cancelAction)
        present(alertController, animated: true, completion: nil)
    }

    
    //Метод, обновляющий коллекцию в соответствии с выбранным днём
    func updateCollection() {
        var newEvents: [Event] = []
        var newCategory: String = ""
        var newTrackers: [TrackerCategory] = []
        filteredTrackers = []
        var isGood = false
        for tracker in trackers { // категория
            newCategory = tracker.label
            for event in tracker.trackers { // трекер
                if event.day?.contains(choosenDay) ?? false || event.day == nil {
                    newEvents.append(event)
                    isGood = true
                }
            }
            if isGood {
                newTrackers.append(TrackerCategory(label: newCategory, trackers: newEvents))
                newEvents = []
                isGood = false
                newCategory = ""
            }
        }
        filteredTrackers = newTrackers.sorted(by: {$0.label < $1.label})
    }
    
    /// Биндинг
    private func bind() {
        trackersViewModel.isTrackerDeleted = { result in
            switch result {
            case true: self.datePickerValueChanged(sender: self.datePicker)
            case false: AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка удаления трекера")
            }
        }
        recordViewModel.isRecordAdded = { result in
            switch result {
            case true: self.vibrate()
            case false: AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка добавления рекорда")
            }
        }
        recordViewModel.isRecordDeleted = { result in
            switch result {
            case true: self.vibrate()
            case false: AlertMessage.shared.displayErrorAlert(title: "Ошибка!", message: "Ошибка удаления рекорда")
            }
        }
    }
    
    /// Метод, нужный для включения вибрации
    private func vibrate() {
        let impactFeedbackGenerator = UIImpactFeedbackGenerator(style: .medium)
        impactFeedbackGenerator.prepare()
        impactFeedbackGenerator.impactOccurred()
    }
    
    /// Метод, проверяющий, есть ли трекеры на экране и отбражающий (или нет) заглушку
    private func hideCollection() {
        if !filteredTrackers.isEmpty {
            stackView.isHidden = true
            trackersCollection.isHidden = false
        } else {
            stackView.isHidden = false
            trackersCollection.isHidden = true
        }
    }
    
    /// Метод, вызываемый когда меняется дата в Date Picker
    @objc
    func datePickerValueChanged(sender: UIDatePicker) {
        makeDate(dateFormat: "EEEE")
        updateCollection()
        hideCollection()
        trackersCollection.reloadData()
    }
    
    /// Метод, вызываемый при нажатии на "+"
    @objc
    private func plusTapped() {
        let selecterTrackerVC = SelectingTrackerViewController()
        show(selecterTrackerVC, sender: self)
    }
    
    /// Метод, добавляющий коллекцию трекеров на экран и убирающий заглушку
    @objc private func addEvent() {
        filteredTrackers = trackers
        updateCollection()
        trackersCollection.reloadData()
        hideCollection()
    }
    
    /// Метод, прячущий клавиатуру при нажатии вне её области
    @objc
    func dismissKeyboard() {
        updateCollection()
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - Расширение для UICollectionViewDataSource
extension TrackersViewController: UICollectionViewDataSource {
    
    /// Метод, определяющий количество ячеек в секции коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredTrackers[section].trackers.count
    }
    
    /// Метод, определяющий количество секций в коллекции
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return filteredTrackers.count
    }
    
    /// Метод создания и настройки ячейки для indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackers", for: indexPath) as? TrackersCell
        cell?.delegate = self
        cell?.viewBackground.backgroundColor = filteredTrackers[indexPath.section].trackers[indexPath.row].color
        cell?.emoji.text = filteredTrackers[indexPath.section].trackers[indexPath.row].emoji
        cell?.name.text = filteredTrackers[indexPath.section].trackers[indexPath.row].name
        cell?.plusButton.backgroundColor = filteredTrackers[indexPath.section].trackers[indexPath.row].color
        let daysDone = trackerRecords.filter({$0.id == filteredTrackers[indexPath.section].trackers[indexPath.row].id}).count
        let doneString = String.localizedStringWithFormat(
            NSLocalizedString("days", comment: ""), daysDone)
        cell?.quantity.text = doneString
        makeDate(dateFormat: "yyyy/MM/dd")
        if trackerRecords.filter({$0.id == filteredTrackers[indexPath.section].trackers[indexPath.row].id}).contains(where: {$0.day == dateString}) {
            cell?.plusButton.backgroundColor = filteredTrackers[indexPath.section].trackers[indexPath.row].color.withAlphaComponent(0.5)
            cell?.plusButton.setImage(UIImage(systemName: "checkmark"), for: .normal)
        } else {
            cell?.plusButton.setImage(UIImage(systemName: "plus"), for: .normal)
        }
        return cell!
    }
    
    /// Метод создания и настройки Supplementary View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CollectionHeaderSupplementaryView
        header.title.text = filteredTrackers[indexPath.section].label
        return header
    }
    
}

// MARK: - Расширение для UICollectionViewDelegateFlowLayout
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    
    /// Метод, определяющий размер элемента коллекции для indexPath
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 41) / 2, height: 148)
    }
    
    /// Метод, определяющий размер заголовка секции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
}

// MARK: - Расширение для UICollectionViewDelegate
extension TrackersViewController: UICollectionViewDelegate {
    
}

// MARK: - Расширение для UISearchBarDelegate
extension TrackersViewController: UISearchBarDelegate {
    
    /// Метод, отслеживающий ввод текста в поисковую строку
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        var newEvents: [Event] = []
        var newCategory: String = ""
        var newTrackers: [TrackerCategory] = []
        datePickerValueChanged(sender: datePicker)
        let searchingTrackers = filteredTrackers
        filteredTrackers = []
        var isGood = false
        for tracker in searchingTrackers { // категория
            newCategory = tracker.label
            for event in tracker.trackers { // трекер
                if event.name.hasPrefix(searchText) {
                    newEvents.append(event)
                    isGood = true
                }
            }
            if isGood {
                newTrackers.append(TrackerCategory(label: newCategory, trackers: newEvents))
                newEvents = []
                isGood = false
                newCategory = ""
            }
        }
        filteredTrackers = newTrackers
        trackersCollection.reloadData()
    }
    
    /// Метод, прячущий клавиатуру при нажатии Enter
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    /// Метод, прячущий клавиатуру при нажатии Cancel
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
}

// MARK: - Расширение для TrackersViewControllerProtocol
extension TrackersViewController: TrackersViewControllerProtocol {
    
    /// Метод, добавляющий информацию о выполненном трекере в trackerRecords
    func saveDoneEvent(id: UUID, index: IndexPath) {
        makeDate(dateFormat: "yyyy/MM/dd")
        if trackerRecords.filter({$0.id == filteredTrackers[index.section].trackers[index.row].id}).contains(where: {$0.day == dateString}) {
            recordViewModel.deleteRecord(id: id, day: dateString)
        } else {
            recordViewModel.addRecord(id: id, day: dateString)
        }
        trackersCollection.reloadData()
    }
    
}

// MARK: - Расширение, упрощающее работу с DatePicker
extension TrackersViewController {
    
    /// Метод, заполняющий переменные с датами в том или ином формате
    private func makeDate(dateFormat: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = dateFormat
        let dateFormatterString = dateFormatter.string(from: datePicker.date)
        if dateFormat == "EEEE" {
            choosenDay = dateFormatterString
        } else if dateFormat == "yyyy/MM/dd" {
            dateString = dateFormatterString
        }
    }
    
}
