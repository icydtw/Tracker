import UIKit

/// Ячейка таблицы, отображающая информацию о категории при создании привычки
final class HabitCategoryCellsViewController: UITableViewCell {
    
    // MARK: - Свойства
    let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrow")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    var categoryName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
        contentView.addSubview(title)
        contentView.addSubview(arrow)
        contentView.addSubview(categoryName)
        contentView.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            arrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
