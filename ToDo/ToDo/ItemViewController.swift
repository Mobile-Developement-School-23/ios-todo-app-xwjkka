//import UIKit
//
//class ItemViewController: UIViewController, UITextViewDelegate {
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.addSubview(navBar)
//        
//        view.addSubview(scrollView)
//        scrollView.addSubview(stackView)
//        
//        setupViewsConstraints()
//    }
//
//    
//    
//    // MARK: - UINavigationBar
//    
//    private lazy var navBar: UINavigationBar = {
//        let navBar = UINavigationBar(frame: CGRect(x: 0, y: 50, width: view.frame.size.width, height: 44))
//        navBar.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
//
//        let navItem = UINavigationItem(title: "Дело")
//
//        let rightBarButton = UIBarButtonItem(title: "Сохранить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.saveBarButtonItemTapped(_:)))
//
//        let leftBarButton = UIBarButtonItem(title: "Отменить", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.cancelBarButtonItemTapped(_:)))
//
//        navItem.rightBarButtonItem = rightBarButton
//        navItem.leftBarButtonItem = leftBarButton
//
//        navItem.rightBarButtonItem?.isEnabled = false
//        
//        navBar.setItems([navItem], animated: false)
//
//        return navBar
//    }()
//    
//    
//    // MARK: - Content
//
//    private lazy var scrollView: UIScrollView = {
//        let scrollView = UIScrollView()
//        scrollView.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
//        scrollView.frame = view.bounds
//        
////        setupScrollViewsConstraints()
//        
//        return scrollView
//    }()
//
//    private lazy var stackView: UIStackView = {
//        let stackView = UIStackView()
//        stackView.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
//        stackView.axis = .vertical
//        stackView.alignment = .center
//        stackView.spacing = 16
//
//        
////        setupStackViewsConstraints()
//    
//        return stackView
//    }()
//    
//    private lazy var textView: UITextView = {
//        let textView = UITextView()
//        textView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//        textView.layer.cornerRadius = 16
//
//        textView.isScrollEnabled = false
//
//        textView.text = "Что надо сделать?"
//        textView.textColor = UIColor.lightGray
//        textView.font = UIFont.systemFont(ofSize: 17)
//        textView.textContainerInset = UIEdgeInsets(top: 17, left: 16, bottom: 17, right: 16)
//        textView.delegate = self
//
//        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(endEditing))
//        tapGesture.cancelsTouchesInView = false
//        view.addGestureRecognizer(tapGesture)
//
//        return textView
//    }()
//    
//}
//
//// MARK: - DateFormatter
//
//extension DateFormatter {
//    static let DateFormatter: DateFormatter = {
//        let dateFormatter = Foundation.DateFormatter()
//        dateFormatter.locale = Locale(identifier: "ru_RU")
//        dateFormatter.setLocalizedDateFormatFromTemplate("dd MMMM yyyy")
//        return dateFormatter
//    }()
//}
//
//
//// MARK: - Actions
//
//extension ItemViewController {
//    
//    // MARK: - for navBar
//    
//    @objc func saveBarButtonItemTapped(_ sender:UIBarButtonItem!) {
//        print("save")
//    }
//
//    @objc func cancelBarButtonItemTapped(_ sender:UIBarButtonItem!) {
//        print("cancel")
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//    }
//    
//    
//    // MARK: - for text view
//    
//    func textViewDidBeginEditing(_ textView: UITextView) {
//        if textView.textColor == UIColor.lightGray {
//            textView.text = nil
//            textView.textColor = UIColor.black
//        }
//
//        textView.becomeFirstResponder()
//    }
//
//    func textViewDidEndEditing(_ textView: UITextView) {
//        if textView.text.isEmpty {
//            navBar.items?[0].rightBarButtonItem?.isEnabled = false
//            textView.text = "Что надо сделать?"
//            textView.textColor = UIColor.lightGray
//        } else {
//            navBar.items?[0].rightBarButtonItem?.isEnabled = true
//        }
//        textView.resignFirstResponder()
//    }
//
//    func textViewDidChange(_ textView: UITextView) {
//        textView.sizeToFit()
//    }
//    
//    @objc func endEditing() {
//        textView.resignFirstResponder()
//    }
//}
//
//
//// MARK: - Constraints
////extension ItemViewController {
////
//////    private func setupScrollViewsConstraints() {
//////        scrollView.showsHorizontalScrollIndicator = false
//////        scrollView.translatesAutoresizingMaskIntoConstraints = false
//////
//////        NSLayoutConstraint.activate([
//////            scrollView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
//////            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//////            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
//////            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor)
//////        ])
//////    }
//////
//////    private func setupStackViewsConstraints() {
//////
//////        stackView.translatesAutoresizingMaskIntoConstraints = false
//////
//////        NSLayoutConstraint.activate([
//////            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
//////            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
//////            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
//////            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//////
//////            stackView.widthAnchor.constraint(equalToConstant: scrollView.frame.width - 32),
//////            stackView.heightAnchor.constraint(equalToConstant: scrollView.frame.height)
//////        ])
//////    }
////}
//
//extension ItemViewController {
//    private func setupViewsConstraints() {
//
//        scrollView.showsHorizontalScrollIndicator = false
//
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//
//        textView.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            scrollView.topAnchor.constraint(equalTo: navBar.bottomAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
//            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),
//
//            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 16),
//            stackView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -16),
//            stackView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
//            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
//
//            stackView.widthAnchor.constraint(equalToConstant: scrollView.frame.width - 32),
//            stackView.heightAnchor.constraint(equalToConstant: scrollView.frame.height),
//
//            textView.topAnchor.constraint(equalTo: stackView.topAnchor),
//            textView.leftAnchor.constraint(equalTo: stackView.leftAnchor),
//            textView.rightAnchor.constraint(equalTo: stackView.rightAnchor),
//            textView.heightAnchor.constraint(greaterThanOrEqualToConstant: 100)
//        ])
//
//    }
//}
