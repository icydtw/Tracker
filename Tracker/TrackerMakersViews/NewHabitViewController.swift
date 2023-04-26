//
//  NewHabitViewController.swift
//  Tracker
//
//  Created by Илья Тимченко on 16.04.2023.
//

import UIKit

final class NewHabitViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UITableViewDataSource, UITableViewDelegate {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Новая привычка"
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
    
    let categoriesTable: UITableView = {
        let table = UITableView()
        table.register(HabitCategoryCellsViewController.self, forCellReuseIdentifier: "category")
        table.isScrollEnabled = false
        table.separatorStyle = .singleLine
        table.layer.cornerRadius = 16
        table.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 0.3)
        return table
    }()
    
    let firstStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .fill
        stack.distribution = .fill
        stack.spacing = 8.0
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let colorCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(ColorCellsViewController.self, forCellWithReuseIdentifier: "colorCell")
        collection.register(EmojiHeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return collection
    }()
    
    let emojiCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(EmojiCellsViewController.self, forCellWithReuseIdentifier: "emojiCell")
        collection.register(EmojiHeaderSupplementaryView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        return collection
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Отменить", for: .normal)
        button.setTitleColor(UIColor(red: 0.961, green: 0.42, blue: 0.424, alpha: 1), for: .normal)
        button.layer.borderColor = UIColor(red: 0.961, green: 0.42, blue: 0.424, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(nil, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    let createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Создать", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 0.682, green: 0.686, blue: 0.706, alpha: 1)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(nil, action: #selector(create), for: .touchUpInside)
        
        return button
    }()
    
    let secondStack: UIStackView = {
        let stack = UIStackView()
        
        stack.axis = .horizontal
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.spacing = 24
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let scroll: UIScrollView = {
        let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.indicatorStyle = .white
        return scroll
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHabitViewController()
    }
    
    private func setupHabitViewController() {
        view.backgroundColor = .white
        
        firstStack.addArrangedSubview(enterNameTextField)
        firstStack.addArrangedSubview(categoriesTable)
        secondStack.addArrangedSubview(cancelButton)
        secondStack.addArrangedSubview(createButton)
        
        scroll.addSubview(firstStack)
        scroll.addSubview(emojiCollection)
        scroll.addSubview(colorCollection)
        scroll.addSubview(secondStack)
        
        view.addSubview(titleLabel)
        
        view.addSubview(scroll)
        
        scroll.contentSize = CGSize(width: view.frame.width, height: 779)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scroll.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            enterNameTextField.heightAnchor.constraint(equalToConstant: 71),

            firstStack.topAnchor.constraint(equalTo: scroll.topAnchor, constant: 24),
            firstStack.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            firstStack.heightAnchor.constraint(equalToConstant: 225),
            firstStack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 16),

            emojiCollection.topAnchor.constraint(equalTo: firstStack.bottomAnchor, constant: 24),
            emojiCollection.heightAnchor.constraint(equalToConstant: 200),
            emojiCollection.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 16),
            emojiCollection.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            emojiCollection.widthAnchor.constraint(equalTo: firstStack.widthAnchor),

            colorCollection.topAnchor.constraint(equalTo: emojiCollection.bottomAnchor),
            colorCollection.heightAnchor.constraint(equalToConstant: 200),
            colorCollection.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 16),
            colorCollection.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            colorCollection.widthAnchor.constraint(equalTo: firstStack.widthAnchor),

            secondStack.heightAnchor.constraint(equalToConstant: 60),
            secondStack.leadingAnchor.constraint(equalTo: scroll.leadingAnchor, constant: 28),
            secondStack.centerXAnchor.constraint(equalTo: scroll.centerXAnchor),
            secondStack.topAnchor.constraint(equalTo: colorCollection.bottomAnchor, constant: 24),
        ])
        
        categoriesTable.dataSource = self
        categoriesTable.delegate = self
        colorCollection.delegate = self
        colorCollection.dataSource = self
        emojiCollection.delegate = self
        emojiCollection.dataSource = self
        enterNameTextField.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "category", for: indexPath)
        guard let categoryCell = cell as? HabitCategoryCellsViewController else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        switch indexPath.row {
        case 0:
            categoryCell.title.text = "Категория"
        default:
            categoryCell.title.text = "Расписание"
        }
        return categoryCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 71
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.bounds.size.width)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == colorCollection {
            return colorCollectionData.count
        } else {
            return emojiCollectionData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == colorCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "colorCell", for: indexPath) as? ColorCellsViewController
            cell?.color.backgroundColor = colorCollectionData[indexPath.row]
            return cell!
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emojiCell", for: indexPath) as? EmojiCellsViewController
            cell?.emojiLabel.text = emojiCollectionData[indexPath.row]
            return cell!
        }
        
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if collectionView == colorCollection {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! EmojiHeaderSupplementaryView
            header.title.text = "Цвет"
            return header
        } else {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! EmojiHeaderSupplementaryView
            header.title.text = "Emoji"
            return header
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: 40)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
        if collectionView == colorCollection {
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCellsViewController
            cell?.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 1)
            cell?.layer.cornerRadius = 16
            cell?.layer.masksToBounds = true
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as? EmojiCellsViewController
            cell?.backgroundColor = UIColor(red: 0.902, green: 0.91, blue: 0.922, alpha: 1)
            cell?.layer.cornerRadius = 16
            cell?.layer.masksToBounds = true
        }
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        
        if collectionView == colorCollection {
            let cell = collectionView.cellForItem(at: indexPath) as? ColorCellsViewController
            cell?.backgroundColor = UIColor.clear
        } else {
            let cell = collectionView.cellForItem(at: indexPath) as? EmojiCellsViewController
            cell?.backgroundColor = UIColor.clear
        }
    }
    
    @objc
    private func cancel() {
        dismiss(animated: true)
    }
    
    @objc
    func create() {
        let name = enterNameTextField.text ?? ""
        let category = categoryName
        let emojiIndex = emojiCollection.indexPathsForSelectedItems?.first
        let emoji = emojiCollectionData[emojiIndex?.row ?? 0]
        let colorIndex = colorCollection.indexPathsForSelectedItems?.first
        let color = colorCollectionData[colorIndex?.row ?? 0]
        let day = dayOfWeek.wednesday
        let event = IrregularEvent(name: name, category: category, emoji: emoji, color: color, day: day)
        events.append(event)
        let notification = Notification(name: Notification.Name("addEvent"))
        NotificationCenter.default.post(notification)
        categoryName = ""
        dismiss(animated: true)
    }
    
}

extension NewHabitViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
