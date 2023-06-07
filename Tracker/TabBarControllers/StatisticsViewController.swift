import UIKit

/// Экран "Статистика" в таб-баре
final class StatisticsViewController: UIViewController {
    
    // MARK: - Свойства
    
    var statisticsViewModel: StatisticsViewModel
    
    var statisticsNumber = 0
    
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
    
    let statisticsTable: UITableView = {
        let table = UITableView()
        table.register(StatisticsCell.self, forCellReuseIdentifier: "statisticsCell")
        table.isScrollEnabled = false
        table.separatorStyle = .none
        table.allowsSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Методы
    override func viewDidLoad() {
        super.viewDidLoad()
        setupProperties()
        bind()
        setupView()
    }
    
    init(statisticsViewModel: StatisticsViewModel) {
        self.statisticsViewModel = statisticsViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Настройка внешнего вида
    private func setupView() {
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            statisticsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statisticsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 44),
            stackView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statisticsTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            statisticsTable.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            statisticsTable.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            statisticsTable.heightAnchor.constraint(equalToConstant: 90),
        ])
        showStatistics()
    }
    
    /// Настройка свойств
    private func setupProperties() {
        NotificationCenter.default.addObserver(self, selector: #selector(showStatistics), name: Notification.Name("plus_tapped"), object: nil)
        view.addSubview(statisticsLabel)
        view.addSubview(stackView)
        view.addSubview(statisticsTable)
        stackView.addArrangedSubview(faceImage)
        stackView.addArrangedSubview(questionLabel)
        statisticsTable.dataSource = self
        statisticsTable.delegate = self
    }
    
    /// Биндинг
    private func bind() {
        statisticsViewModel.isStatisticScreenShouldUpdate = { result in
            if result.endedTracks > 0 {
                self.stackView.isHidden = true
                self.statisticsTable.isHidden = false
                self.statisticsNumber = result.endedTracks
                self.statisticsTable.reloadData()
            } else {
                self.stackView.isHidden = false
                self.statisticsTable.isHidden = true
            }
        }
    }
    
    /// Метод, решающий, отображать таблицу со статистикой или нет
    @objc
    private func showStatistics() {
        statisticsViewModel.getStatistics()
    }
    
}

// MARK: - Расширение для UITableViewDataSource
extension StatisticsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statisticsCell", for: indexPath)
        guard let statisticsCell = cell as? StatisticsCell else { return UITableViewCell() }
        statisticsCell.numberLabel.text = "\(statisticsNumber)"
        return statisticsCell
    }
    
}

// MARK: - Расширение для UITableViewDelegate
extension StatisticsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
}
