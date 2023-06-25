import UIKit


class ToDoItemViewController: UIViewController, UITextViewDelegate {
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(scrollView)
        scrollView.addSubview(stackView)
        
        stackView.addSubview(textView)
        
        stackView.addSubview(formStackView)
        formStackView.addArrangedSubview(importanceView)
        formStackView.addArrangedSubview(deadlineView)
        formStackView.addArrangedSubview(calendarView)
        
        stackView.addSubview(deleteButton)
        
        view.addSubview(navBar)
        
        textView.delegate = self
        
        setupScrollViewsConstraints()
        setupStackViewsConstraints()
        setupTextViewsConstraints()
        setupDeleteButtonConstraints()
        
        setUpFormStackViewConstraints()
        setUpImportanceViewConstaints()
        setUpDeadlineViewConstaints()
        setUpCalendarViewConstaints()
    }
    
    
    // MARK: - UINavigationBar
    
    private lazy var navBar: UINavigationBar = {
        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.size.width, height: 44))
        navBar.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
        
        let navItem = UINavigationItem(title: "Дело")
        
        let rightBarButton = UIBarButtonItem(title: "Сохранить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.saveBarButtonItemTapped(_:)))
        
        let leftBarButton = UIBarButtonItem(title: "Отменить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelBarButtonItemTapped(_:)))
        
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
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        return textView
    }()
    
    private lazy var formStackView: UIStackView = {
        let formStackView = UIStackView()
        
        formStackView.axis = .vertical
        formStackView.distribution = .fill
        formStackView.alignment = .center
        formStackView.layer.cornerRadius = 16
        formStackView.spacing = 0
        formStackView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        
        
        return formStackView
    }()
    
    private lazy var importanceView: UIStackView = {
        let importanceView = UIStackView()

        importanceView.axis = .vertical
        
        let importanceLabel = UILabel()
        importanceLabel.text = "Важность"
        
        let downArrow = UIImage(systemName: "arrow.down", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))!.withTintColor(#colorLiteral(red: 0.5520535111, green: 0.5570273995, blue: 0.5741342902, alpha: 1), renderingMode: .alwaysOriginal)
        
        let twoExclamation = UIImage(systemName: "exclamationmark.2", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))!.withTintColor(#colorLiteral(red: 1, green: 0.2332399487, blue: 0.1861645281, alpha: 1), renderingMode: .alwaysOriginal)
        
        let importanceControl = UISegmentedControl(items: [downArrow, "нет", twoExclamation])
        importanceControl.selectedSegmentIndex = 1
        importanceControl.setWidth(49, forSegmentAt: 0)
        importanceControl.setWidth(49, forSegmentAt: 1)
        importanceControl.setWidth(49, forSegmentAt: 2)
        
        
        importanceView.addSubview(importanceLabel)
        importanceView.addSubview(importanceControl)
        
        importanceLabel.translatesAutoresizingMaskIntoConstraints = false

        importanceLabel.topAnchor.constraint(equalTo: importanceView.topAnchor, constant: 17).isActive = true
        importanceLabel.bottomAnchor.constraint(equalTo: importanceView.bottomAnchor, constant: -17).isActive = true
        importanceLabel.leftAnchor.constraint(equalTo: importanceView.leftAnchor, constant: 16).isActive = true

        importanceControl.translatesAutoresizingMaskIntoConstraints = false
        importanceControl.topAnchor.constraint(equalTo: importanceView.topAnchor, constant: 10).isActive = true
        importanceControl.bottomAnchor.constraint(equalTo: importanceView.bottomAnchor, constant: -10).isActive = true
        importanceControl.rightAnchor.constraint(equalTo: importanceView.rightAnchor, constant: -16).isActive = true
        
        return importanceView
    }()
    
    private lazy var deadlineView: UIStackView = {
    
        let deadlineView = UIStackView()
        deadlineView.axis = .horizontal
        deadlineView.distribution = .fill
        deadlineView.alignment = .leading
        
        let deadlineLabel = UILabel()
        deadlineLabel.text = "Сделать до"
        
        let switchCase = UISwitch()
        switchCase.isOn = false
        switchCase.addTarget(self, action: #selector(switchToggled(_:)), for: .valueChanged)

        deadlineView.addSubview(deadlineLabel)
        deadlineView.addSubview(switchCase)
        deadlineView.addSubview(dateButton)
    
        deadlineLabel.translatesAutoresizingMaskIntoConstraints = false
//        deadlineLabel.topAnchor.constraint(equalTo: deadlineView.topAnchor).isActive = true
        deadlineLabel.topAnchor.constraint(equalTo: deadlineView.topAnchor, constant: 10).isActive = true
        deadlineLabel.leftAnchor.constraint(equalTo: deadlineView.leftAnchor, constant: 16).isActive = true
        deadlineLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        switchCase.translatesAutoresizingMaskIntoConstraints = false
        switchCase.rightAnchor.constraint(equalTo: deadlineView.rightAnchor, constant: -16).isActive = true
        switchCase.topAnchor.constraint(equalTo: deadlineView.topAnchor, constant: 15).isActive = true
        switchCase.bottomAnchor.constraint(equalTo: deadlineView.bottomAnchor, constant: -15).isActive = true
        
        dateButton.translatesAutoresizingMaskIntoConstraints = false
        dateButton.leftAnchor.constraint(equalTo: deadlineView.leftAnchor, constant: 16).isActive = true
        dateButton.topAnchor.constraint(equalTo: deadlineLabel.bottomAnchor).isActive = true
        dateButton.bottomAnchor.constraint(equalTo: deadlineView.bottomAnchor, constant: -10).isActive = true
        
        
        return deadlineView
    }()
    
    private lazy var dateButton: UIButton = {
        let dateButton = UIButton(type: .system)
        let deadlineDate = DateFormatter.DateFormatter.string(from: Date().addingTimeInterval(3600*24))
        dateButton.setTitle(deadlineDate, for: .normal)
        dateButton.setTitleColor(.systemBlue , for: .normal)
        dateButton.addTarget(self, action: #selector(openCalendar), for: .touchUpInside)
        
        dateButton.isHidden = true
        
        return dateButton
    }()
    
    private lazy var calendarView: UIDatePicker = {
        let calendarView = UIDatePicker()
        calendarView.datePickerMode = .date
        calendarView.date = Date().addingTimeInterval(3600*24)
        calendarView.preferredDatePickerStyle = .inline
        calendarView.minimumDate = Date()

        calendarView.addTarget(self, action: #selector(calendarViewValueChanged), for: .valueChanged)
        
        calendarView.isHidden = true
        
//        calendarView.translatesAutoresizingMaskIntoConstraints = false
//        calendarView.leftAnchor.constraint(equalTo: formStackView.leftAnchor, constant: 16).isActive = true
//        calendarView.rightAnchor.constraint(equalTo: formStackView.rightAnchor, constant: -16).isActive = true
        return calendarView
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

}

// MARK: - Actions

extension ToDoItemViewController {

    // MARK: - for navBar

    @objc func saveBarButtonItemTapped(_ sender:UIBarButtonItem!) {
        print("save")
    }

    @objc func cancelBarButtonItemTapped(_ sender:UIBarButtonItem!) {
        print("cancel")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // MARK: - for text view

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

    @objc func endEditing() {
        textView.resignFirstResponder()
    }
    
    
    // MARK: - for calendar
    
    @objc func switchToggled(_ sender: UISwitch! ) {
        if sender.isOn {
            dateButton.isHidden = false
        } else {
            dateButton.isHidden = true
            if !calendarView.isHidden {
                openCalendar()
            }
        }
    }
    
    @objc func openCalendar( ) {
//        print("open")
        if calendarView.isHidden {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations:{
                self.calendarView.isHidden = false
            })
        } else {
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut) {
                self.calendarView.alpha = 0
                self.calendarView.isHidden = true
            } completion: { _ in
                self.calendarView.alpha = 1
            }
        }
    }
    
    @objc func calendarViewValueChanged (_ sender: UIDatePicker ) {
//        deadlineDate = sender.date
        dateButton.setTitle(DateFormatter.DateFormatter.string(from: sender.date), for: .normal)
        openCalendar()
    }
}

    // MARK: - Constraints

extension ToDoItemViewController {
    private func setupScrollViewsConstraints() {
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor)
        ])
    }

    private func setupStackViewsConstraints() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            stackView.widthAnchor.constraint(equalToConstant: scrollView.frame.width - 32),
            stackView.heightAnchor.constraint(equalToConstant: scrollView.frame.height)
        ])
    }

    private func setupTextViewsConstraints() {
        textView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: stackView.topAnchor),
            textView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            textView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
        ])
    }
    
    private func setupDeleteButtonConstraints() {
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            deleteButton.topAnchor.constraint(equalTo: formStackView.bottomAnchor, constant: 16),
            deleteButton.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            deleteButton.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            deleteButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
    
    private func setUpFormStackViewConstraints() {
        formStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            formStackView.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            
            formStackView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
            formStackView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
            
//            formStackView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setUpImportanceViewConstaints() {
        importanceView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            importanceView.heightAnchor.constraint(equalToConstant: 56),
            importanceView.topAnchor.constraint(equalTo: formStackView.topAnchor),
            importanceView.leftAnchor.constraint(equalTo: formStackView.leftAnchor),
            importanceView.rightAnchor.constraint(equalTo: formStackView.rightAnchor),
        ])
    }
    
    private func setUpDeadlineViewConstaints() {
        deadlineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            deadlineView.topAnchor.constraint(equalTo: importanceView.bottomAnchor),
            deadlineView.leftAnchor.constraint(equalTo: formStackView.leftAnchor),
            deadlineView.rightAnchor.constraint(equalTo: formStackView.rightAnchor)
        ])
    }
    
    private func setUpCalendarViewConstaints() {
        calendarView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            calendarView.topAnchor.constraint(equalTo: deadlineView.bottomAnchor),
            calendarView.leftAnchor.constraint(equalTo: formStackView.leftAnchor, constant: 10),
            calendarView.rightAnchor.constraint(equalTo: formStackView.rightAnchor, constant: -16),
            calendarView.bottomAnchor.constraint(equalTo: formStackView.bottomAnchor)
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
