import UIKit


class ToDoItemViewController: UIViewController, UITextViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
//    var item: TodoItem
    var deadline = false
    var notDefaultDate = false
    var deadlineDate: Date? = Date().addingTimeInterval(3600*24)
    
//    var deadlineDate: Date?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithSegmentedControl", for: indexPath)
            cell.textLabel?.text = "Важность"
            
            cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
            cell.textLabel?.topAnchor.constraint(equalTo: cell.topAnchor, constant: 17).isActive = true
            cell.textLabel?.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 16).isActive = true
            
            let segmentedControl = UISegmentedControl(items: [UIImage(named: "unimportant.png") ?? "u", "нет", UIImage(named: "important") ?? "i"])
            segmentedControl.selectedSegmentIndex = 1
            segmentedControl.frame = CGRect(x: cell.frame.width - (cell.frame.width / 2.3) - 20, y: 10, width: cell.frame.width / 2.3, height: cell.frame.height - 20)
            cell.contentView.addSubview(segmentedControl)
            return cell
        } else if indexPath.row == 1 {

            let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithCheckbox", for: indexPath)
            cell.textLabel?.text = "Сделать до"
            
            cell.textLabel?.translatesAutoresizingMaskIntoConstraints = false
            
            let topConstraint = cell.textLabel?.topAnchor.constraint(equalTo: cell.topAnchor, constant: 17)
            topConstraint!.identifier = "topConstraint"
            topConstraint!.isActive = true
            
            cell.textLabel?.leftAnchor.constraint(equalTo: cell.leftAnchor, constant: 16).isActive = true
            
            let checkbox = UISwitch(frame: CGRect.zero)
            checkbox.isOn = deadline
            checkbox.addTarget(self, action: #selector(deadlineCheckboxValueChanged), for: .valueChanged)
            cell.accessoryView = checkbox

            let button = UIButton(type: .system)
            button.setTitle(DateFormatter.DateFormatter.string(from: deadlineDate!), for: .normal)
            button.addTarget(self, action: #selector(dateButtonItemTapped), for: .touchUpInside)
            cell.addSubview(button)

            button.translatesAutoresizingMaskIntoConstraints = false
            button.topAnchor.constraint(equalTo: cell.textLabel!.bottomAnchor, constant: 2).isActive = true

            button.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
            button.leftAnchor.constraint(equalTo: cell.textLabel!.leftAnchor).isActive = true
            
            button.tag = 1
    
            button.isHidden = true

            return cell

        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cellWithCalendar", for: indexPath)
            let calendarView = UIDatePicker()
            calendarView.frame = CGRect(x: 16, y: 17, width: cell.frame.width, height: cell.frame.height)
            calendarView.datePickerMode = .date
            calendarView.date = Date().addingTimeInterval(3600*24)
            calendarView.preferredDatePickerStyle = .inline
            calendarView.minimumDate = Date()
            
            calendarView.addTarget(self, action: #selector(deadlineDatePickerValueChanged), for: .valueChanged)
            
            cell.contentView.addSubview(calendarView)
            
            cell.isHidden = true
            
            
            
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

        navItem.rightBarButtonItem?.isEnabled = false
        
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

        return stackView
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        textView.layer.cornerRadius = 16

        textView.isScrollEnabled = false

        textView.text = "Что надо сделать?"
        textView.textColor = UIColor.lightGray
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.textContainerInset = UIEdgeInsets(top: 17, left: 16, bottom: 17, right: 16)
        textView.delegate = self
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
//        self.view.addGestureRecognizer(tapGesture)

        return textView
    }()

    
    private lazy var formTable: UITableView  = {
        let formTable = UITableView()

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
            navBar.items?[0].rightBarButtonItem?.isEnabled = false
            textView.text = "Что надо сделать?"
            textView.textColor = UIColor.lightGray
        } else {
            navBar.items?[0].rightBarButtonItem?.isEnabled = true
        }
        textView.resignFirstResponder()
    }

    func textViewDidChange(_ textView: UITextView) {
        textView.sizeToFit()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath == IndexPath(row: 2, section: 0) {
            return 313
        } else {
            return 56
        }
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

        
    
    @objc func dateButtonItemTapped(_ sender:UIButton)
    {
        if notDefaultDate {
            notDefaultDate = false
            let cell = formTable.cellForRow(at: IndexPath(row: 2, section: 0))
            cell?.isHidden = true
        } else {
            notDefaultDate = true
            let cell = formTable.cellForRow(at: IndexPath(row: 2, section: 0))
            cell?.isHidden = false
        }
    }
    
    @objc func deadlineCheckboxValueChanged(sender: UISwitch) {
        deadline = sender.isOn
        let cell = formTable.cellForRow(at: IndexPath(row: 1, section: 0))
        let button = cell!.viewWithTag(1) as? UIButton
        if deadline {
            button!.isHidden = false
        } else {
            notDefaultDate = false
            button!.isHidden = true
            deadlineDate = nil
        }
    }
    
    @objc func deadlineDatePickerValueChanged(sender: UIDatePicker) {
        deadlineDate = sender.date
        let cell = formTable.cellForRow(at: IndexPath(row: 1, section: 0))
        let button = cell!.viewWithTag(1) as? UIButton
        button?.setTitle(DateFormatter.DateFormatter.string(from: deadlineDate!), for: .normal)
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
//            scrollView.heightAnchor.constraint(greaterThanOrEqualToConstant: 353),

            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            stackView.widthAnchor.constraint(equalToConstant: scrollView.frame.width - 32),
            stackView.heightAnchor.constraint(equalToConstant: scrollView.frame.height),

            textView.topAnchor.constraint(equalTo: stackView.topAnchor),
            textView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            textView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),


            formTable.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            formTable.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            formTable.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            formTable.heightAnchor.constraint(lessThanOrEqualToConstant: 449),

            deleteButton.topAnchor.constraint(equalTo: formTable.bottomAnchor, constant: 16),
            deleteButton.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            deleteButton.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
    }
}

extension DateFormatter {
    static let DateFormatter: DateFormatter = {
        let dateFormatter = Foundation.DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
        return dateFormatter
    }()
}
