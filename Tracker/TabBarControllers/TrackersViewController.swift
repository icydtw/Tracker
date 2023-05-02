import UIKit

/// Экран "Трекеры" в таб-баре
class TrackersViewController: UIViewController, UISearchBarDelegate {
    
    // MARK: - Свойства
    var choosenDay = ""
    
    var trackersCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(TrackersCellsViewController.self, forCellWithReuseIdentifier: "trackers")
        collection.register(CollectionHeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return collection
    }()
    
    let plusButton: UIButton = {
        let button = UIButton(frame: CGRect(x: 0, y: 0, width: 19, height: 18))
        let image = UIImage(systemName: "plus")
        let imageView = UIImageView(image: image)
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.frame = button.bounds
        button.addSubview(imageView)
        button.addTarget(nil, action: #selector(plusTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let trackersLabel: UILabel = {
        let label = UILabel()
        label.text = "Трекеры"
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
        datePicker.locale = Locale(identifier: "ru_RU")
        datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
        return datePicker
    }()
    
    let starImage = UIImageView(image: UIImage(named: "star"))
    
    let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Что будем отслеживать?"
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
        search.placeholder = "Поиск"
        search.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
        search.translatesAutoresizingMaskIntoConstraints = false
        return search
    }()
    
    // MARK: - Метод жизненного цикла viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Настройка внешнего вида
    private func setupView() {
        view.backgroundColor = .white
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE" // Формат дня недели
        let dayOfWeekString = dateFormatter.string(from: datePicker.date)
        choosenDay = dayOfWeekString
        NotificationCenter.default.addObserver(self, selector: #selector(addEvent), name: Notification.Name("addEvent"), object: nil)
        let layout: UICollectionViewFlowLayout = {
            let layout = UICollectionViewFlowLayout()
            layout.scrollDirection = .vertical
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 9
            return layout
        }()
        trackersCollection.collectionViewLayout = layout
        starImage.translatesAutoresizingMaskIntoConstraints = false
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
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            plusButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            plusButton.widthAnchor.constraint(equalToConstant: 19),
            plusButton.heightAnchor.constraint(equalToConstant: 18),
            trackersLabel.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 13),
            trackersLabel.leadingAnchor.constraint(equalTo: plusButton.leadingAnchor),
            datePicker.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            datePicker.topAnchor.constraint(equalTo: plusButton.bottomAnchor, constant: 13),
            searchBar.topAnchor.constraint(equalTo: trackersLabel.bottomAnchor, constant: 7),
            searchBar.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        if !events.isEmpty {
            stackView.isHidden = true
            NSLayoutConstraint.activate([
                trackersCollection.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 7),
                trackersCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
                trackersCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
                trackersCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34)
            ])
        }
    }
    
    // MARK: - Метод, вызываемый когда меняется дата в Date Picker
    @objc
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let dayOfWeekString = dateFormatter.string(from: sender.date)
        choosenDay = dayOfWeekString
        trackersCollection.reloadData()
    }
    
    // MARK: - Метод, вызываемый при нажатии на "+"
    @objc
    private func plusTapped() {
        let selecterTrackerVC = SelectingTrackerViewController()
        show(selecterTrackerVC, sender: self)
    }
    
    // MARK: - Метод, добавляющий коллекцию трекеров на экран и убирающий заглушку
    @objc private func addEvent() {
        stackView.isHidden = true
        NSLayoutConstraint.activate([
            trackersCollection.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 7),
            trackersCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            trackersCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            trackersCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -34)
        ])
        trackersCollection.reloadData()
    }
    
}

// MARK: - Расширение для UICollectionViewDataSource
extension TrackersViewController: UICollectionViewDataSource {
    
    // MARK: Метод, определяющий количество ячеек в секции коллекции
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    // MARK: Метод, определяющий количество секций в коллекции
    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        let uniqueCategories = events.reduce(into: Set<String>()) { set, event in
//            set.insert(event.category)
//        }
//        return uniqueCategories.count
        return 1
    }
    
    // MARK: Метод создания и настройки ячейки для indexPath
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trackers", for: indexPath) as? TrackersCellsViewController
        let day = events[indexPath.row].day?.first(where: {$0 == choosenDay})
        if day == choosenDay || events[indexPath.row].day == nil || day == "" {
            cell?.contentView.backgroundColor = events[indexPath.row].color
            cell?.emoji.text = events[indexPath.row].emoji
            cell?.name.text = events[indexPath.row].name
            cell?.isHidden = false
            return cell!
        } else {
            cell?.isHidden = true
        }
        return cell!
    }
    
    // MARK: Метод создания и настройки Supplementary View
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! CollectionHeaderSupplementaryView
        header.title.text = events[indexPath.row].category
        return header
    }
    
}

// MARK: - Расширение для UICollectionViewDelegateFlowLayout
extension TrackersViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: Метод, определяющий размер элемента коллекции для indexPath
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width - 41) / 2, height: 90)
    }
    
    // MARK: Метод, определяющий размер заголовка секции
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 40)
    }
    
}

// MARK: - Расширение для UICollectionViewDelegate
extension TrackersViewController: UICollectionViewDelegate {
    
}
