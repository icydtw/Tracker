import UIKit

/// Ячейка трекеров, отображающаяся на вкладке "Трекеры"
final class TrackersCell: UICollectionViewCell {
    
    // MARK: - Свойства
    var delegate: TrackersViewControllerProtocol?
    
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
    
    var viewBackground: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.masksToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var name: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .white
        return label
    }()
    
    var quantity: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    var plusButton: UIButton = {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        button.layer.cornerRadius = button.bounds.size.width / 2
        button.layer.masksToBounds = true
        let image = UIImage(systemName: "plus")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(plusTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // MARK: - Методы
    /// Инициализатор
    override init(frame: CGRect) {
        super.init(frame: frame)
        //delegate = TrackersViewController()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Настройка внешнего вида
    private func setupView() {
        textBackground.addSubview(emoji)
        viewBackground.addSubview(name)
        viewBackground.addSubview(textBackground)
        contentView.addSubview(viewBackground)
        contentView.addSubview(quantity)
        contentView.addSubview(plusButton)
        NSLayoutConstraint.activate([
            viewBackground.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewBackground.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewBackground.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewBackground.heightAnchor.constraint(equalToConstant: 90),
            textBackground.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: 12),
            textBackground.topAnchor.constraint(equalTo: viewBackground.topAnchor, constant: 12),
            textBackground.heightAnchor.constraint(equalToConstant: 24),
            textBackground.widthAnchor.constraint(equalToConstant: 24),
            emoji.centerXAnchor.constraint(equalTo: textBackground.centerXAnchor),
            emoji.centerYAnchor.constraint(equalTo: textBackground.centerYAnchor),
            name.centerXAnchor.constraint(equalTo: viewBackground.centerXAnchor),
            name.leadingAnchor.constraint(equalTo: viewBackground.leadingAnchor, constant: 12),
            name.bottomAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: -12),
            plusButton.topAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: 8),
            plusButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            plusButton.heightAnchor.constraint(equalToConstant: 34),
            plusButton.widthAnchor.constraint(equalToConstant: 34),
            quantity.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            quantity.topAnchor.constraint(equalTo: viewBackground.bottomAnchor, constant: 16),
            quantity.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ])
        let interaction = UIContextMenuInteraction(delegate: self)
        self.viewBackground.addInteraction(interaction)
    }
    
    /// Метод, вызываемый при нажатии на "+" в ячейке
    @objc
    private func plusTapped() {
        guard let collectionView = superview as? UICollectionView,
              let indexPath = collectionView.indexPath(for: self) else {
            return
        }
        guard let tappedID = (delegate?.filteredTrackers[indexPath.section].trackers[indexPath.row].id) else {
            return
        }
        delegate?.saveDoneEvent(id: tappedID, index: indexPath)
        collectionView.reloadData()
    }
    
}

// MARK: - Расширение для UIContextMenuInteractionDelegate
extension TrackersCell: UIContextMenuInteractionDelegate {
    
    /// Метод, управляющий контекстным меню
    func contextMenuInteraction(_ interaction: UIContextMenuInteraction, configurationForMenuAtLocation location: CGPoint) -> UIContextMenuConfiguration? {
        guard let collectionView = superview as? UICollectionView,
              let indexPath = collectionView.indexPath(for: self) else {
            return UIContextMenuConfiguration()
        }
        guard let tappedID = (delegate?.filteredTrackers[indexPath.section].trackers[indexPath.row].id) else {
            return UIContextMenuConfiguration()
        }
        let configuration = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { _ in
            // Закрепление
            var pinAction = UIAction(title: NSLocalizedString("Touch.pin", comment: ""), image: nil) { _ in
                guard let oldCategory = self.delegate?.filteredTrackers[indexPath.section].label,
                      let eventToPin = self.delegate?.filteredTrackers[indexPath.section].trackers[indexPath.row] else { return }
                self.delegate?.trackersViewModel.pinEvent(oldCategory: oldCategory, eventToPin: eventToPin, categoryViewModel: self.delegate?.categoryViewModel ?? CategoryViewModel())
            }
            // Открепление
            if self.delegate?.filteredTrackers[indexPath.section].label == NSLocalizedString("TrackersViewController.pinned", comment: "Закреплённые") {
                pinAction = UIAction(title: NSLocalizedString("Touch.unpin", comment: ""), image: nil) { _ in
                    guard let eventToUnPin = self.delegate?.filteredTrackers[indexPath.section].trackers[indexPath.row] else { return }
                    self.delegate?.trackersViewModel.unpinEvent(eventToUnpin: eventToUnPin, categoryViewModel: self.delegate?.categoryViewModel ?? CategoryViewModel())
                }
            }
            // Редактирование
            let editAction = UIAction(title: "Редактировать", image: nil) { _ in
                guard let eventToEdit = self.delegate?.filteredTrackers[indexPath.section].trackers[indexPath.row] else { return }
                let showEditView = NewIrregularEventViewController(categoryViewModel: self.delegate?.categoryViewModel ?? CategoryViewModel(), trackersViewModel: self.delegate?.trackersViewModel ?? TrackersViewModel(), eventToEdit: eventToEdit)
                self.delegate?.present(VC: showEditView)
            }
            // Удаление
            let deleteAction = UIAction(title: NSLocalizedString("Touch.delete", comment: ""), image: nil) { _ in
                self.delegate?.trackersViewModel.deleteTracker(id: tappedID)
            }
            deleteAction.attributes = .destructive
            return UIMenu(title: "", children: [pinAction, editAction, deleteAction])
        }
        return configuration
    }


}
