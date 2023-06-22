import UIKit

class ToDoItemViewController: UIViewController, UITextViewDelegate {
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()

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

    private var contentSize: CGSize {
        CGSize(width: view.frame.width , height: view.frame.height)
    }
    
    private lazy var deleteButton: UIButton  = {
        let deleteButton = UIButton()
        deleteButton.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        deleteButton.layer.cornerRadius = 16
        deleteButton.setTitle("Удалить", for: .normal)
        deleteButton.setTitleColor(.gray, for: .disabled)
        deleteButton.setTitleColor(.red, for: .normal)
        
        return deleteButton
    }()




    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scrollView)
        scrollView.addSubview(navBar)
        scrollView.addSubview(textView)
        scrollView.addSubview(deleteButton)
    
        textView.delegate = self
        
        setupViewsConstraints()
    }
    
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

}


extension ToDoItemViewController {
    private func setupViewsConstraints() {
        scrollView.showsHorizontalScrollIndicator = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: navBar.bottomAnchor, constant: 16),
            textView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            textView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 16),
//            textView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            textView.widthAnchor.constraint(equalToConstant: scrollView.frame.width - 32),
            textView.heightAnchor.constraint(equalToConstant: 100),
            
            deleteButton.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 16),
            deleteButton.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 16),
            deleteButton.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 16),
            deleteButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            
            deleteButton.widthAnchor.constraint(equalToConstant: scrollView.frame.width - 32),
            deleteButton.heightAnchor.constraint(equalToConstant: 56)
        ])
    }
}








