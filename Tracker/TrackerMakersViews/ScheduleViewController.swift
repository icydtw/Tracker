import UIKit

/// Экран с выбором расписания
final class ScheduleViewController: UIViewController {
    
    // MARK: - Свойства
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("ScheduleViewController.title", comment: "Заголовок экрана")
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scheduleTable: UITableView = {
        let table = UITableView()
        table.register(ScheduleCell.self, forCellReuseIdentifier: "schedule")
        table.isScrollEnabled = false
        table.separatorStyle = .singleLine
        table.layer.cornerRadius = 16
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    let doneButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("Готово", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(doneButtonTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Методы
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    /// Настройка внешнего вида
    private func setupView() {
        selectedDays = []
        shortSelectedDays = []
        view.backgroundColor = .white
        scheduleTable.dataSource = self
        scheduleTable.delegate = self
        view.addSubview(titleLabel)
        view.addSubview(scheduleTable)
        view.addSubview(doneButton)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scheduleTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scheduleTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scheduleTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            scheduleTable.heightAnchor.constraint(equalToConstant: CGFloat(75 * daysOfWeek.count)),
            doneButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            doneButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            doneButton.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    /// Метод, вызываемый при нажатии на кнопку "Готово"
    @objc
    private func doneButtonTapped() {
        dismiss(animated: true)
    }
    
}

// MARK: - Расширение для UITableViewDataSource
extension ScheduleViewController: UITableViewDataSource {
    
    /// Метод создания и настройки ячейки таблицы
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schedule", for: indexPath)
        guard let scheduleCell = cell as? ScheduleCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        scheduleCell.title.text = daysOfWeek[indexPath.section].localizedString
        return scheduleCell
    }
    
    /// Метод, возвращающий количество строк в секции таблицы
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    /// Метод, возвращающий количество секций таблицы
    func numberOfSections(in tableView: UITableView) -> Int {
        return 7
    }

}

extension ScheduleViewController: UITableViewDelegate {
    
    /// Метод, определяющий высоту строки таблицы
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    /// Метод конфигурации ячеек перед их отображением
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.bounds.size.width)
        }
    }
    
}
