import UIKit

/// Ячейка таблицы выбора расписания
final class ScheduleCellsViewController: UITableViewCell {
    
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
        return switcher
    }()
    
    // MARK: - Инициализатор
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Настройка внешнего вида
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
    
}
