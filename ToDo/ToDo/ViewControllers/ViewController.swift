//
//import UIKit
//import CocoaLumberjack  // не знаю где использовать
//
//class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ToDoItemViewControllerDelegate {
//    
//    func didUpdateItem(_ item: TodoItem) {
//        self.list.addToDo(item)
//        self.updateTableView()
//    }
//    
//    func didDeleteItem(_ id: String) {
//        self.list.deleteToDo(id)
//        self.updateTableView()
//    }
//    
//    private var list = FileCache()
////    list.loadFromFile(paths: к)
//    private var listToDoTableHeightConstraint: NSLayoutConstraint?
//    private var hideDone = true
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        title = "Мои дела"
//        navigationController?.navigationBar.prefersLargeTitles = true
//        
//        view.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
//
//        view.addSubview(scrollView)
//        scrollView.addSubview(contentView)
//
//        contentView.addArrangedSubview(contentDoneView)
//        contentDoneView.addArrangedSubview(doneLabel)
//        contentDoneView.addArrangedSubview(showDoneButton)
//
//        contentView.addArrangedSubview(listToDoTable)
//
//        view.addSubview(addButton)
//
//        setupViewsConstraints()
//        
//        setupDoneViewConstraints()
//        setupAddButtonConstraints()
//        setuplistToDoTableConstraints()
//
//        updateDoneLabel()
//    }
//
//
//    func updateDoneLabel() {
//        let doneList = list.ListToDo.filter { $0.done }
//        let count = doneList.count
//        doneLabel.text = "Выполнено — \(count)"
//    }
//
//    
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
//        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
//        scrollView.isScrollEnabled = true
//        return scrollView
//    }()
//
//    private lazy var contentView: UIStackView = {
//        let contentView = UIStackView()
//        contentView.alignment = .fill
//        contentView.axis = .vertical
//        return contentView
//    }()
//
//    private lazy var contentDoneView: UIStackView = {
//        let contentDoneView = UIStackView()
//        contentDoneView.distribution = .equalCentering
//        contentDoneView.axis = .horizontal
//        return contentDoneView
//    }()
//
//    private let doneLabel: UILabel = {
//        let doneLabel = UILabel()
//        
//        doneLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
//        doneLabel.textColor = #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1)
//
//        return doneLabel
//    }()
//
//    private lazy var showDoneButton: UIButton = {
//        let showDoneButton = UIButton()
//        showDoneButton.setTitle("Показать", for: .normal)
//        showDoneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
//        showDoneButton.setTitleColor(#colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1), for: .normal)
//        showDoneButton.titleLabel?.textAlignment = .center
//        
//        showDoneButton.addTarget(self, action: #selector(showDoneButtonTapped), for: .touchUpInside)
//        
////        showDoneButton.isEnabled = false
//        return showDoneButton
//    }()
//
//    
//    
//    func tableView(_ listToDoTable: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if hideDone {
//            return list.ListToDo.filter({ !$0.done }).count
//        } else {
//            return list.ListToDo.count
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        if hideDone && list.ListToDo[indexPath.row].done == true {
//            return 0
//        } else if list.ListToDo[indexPath.row].deadline != nil {
//            return 66
//        } else {
//            return 56
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//        let doneAction = UIContextualAction(style: .normal, title: nil) { [self] (action, view, completion) in
//            let item = self.list.ListToDo[indexPath.row]
//            let temp = TodoItem(id: item.id, text: item.text, importance: item.importance, deadline: item.deadline, done: !(item.done), created: item.created, changed: Date())
//            self.list.addToDo(temp)
//            self.updateDoneLabel()
//            self.updateTableView()
//            
//            completion(true)
//        }
//        doneAction.image = UIImage(systemName:  "checkmark.circle.fill")
//        doneAction.backgroundColor = #colorLiteral(red: 0.2066814005, green: 0.7795598507, blue: 0.349144876, alpha: 1)
//        return UISwipeActionsConfiguration(actions: [doneAction])
//    }
//
//
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
//    -> UISwipeActionsConfiguration? {
//        let infoAction = UIContextualAction(style: .normal, title: "info") { (action, view, completion) in
//            let toDoItemViewController = ToDoItemViewController(item: self.list.ListToDo[indexPath.row])
//            toDoItemViewController.delegate = self
//            let navigationController = UINavigationController(rootViewController: toDoItemViewController)
//            self.present(navigationController, animated: true, completion: nil)
//            completion(true)
//        }
//        infoAction.image = UIImage(systemName: "info.circle")
//            
//        let deleteAction = UIContextualAction(style: .destructive, title: nil) { (_, _, completionHandler) in
//            self.list.deleteToDo(self.list.ListToDo[indexPath.row].id)
//            tableView.deleteRows(at: [indexPath], with: .right)
//            UIView.transition(with: self.listToDoTable,
//                              duration: 0.35,
//                              options: .curveEaseInOut,
//                              animations: { self.updateTableHeight() })
//            self.updateDoneLabel()
//        }
//        
//        deleteAction.image = UIImage(systemName: "trash")
//        let configuration = UISwipeActionsConfiguration(actions: [deleteAction, infoAction])
//        return configuration
//    }
//    
//    func tableView(_ listToDoTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        guard let cell = listToDoTable.dequeueReusableCell(withIdentifier: ListToDoTableCell.identifier, for: indexPath) as? ListToDoTableCell else {
//            return UITableViewCell()
//        }
//        let item = list.ListToDo[indexPath.row]
//        if hideDone && item.done {
//            cell.isHidden = true
//        } else {
//            cell.isHidden = false
//        }
//        
//        cell.item = item
//
//        cell.configure(with: item)
//        
//        return cell
//    }
//    
//    private lazy var newButton: UIButton = {
//        let newButton = UIButton()
//        newButton.setTitle("Новое", for: .normal)
//        newButton.setTitleColor(#colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1), for: .normal)
//        newButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//        newButton.contentHorizontalAlignment = .left
//        newButton.contentEdgeInsets = UIEdgeInsets(top: 16,left: 28,bottom: 16,right: 28)
//        return newButton
//    }()
//    
//    private lazy var listToDoTable: UITableView = {
//        let listToDoTable = UITableView()
//        listToDoTable.delegate = self
//        listToDoTable.dataSource = self
//        
//        listToDoTable.register(ListToDoTableCell.self, forCellReuseIdentifier: ListToDoTableCell.identifier)
//        listToDoTable.tableFooterView = newButton
//        listToDoTable.tableFooterView?.frame = CGRect(x: 0, y: 0, width: listToDoTable.frame.width, height: 56)
//        
//        listToDoTable.isScrollEnabled = false
//        listToDoTable.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        listToDoTable.layer.cornerRadius = 16
//        return listToDoTable
//    }()
//
//
//    private let addButton: UIButton = {
//        let addButton = UIButton()
//
//        addButton.setImage(UIImage(systemName: "plus.circle.fill")!.withTintColor(#colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)
//        addButton.imageView?.contentMode = .scaleAspectFit
//
//        addButton.layer.shadowColor = #colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1)
//        addButton.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
//        addButton.layer.shadowOpacity = 0.3
//        addButton.layer.shadowRadius = 20
//
//        addButton.imageView?.translatesAutoresizingMaskIntoConstraints = false
//        addButton.addConstraints([
//                NSLayoutConstraint(item: addButton.imageView!, attribute: .leading, relatedBy: .equal, toItem: addButton, attribute: .leading, multiplier: 1, constant: 0),
//                NSLayoutConstraint(item: addButton.imageView!, attribute: .trailing, relatedBy: .equal, toItem: addButton, attribute: .trailing, multiplier: 1, constant: 0),
//                NSLayoutConstraint(item: addButton.imageView!, attribute: .top, relatedBy: .equal, toItem: addButton, attribute: .top, multiplier: 1, constant: 0),
//                NSLayoutConstraint(item: addButton.imageView!, attribute: .bottom, relatedBy: .equal, toItem: addButton, attribute: .bottom, multiplier: 1, constant: 0)
//            ])
//
//
//        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
//        return addButton
//    }()
//}
//
//extension ViewController {
//    @objc func addButtonTapped() {
//        let toDoItemViewController = ToDoItemViewController(item: nil)
//        let navigationController = UINavigationController(rootViewController: toDoItemViewController)
//        toDoItemViewController.delegate = self
//        present(navigationController, animated: true, completion: nil)
//    }
//    
//    private func updateTableHeight() {
//        var deadlineCount = list.ListToDo.filter { $0.deadline != nil }.count
//        var count = list.ListToDo.filter { $0.deadline == nil }.count
//        if hideDone {
//            deadlineCount -= list.ListToDo.filter { $0.deadline != nil && $0.done }.count
//            count -= list.ListToDo.filter { $0.deadline == nil && $0.done }.count
//        }
//        
//        let height = CGFloat(deadlineCount * 66 + (count + 1) * 56)
//        
//        listToDoTableHeightConstraint?.constant = height
//        
//        view.layoutIfNeeded()
//    }
//    
//    @objc func showDoneButtonTapped() {
//        hideDone = !hideDone
//        if hideDone {
//            showDoneButton.setTitle("Показать", for: .normal)
//        } else {
//            showDoneButton.setTitle("Скрыть", for: .normal)
//        }
//        self.updateTableView()
//    }
//    
//    func updateTableView() {
//        self.listToDoTable.reloadData()
//        self.updateTableHeight()
//    }
//}
//
//extension ViewController {
//    
//    private func setupViewsConstraints() {
//        scrollView.showsHorizontalScrollIndicator = false
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            
//            
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
//            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -78),
//            contentView.widthAnchor.constraint(equalToConstant: view.frame.size.width - 32)
//        ])
//    }
//    
//    private func setupDoneViewConstraints() {
//        contentDoneView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            contentDoneView.topAnchor.constraint(equalTo: contentView.topAnchor),
//            contentDoneView.heightAnchor.constraint(equalToConstant: 44)
//        ])
//    }
//
//    private func setupAddButtonConstraints() {
//        addButton.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            addButton.widthAnchor.constraint(equalToConstant: 44),
//            addButton.heightAnchor.constraint(equalToConstant: 44),
//            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
//        ])
//    }
//
//    private func setuplistToDoTableConstraints() {
//        listToDoTable.translatesAutoresizingMaskIntoConstraints = false
//
//        let bottomConstraint = listToDoTable.bottomAnchor.constraint(equalTo: newButton.bottomAnchor)
//        bottomConstraint.isActive = true
//        
//        var deadlineCount = list.ListToDo.filter { $0.deadline != nil }.count
//        var count = list.ListToDo.filter { $0.deadline == nil }.count
//        if hideDone {
//            deadlineCount -= list.ListToDo.filter { $0.deadline != nil && $0.done }.count
//            count -= list.ListToDo.filter { $0.deadline == nil && $0.done }.count
//        }
//        
//        let height = CGFloat(deadlineCount * 66 + (count + 1) * 56)
//        
//        let heightConstraint = listToDoTable.heightAnchor.constraint(equalToConstant: height)
//        heightConstraint.isActive = true
//        listToDoTableHeightConstraint = heightConstraint
//
//        
//        NSLayoutConstraint.activate([
//            listToDoTable.widthAnchor.constraint(equalTo: contentView.widthAnchor)
//        ])
//    }
//}
