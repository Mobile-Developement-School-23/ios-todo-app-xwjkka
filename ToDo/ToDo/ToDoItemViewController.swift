import UIKit


class ToDoItemViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
//    var item: TodoItem
    var deadline = false
    var deadlineDate: Date? = nil
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if deadline {
            return 3
        } else {
            return 2
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithSegmentedControl", for: indexPath)
            cell.textLabel?.text = "Важность"
            let segmentedControl = UISegmentedControl(items: ["1", "2", "3"])
            segmentedControl.frame = CGRect(x: 10, y: 10, width: 150, height: 36)
            cell.contentView.addSubview(segmentedControl)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithCheckbox", for: indexPath)
            cell.textLabel?.text = "Сделать до"
            let checkbox = UISwitch(frame: CGRect.zero)
            checkbox.isOn = deadline
            checkbox.addTarget(self, action: #selector(deadlineCheckboxValueChanged), for: .valueChanged)
            cell.accessoryView = checkbox
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithSegmentedControl", for: indexPath)
            let segmentedControl = UISegmentedControl(items: ["1", "2", "3"])
            segmentedControl.frame = CGRect(x: 10, y: 10, width: cell.contentView.frame.width - 20, height: 56)
            cell.contentView.addSubview(segmentedControl)
            return cell
        }
    }
    
    // MARK: - UINavigationBar

    private lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.size.width, height: 44))
        navBar.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)

        let navItem = UINavigationItem(title: "Дело")

        let rightBarButton = UIBarButtonItem(title: "Сохранить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.myRightSideBarButtonItemTapped(_:)))

        let leftBarButton = UIBarButtonItem(title: "Отменить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.myLeftSideBarButtonItemTapped(_:)))

        navItem.rightBarButtonItem = rightBarButton
        navItem.leftBarButtonItem = leftBarButton

        navBar.setItems([navItem], animated: false)

        return navBar
    }()



    // MARK: - Content
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
        scrollView.frame = view.bounds
        return scrollView
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 16


//        stackView.backgroundColor = .red

        return stackView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textView.layer.cornerRadius = 16

        textView.text = "Что надо сделать?"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 16, bottom: 17, right: 16)
        textView.delegate = self
        return textView
    }()

    
    private lazy var formTable: UITableView  = {
        let formTable = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height), style: .plain)

        formTable.delegate = self
        formTable.dataSource = self

        formTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        formTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellWithSegmentedControl")
        formTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellWithCheckbox")
        formTable.register(UITableViewCell.self, forCellReuseIdentifier: "cellWithCalendar")

        
        formTable.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        formTable.layer.cornerRadius = 16

        formTable.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        return formTable
    }()
    
    private lazy var deleteButton: UIButton  = {
        let deleteButton = UIButton()
        deleteButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        deleteButton.layer.cornerRadius = 16
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(.gray, for: .disabled)
        deleteButton.setTitleColor(.red, for: .normal)

        return deleteButton
    }()



    // MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)

        scrollView.addSubview(stackView)

        stackView.addSubview(textView)
        stackView.addSubview(formTable)
        stackView.addSubview(deleteButton)

        view.addSubview(navBar)

        textView.delegate = self

        setupViewsConstraints()
    }

    
    // MARK: - Actions
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }

        textView.becomeFirstResponder()
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Что надо сделать?"
            textView.textColor = UIColor.lightGray
        }
        textView.resignFirstResponder()
    }

    @objc func myRightSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        print("myRightSideBarButtonItemTapped")
    }

    @objc func myLeftSideBarButtonItemTapped(_ sender:UIBarButtonItem!)
    {
        print("myLeftSideBarButtonItemTapped")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func deadlineCheckboxValueChanged(sender: UISwitch) {
        deadline = sender.isOn
        if deadline {
            formTable.insertRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
        } else {
            deadlineDate = nil
            formTable.deleteRows(at: [IndexPath(row: 2, section: 0)], with: .fade)
        }
    }


}

    // MARK: - Constraints

extension ToDoItemViewController {
    private func setupViewsConstraints() {
        scrollView.showsHorizontalScrollIndicator = false

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false

        textView.translatesAutoresizingMaskIntoConstraints = false
        formTable.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            stackView.widthAnchor.constraint(equalToConstant: scrollView.frame.width - 32),
            stackView.heightAnchor.constraint(equalToConstant: scrollView.frame.height),

            textView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            textView.heightAnchor.constraint(equalToConstant: 100),
            
            formTable.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            formTable.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            formTable.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            formTable.heightAnchor.constraint(equalToConstant: 113),

//            deleteButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            deleteButton.topAnchor.constraint(equalTo: formTable.bottomAnchor, constant: 16),
            deleteButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            deleteButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            deleteButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}
