import UIKit

/// Кастомная ячейка коллекции, используемая для отображения emoji
final class EmojiCell: UICollectionViewCell {
    
    // MARK: - Свойства
    let emojiLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 38)
        return label
    }()
    
    // MARK: - Методы
    /// Инициализатор
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    override var isSelected: Bool {
//        didSet {
//            if isSelected {
//                contentView.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 1)
//                contentView.layer.cornerRadius = 16
//                contentView.layer.masksToBounds = true
//            }
//        }
//    }
    
    /// Настройка внешнего вида
    private func setupView() {
        contentView.addSubview(emojiLabel)
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            emojiLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            emojiLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
}
