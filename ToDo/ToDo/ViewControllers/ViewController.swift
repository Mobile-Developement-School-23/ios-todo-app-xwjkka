
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var list = FileCache()
//    var count: Int
    
//    init(list: FileCache = FileCache()) {
////        self.count = 0
//        self.list = list
//    }
    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        list.addToDo(TodoItem(text: "haha", importance: Importance.regular, done: true, created: Date()))
        list.addToDo(TodoItem(text: "not haha", importance: Importance.regular, created: Date()))
        list.addToDo(TodoItem(text: "haha", importance: Importance.regular, created: Date()));
        list.addToDo(TodoItem(text: "not haha", importance: Importance.regular, created: Date()));
        list.addToDo(TodoItem(text: "haha", importance: Importance.regular, created: Date()));
        list.addToDo(TodoItem(text: "not haha", importance: Importance.regular, created: Date()));        list.addToDo(TodoItem(text: "haha", importance: Importance.regular, created: Date()));
        list.addToDo(TodoItem(text: "not haha", importance: Importance.regular, created: Date()));        list.addToDo(TodoItem(text: "haha", importance: Importance.regular, created: Date()));
        
        title = "Мои дела"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        view.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(contentDoneView)
        contentDoneView.addArrangedSubview(doneLabel)
        contentDoneView.addArrangedSubview(showDoneButton)

        contentView.addSubview(listToDoTable)

        view.addSubview(addButton)

        setupViewsConstraints()
        
        setupDoneViewConstraints()
        setupAddButtonConstraints()
        setuplistToDoTableConstraints()

    }


    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
        scrollView.frame = view.bounds
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame = scrollView.frame
        return contentView
    }()

    private lazy var contentDoneView: UIStackView = {
        let contentDoneView = UIStackView()
        contentDoneView.axis = .horizontal
        return contentDoneView
    }()


//    func countDone() -> Int {
//        var count = 0
//        for item in list.ListToDo {
//            if item.done {
//                count += 1
//            }
//        }
//        return count
//    }
//    func countDone() {
//        count = 0
//        for item in list.ListToDo {
//            if item.done {
//                count += 1
//            }
//        }
//    }
    
    private let doneLabel: UILabel = {
        let doneLabel = UILabel()
        
//        countDone()
        doneLabel.text = "Выполнено - " + String(0)
        doneLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        doneLabel.textColor = #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1)

        return doneLabel
    }()

    private lazy var showDoneButton: UIButton = {
        let showDoneButton = UIButton()
        showDoneButton.setTitle("Показать", for: .normal)
        showDoneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        showDoneButton.setTitleColor(#colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1), for: .normal)
        showDoneButton.titleLabel?.textAlignment = .center
        return showDoneButton
    }()

    
    
    func tableView(_ listToDoTable: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.ListToDo.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ listToDoTable: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = list.ListToDo[indexPath.row]
        let cell = listToDoTable.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let textLabel = UILabel()
        if item.done {
            textLabel.text = item.text
            textLabel.textColor = #colorLiteral(red: 0.8196074367, green: 0.8196083307, blue: 0.8411096334, alpha: 1)
            textLabel.font = UIFont.systemFont(ofSize: 17)
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item.text)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            textLabel.attributedText = attributeString

        } else {
            textLabel.text = item.text
        }
        
        let arrow = UIImage(systemName: "chevron.right", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))!.withTintColor(#colorLiteral(red: 0.5520535111, green: 0.5570273995, blue: 0.5741342902, alpha: 1), renderingMode: .alwaysOriginal)
        let arrowView = UIImageView(image: arrow)
        arrowView.contentMode = .scaleAspectFit
        
        cell.contentView.addSubview(textLabel)
        cell.contentView.addSubview(arrowView)
        
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        arrowView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 26),
            textLabel.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            
            arrowView.rightAnchor.constraint(equalTo: cell.contentView.rightAnchor, constant: -26),
            arrowView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            arrowView.widthAnchor.constraint(equalToConstant: 10),
            arrowView.heightAnchor.constraint(equalToConstant: 15)
        ])

        return cell
    }
    
    private lazy var newButton: UIButton = {
        let newButton = UIButton()
        newButton.setTitle("Новое", for: .normal)
        newButton.setTitleColor(#colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1), for: .normal)
        newButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        newButton.contentHorizontalAlignment = .left
        newButton.contentEdgeInsets = UIEdgeInsets(top: 16,left: 28,bottom: 16,right: 28)
        return newButton
    }()
    
    private lazy var listToDoTable: UITableView = {
        let listToDoTable = UITableView()
        listToDoTable.delegate = self
        listToDoTable.dataSource = self
        listToDoTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        listToDoTable.tableFooterView = newButton
        listToDoTable.tableFooterView?.frame = CGRect(x: 0, y: 0, width: listToDoTable.frame.width, height: 56)
        
//        listToDoTable.isScrollEnabled = false
        listToDoTable.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        listToDoTable.layer.cornerRadius = 16
        return listToDoTable
    }()


    private let addButton: UIButton = {
        let addButton = UIButton()

        addButton.setImage(UIImage(systemName: "plus.circle.fill")!.withTintColor(#colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1), renderingMode: .alwaysOriginal), for: .normal)

        addButton.layer.shadowColor = #colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1)
        addButton.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        addButton.layer.shadowOpacity = 0.3
        addButton.layer.shadowRadius = 20


        addButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return addButton
    }()
}

extension ViewController {
    @objc func addButtonTapped() {
        let toDoTaskViewController = UINavigationController(rootViewController: ToDoItemViewController())
        present(toDoTaskViewController, animated: true, completion: nil)
    }
}

extension ViewController {

    
    private func setupViewsConstraints() {
        scrollView.showsHorizontalScrollIndicator = false
        
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
//            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
//            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//        ])
    }
    
    private func setupDoneViewConstraints() {
        contentDoneView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentDoneView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentDoneView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 26),
            contentDoneView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -26)
        ])
    }

    private func setupAddButtonConstraints() {
        addButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.widthAnchor.constraint(equalToConstant: 44),
            addButton.heightAnchor.constraint(equalToConstant: 44),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
        ])
    }

    private func setuplistToDoTableConstraints() {
        listToDoTable.translatesAutoresizingMaskIntoConstraints = false

        let bottomConstraint = listToDoTable.bottomAnchor.constraint(equalTo: newButton.topAnchor)
        bottomConstraint.priority = UILayoutPriority(rawValue: 999)
        bottomConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            listToDoTable.topAnchor.constraint(equalTo: contentDoneView.bottomAnchor, constant: 12),
            listToDoTable.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            listToDoTable.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            listToDoTable.heightAnchor.constraint(equalToConstant: CGFloat((list.ListToDo.count + 1) * 56))
        ])
    }
    
}
