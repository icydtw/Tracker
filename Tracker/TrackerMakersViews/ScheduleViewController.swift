//
//  ScheduleViewController.swift
//  Tracker
//
//  Created by Илья Тимченко on 27.04.2023.
//

import UIKit

final class ScheduleViewController: UIViewController {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Расписание"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let scheduleTable: UITableView = {
        let table = UITableView()
        table.register(ScheduleCellsViewController.self, forCellReuseIdentifier: "schedule")
        table.isScrollEnabled = false
        table.separatorStyle = .singleLine
        table.layer.cornerRadius = 16
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScheduleViewController()
    }
    
    private func setupScheduleViewController() {
        
        view.backgroundColor = .white
        
        scheduleTable.dataSource = self
        scheduleTable.delegate = self
        
        view.addSubview(titleLabel)
        view.addSubview(scheduleTable)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 27),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            scheduleTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            scheduleTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            scheduleTable.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 38),
            scheduleTable.heightAnchor.constraint(equalToConstant: CGFloat(75 * daysOfWeek.count))
        ])
        
    }
    
}

extension ScheduleViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "schedule", for: indexPath)
        guard let scheduleCell = cell as? ScheduleCellsViewController else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        scheduleCell.title.text = daysOfWeek[indexPath.row].rawValue
        return scheduleCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tableView.numberOfRows(inSection: 0) - 1 {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: cell.bounds.size.width)
        }
    }
    
}

extension ScheduleViewController: UITableViewDelegate {
    
}
