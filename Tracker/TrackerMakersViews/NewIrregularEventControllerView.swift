//
//  NewIrregularEventControllerView.swift
//  Tracker
//
//  Created by Илья Тимченко on 16.04.2023.
//

import UIKit

final class NewIrregularEventControllerView: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupIrregularViewController()
    }
    
    private func setupIrregularViewController() {
        view.backgroundColor = .white
        
        let titleLabel: UILabel = {
            let label = UILabel()
            label.text = "Новое нерегулярное событие"
            label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let enterNameTextField: UITextField = {
            let field = UITextField()
            field.placeholder = "Введите название трекера"
            field.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
            field.layer.cornerRadius = 16
            field.translatesAutoresizingMaskIntoConstraints = false
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: field.frame.height))
            field.leftView = paddingView
            field.leftViewMode = .always
            return field
        }()
        
        let categoriesButton: UIButton = {
            let button = UIButton(type: .system)
            button.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
            button.layer.cornerRadius = 16
            button.setTitle("Категория", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.setImage(UIImage(named: "arrow"), for: .normal)
            button.semanticContentAttribute = .forceRightToLeft
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            button.tintColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
            button.contentHorizontalAlignment = .left
            return button
        }()
        
        let emojiTitle: UILabel = {
            let title = UILabel()
            title.text = "Emoji"
            title.font = UIFont.systemFont(ofSize: 19, weight: .bold)
            title.translatesAutoresizingMaskIntoConstraints = false
            return title
        }()
        
        let emojiCollection: UICollectionView = {
            let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
            collection.translatesAutoresizingMaskIntoConstraints = false
            collection.delegate = self
            collection.dataSource = self
            return collection
        }()
        
        view.addSubview(titleLabel)
        view.addSubview(enterNameTextField)
        view.addSubview(categoriesButton)
        view.addSubview(emojiTitle)
        view.addSubview(emojiCollection)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterNameTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            enterNameTextField.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            enterNameTextField.heightAnchor.constraint(equalToConstant: 75),
            enterNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoriesButton.topAnchor.constraint(equalTo: enterNameTextField.bottomAnchor, constant: 24),
            categoriesButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            categoriesButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            categoriesButton.heightAnchor.constraint(equalToConstant: 75),
            emojiTitle.topAnchor.constraint(equalTo: categoriesButton.bottomAnchor, constant: 32),
            emojiTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 28),
            emojiCollection.leadingAnchor.constraint(equalTo: emojiTitle.leadingAnchor),
            emojiCollection.topAnchor.constraint(equalTo: emojiTitle.bottomAnchor, constant: 31),
            emojiCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28),
            emojiCollection.heightAnchor.constraint(equalToConstant: 150)
        ])
        
        emojiCollection.register(EmojiCellsViewController.self, forCellWithReuseIdentifier: "emojiCell")

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        emojiCollectionData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath) as? EmojiCellsViewController
        cell?.emojiLabel.text = emojiCollectionData[indexPath.row]
        return cell!
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.bounds.width-56) / 6, height: 50)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
}
