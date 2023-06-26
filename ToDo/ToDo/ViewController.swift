
import UIKit

class ViewController: UIViewController {
    var list = FileCache()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Мои дела"
//        super.navigationController?.navigationBar.tintColor = .red
        
        view.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)

        contentView.addSubview(contentDoneView)
        contentDoneView.addArrangedSubview(doneLabel)
        contentDoneView.addArrangedSubview(showDoneButton)

        contentView.addSubview(listToDoStack)
        listToDoStack.addArrangedSubview(newButton)

        view.addSubview(addButton)



        setupViewsConstraints()
        
        setupDoneViewConstraints()
        setupAddButtonConstraints()
        setuplistToDoStackConstraints()
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

    private let doneLabel: UILabel = {
        let doneLabel = UILabel()
        var counterDone = 5  // заменить на счетчик

        doneLabel.text = "Выполнено - " + String(counterDone)
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


    private lazy var listToDoStack: UIStackView = {
        let listToDoStack = UIStackView()
        listToDoStack.axis = .vertical
        listToDoStack.layer.cornerRadius = 16
        listToDoStack.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return listToDoStack
    }()

    private lazy var newButton: UIButton = {
        let newButton = UIButton()
        newButton.setTitle("Новое", for: .normal)
        newButton.setTitleColor(#colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1), for: .normal)
        newButton.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        newButton.contentHorizontalAlignment = .left
        newButton.contentEdgeInsets = UIEdgeInsets(top: 16,left: 28,bottom: 16,right: 28)
        return newButton
    }()

    private let addButton: UIButton = {
        let addButton = UIButton()
        addButton.backgroundColor = #colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1)

        addButton.setImage(UIImage(systemName: "plus", withConfiguration: UIImage.SymbolConfiguration(weight: .heavy))!.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)

        addButton.layer.shadowColor = #colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1)
        addButton.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        addButton.layer.shadowOpacity = 0.3
        addButton.layer.shadowRadius = 20

        addButton.layer.cornerRadius = 22

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

    private func setuplistToDoStackConstraints() {
        listToDoStack.translatesAutoresizingMaskIntoConstraints = false

//        newButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            listToDoStack.topAnchor.constraint(equalTo: contentDoneView.bottomAnchor, constant: 12),
            listToDoStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            listToDoStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),

//            newButton.leftAnchor.constraint(equalTo: listToDoStack.leftAnchor),
//            newButton.rightAnchor.constraint(equalTo: listToDoStack.rightAnchor),
//            newButton.bottomAnchor.constraint(equalTo: listToDoStack.bottomAnchor)
        ])
    }
}
