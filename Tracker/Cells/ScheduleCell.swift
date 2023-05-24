import UIKit

/// Ячейка таблицы выбора расписания
final class ScheduleCell: UITableViewCell {
    
    // MARK: - Свойства
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let switcher: UISwitch = {
        let switcher = UISwitch()
        switcher.tintColor = .gray
        switcher.thumbTintColor = .white
        switcher.onTintColor = UIColor(red: 0.216, green: 0.447, blue: 0.906, alpha: 1)
        switcher.translatesAutoresizingMaskIntoConstraints = false
        switcher.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        return switcher
    }()
    
    // MARK: - Методы
    /// Инициализатор
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Настройка внешнего вида
    private func setupView() {
        contentView.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
        contentView.addSubview(title)
        contentView.addSubview(switcher)
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            switcher.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            switcher.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    /// Метод, добавляющий и удаляющий из selectedDays элементы при активации/деактивации switcher
    @objc
    private func switchChanged() {
        if switcher.isOn {
            selectedDays.append(title.text ?? "")
            switch title.text {
            case dayOfWeek.monday.rawValue: shortSelectedDays.append("ПН")
            case dayOfWeek.tuesday.rawValue: shortSelectedDays.append("ВТ")
            case dayOfWeek.wednesday.rawValue: shortSelectedDays.append("СР")
            case dayOfWeek.thursday.rawValue: shortSelectedDays.append("ЧТ")
            case dayOfWeek.friday.rawValue: shortSelectedDays.append("ПТ")
            case dayOfWeek.saturday.rawValue: shortSelectedDays.append("СБ")
            case dayOfWeek.sunday.rawValue: shortSelectedDays.append("ВС")
            case .none:
                return
            case .some(_):
                return
            }
            let notification = Notification(name: Notification.Name("schedule_changed"))
            NotificationCenter.default.post(notification)
        } else {
            selectedDays.removeAll { $0 == title.text }
        }
    }
    
}
