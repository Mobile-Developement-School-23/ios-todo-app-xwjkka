import UIKit

class ViewController: UIViewController {

    private let headerLabel: UILabel = {
        let headerLabel = UILabel()
        headerLabel.text = "Мои дела"
        headerLabel.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        headerLabel.textColor = UIColor.black
        
        return headerLabel
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
//        contentView.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
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
        stackView.spacing = 20
        
        return stackView
    }()
    
    private var contentSize: CGSize {
        CGSize(width: view.frame.width , height: view.frame.height + 400)  // было h + 400
    }
    
    private var contentSizeMini: CGSize {
        CGSize(width: view.frame.width - 30 , height: view.frame.height + 400)  // было h + 400
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = #colorLiteral(red: 0.969507277, green: 0.9645401835, blue: 0.9516965747, alpha: 1)
    
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        view.addSubview(headerLabel)

        setupColors()
        setupHeaderConstraints()
        setupViewsConstraints()
    }


}

extension ViewController {
    
    private func setupViewsConstraints() {
        scrollView.showsHorizontalScrollIndicator = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            stackView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            
            scrollView.topAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 15),
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 15)
//            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
            headerLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            headerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20)
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
