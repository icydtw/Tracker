import UIKit

/// Ячейка трекеров, отображающаяся на вкладке "Трекеры"
final class TrackersCellsViewController: UICollectionViewCell {
    
    // MARK: - Свойства
    var emoji: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        return label
    }()
    
    var textBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 12
        return view
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    // MARK: - Инициализатор
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Настройка внешнего вида
    private func setupView() {
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true
        //contentView.addSubview(emoji)
        contentView.addSubview(name)
        textBackground.addSubview(emoji)
        contentView.addSubview(textBackground)
        NSLayoutConstraint.activate([
            textBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            textBackground.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            textBackground.heightAnchor.constraint(equalToConstant: 24),
            textBackground.widthAnchor.constraint(equalToConstant: 24),
            emoji.centerXAnchor.constraint(equalTo: textBackground.centerXAnchor),
            emoji.centerYAnchor.constraint(equalTo: textBackground.centerYAnchor),
            name.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            name.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
}
