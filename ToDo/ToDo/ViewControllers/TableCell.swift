import UIKit

class ListToDoTableCell: UITableViewCell {
    
    static let identifier = "ListToDoTableCell"
    var item: TodoItem!
    
    override func prepareForReuse() {
        cellLabel.arrangedSubviews.forEach { subview in
            cellLabel.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        var attributedText = NSMutableAttributedString(string: cellTextLabel.text ?? "")
        cellTextLabel.text = ""
        cellTextLabel.attributedText = attributedText
//        attributedText = NSMutableAttributedString(string: dateLabel.text ?? "")
//        dateLabel.attributedText = attributedText
//        dateLabel.text = ""
        super.prepareForReuse()
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cellTextLabel: UILabel = {
        let cellTextLabel = UILabel()
        if item.done {
            cellTextLabel.text = item.text
            cellTextLabel.textColor =  #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1)
            cellTextLabel.font = UIFont.systemFont(ofSize: 17)
            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item.text)
                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
            cellTextLabel.attributedText = attributeString
        } else {
            cellTextLabel.text = item.text
        }
        
        return cellTextLabel
    }()
    
    private lazy var cellLabel: UIStackView = {
        let cellLabel = UIStackView()
        cellLabel.axis = .vertical
        cellLabel.distribution = .fill
        cellLabel.alignment = .leading
        cellLabel.spacing = 2
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        return cellLabel
    }()
    private lazy var dateLabel: UIStackView = {
        let dateLabel = UIStackView()
        dateLabel.axis = .horizontal

        dateLabel.addArrangedSubview(calendarImageView)
        dateLabel.addArrangedSubview(dateString)
        
        return dateLabel
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let calendarImageView = UIImageView()
        calendarImageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(weight: .light))!.withTintColor( #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1), renderingMode: .alwaysOriginal)
        return calendarImageView
    }()
    
    private lazy var dateString: UILabel = {
        var dateString = UILabel()
        if let deadline = item.deadline {
            dateString.text = DateFormatter.DateFormatter.string(from: deadline)
        }
        return dateString
    }()
    
    func configure(with item: TodoItem) {
        self.accessoryType = .disclosureIndicator
        self.item = item
        
        self.addSubview(cellLabel)
        cellTextLabel.text = item.text
        cellLabel.addArrangedSubview(cellTextLabel)
        if item.deadline != nil {
            cellLabel.addArrangedSubview(dateLabel)
        }
        
        setupConstraints()
    }
    
    func setupConstraints() {
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cellLabel.leftAnchor.constraint(equalTo: super.leftAnchor, constant: 26),
            cellLabel.centerYAnchor.constraint(equalTo: super.contentView.centerYAnchor)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

