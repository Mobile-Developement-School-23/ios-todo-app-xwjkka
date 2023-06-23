
import UIKit

class ViewController: UIViewController {

    private let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.text = "Мои дела"
        headerLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        headerLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)

        return headerLabel
    }()

    private let addButton: UIButton = {
        let addButton = UIButton()
        addButton.backgroundColor = #colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1)

//        addButton.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
        addButton.setTitle("+", for: .normal)
        addButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        addButton.titleLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        addButton.contentMode = .center


        addButton.layer.shadowColor = #colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1)
        addButton.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        addButton.layer.shadowOpacity = 0.3
        addButton.layer.shadowRadius = 20

        addButton.layer.cornerRadius = 22
        return addButton
    }()

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
        scrollView.frame = view.bounds
        scrollView.contentSize = contentSize
        return scrollView
    }()

    private lazy var contentView: UIView = {
        let contentView = UIView()
        contentView.frame.size = contentSizeMini
        contentView.layer.cornerRadius = 16;
        contentView.layer.masksToBounds = true;
        return contentView
    }()

    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
        stackView.axis = .vertical
        stackView.alignment = .center

//        stackView.backgroundColor = .red
        return stackView
    }()


    private lazy var contentDoneView: UIView = {
        let contentDoneView = UIView()
        return contentDoneView
    }()

    private let doneLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.text = "Выполнено - "
        headerLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        headerLabel.textColor = #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1)

        return headerLabel
    }()

    private lazy var showDoneButton: UIButton = {
        let showDoneButton = UIButton()
        showDoneButton.setTitle("Показать", for: .normal)
        showDoneButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        showDoneButton.setTitleColor(#colorLiteral(red: 0, green: 0.4780646563, blue: 0.9985368848, alpha: 1), for: .normal)
        showDoneButton.titleLabel?.textAlignment = .center
        return showDoneButton
    }()

    private var contentSize: CGSize {
        CGSize(width: view.frame.width , height: view.frame.height)
    }

    private var contentSizeMini: CGSize {
        CGSize(width: view.frame.width - 30 , height: view.frame.height)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)

        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)

        scrollView.addSubview(headerLabel)

        scrollView.addSubview(contentDoneView)
        contentDoneView.addSubview(showDoneButton)
        contentDoneView.addSubview(doneLabel)

        view.addSubview(addButton)

        setupColors()
        setupHeaderConstraints()
        setupViewsConstraints()
        setupAddButtonConstraints()
        setupDoneViewConstraints()
    }


}

extension ViewController {

    private func setupViewsConstraints() {
        scrollView.showsHorizontalScrollIndicator = false
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor),

            contentView.topAnchor.constraint(equalTo: contentDoneView.bottomAnchor, constant: 20),
//            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 200),
            contentView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 15),
            contentView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 15),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),

            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])

        for view in stackView.arrangedSubviews {
            NSLayoutConstraint.activate([
                view.widthAnchor.constraint(equalToConstant: 343),
                view.heightAnchor.constraint(equalToConstant: 56)
            ])
        }

    }

    private func setupHeaderConstraints() {
        headerLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 42),
            headerLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20)
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

    private func setupDoneViewConstraints() {
        contentDoneView.translatesAutoresizingMaskIntoConstraints = false
        doneLabel.translatesAutoresizingMaskIntoConstraints = false
        showDoneButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            contentDoneView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            contentDoneView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            contentDoneView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -15),

            contentDoneView.heightAnchor.constraint(equalToConstant: 20),

            doneLabel.topAnchor.constraint(equalTo: contentDoneView.topAnchor),
            showDoneButton.topAnchor.constraint(equalTo: contentDoneView.topAnchor),

            doneLabel.leftAnchor.constraint(equalTo: contentDoneView.leftAnchor),
            doneLabel.bottomAnchor.constraint(equalTo: contentDoneView.bottomAnchor),

            showDoneButton.rightAnchor.constraint(equalTo: contentDoneView.rightAnchor),
            showDoneButton.bottomAnchor.constraint(equalTo: contentDoneView.bottomAnchor)
        ])
    }

    private func setupColors() {
        for _ in 0..<40 {
            let view = UIView()
            view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            stackView.addArrangedSubview(view)
        }
    }
}