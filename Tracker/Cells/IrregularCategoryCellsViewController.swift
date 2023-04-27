import UIKit

/// Ячейка таблицы, отображающая информацию о категории при создании нерегулярного события
final class IrregularCategoryCellsViewController: UITableViewCell {
    
    // MARK: - Свойства
    let title: UILabel = {
        let label = UILabel()
        label.text = "Категория"
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var categoryName: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .regular)
        label.textColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let arrow: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "arrow")
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
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
        NotificationCenter.default.addObserver(self, selector: #selector(showCategory), name: Notification.Name("category_changed"), object: nil)
        contentView.addSubview(title)
        contentView.addSubview(categoryName)
        contentView.addSubview(arrow)
        contentView.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
        contentView.layer.cornerRadius = 16
        NSLayoutConstraint.activate([
            title.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            arrow.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -24),
            arrow.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    // MARK: - Изменение констрейнтов и свойств ячейки с категорией (при срабатывании нотификации)
    @objc
    private func showCategory() {
        title.removeFromSuperview()
        contentView.addSubview(title)
        NSLayoutConstraint.activate([
            title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            categoryName.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 2),
            categoryName.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
        ])
        contentView.layoutIfNeeded()
        contentView.updateConstraints()
    }
    
}
