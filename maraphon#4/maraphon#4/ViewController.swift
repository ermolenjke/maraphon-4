//
//  ViewController.swift
//  maraphon#4
//
//  Created by Даниил Ермоленко on 11.05.2023.
//

import UIKit

class ViewController: UIViewController {
    
    struct Item {
        let number: Int
        var isSelected: Bool
    }
    
    var items = [Item]()
    var tableView = UITableView(frame: .zero, style: .insetGrouped)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupNavBar()
        
        for i in 0...40 {
            items.append(.init(number: i, isSelected: false))
        } 
    }
    
    func setupNavBar() {
        
        self.title = "4"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Shuffle", style: .done, target: self, action: #selector(shuffle))
        self.navigationItem.rightBarButtonItem?.tintColor = .systemBlue
    }
    
    func setupTableView() {
        
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
    }
    
    @objc
    func shuffle() {
        self.items.shuffle()
        tableView.beginUpdates()
        self.tableView.reloadRows(at: items.map{IndexPath(row: $0.number, section: 0)}, with: .bottom)
         tableView.endUpdates()
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  UITableViewCell(style: .value1, reuseIdentifier: "cell")
        cell.textLabel?.text = items[indexPath.row].number.description
        cell.accessoryType = items[indexPath.row].isSelected ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        items[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .none)
        if items[indexPath.row].isSelected {
            tableView.moveRow(at: indexPath, to: IndexPath(row: 0, section: 0))
            items.insert(items[indexPath.row], at: 0)
            items.remove(at: indexPath.row + 1)
        } else {
            tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
