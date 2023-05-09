import UIKit

/// Кастомная ячейка коллекции, используемая для отображения цветов
final class ColorCell: UICollectionViewCell {
    
    // MARK: - Свойства
    let color: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 6
        imageView.layer.masksToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        contentView.addSubview(color)
        NSLayoutConstraint.activate([
            color.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            color.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            color.heightAnchor.constraint(equalToConstant: 30),
            color.widthAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}
