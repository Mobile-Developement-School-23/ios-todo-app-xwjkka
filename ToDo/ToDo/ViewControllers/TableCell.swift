import UIKit

final class ListToDoTableCell: UITableViewCell {
    
    static let identifier = "ListToDoTableCell"
//    private var item: TodoItem!
    var item: TodoItem!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        radioButtonView.image = nil
        cellTextLabel.attributedText = nil
        cellTextLabel.text = nil
        dateString.text = nil
        calendarImageView.image = nil
        accessoryType = .none
        isUserInteractionEnabled = true
    }

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cellTextLabel: UILabel = {
        var cellTextLabel = UILabel()
        
        return cellTextLabel
    }()
    
    private func setTextCell() {
        if self.item.done {
            crossText()
        } else {
            cellTextLabel.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cellTextLabel.text = self.item.text
        }
    }
    
    private func crossText() {
        cellTextLabel.textColor =  #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1)
        cellTextLabel.font = UIFont.systemFont(ofSize: 17)
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item.text)
            attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
        cellTextLabel.attributedText = attributeString
    }
    
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
        dateLabel.isHidden = true
        
        return dateLabel
    }()
    
    private lazy var calendarImageView: UIImageView = {
        let calendarImageView = UIImageView()
        calendarImageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(weight: .light))!.withTintColor( #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1), renderingMode: .alwaysOriginal)
        return calendarImageView
    }()
    
    private lazy var radioButtonView: UIImageView = {
        let radioButtonView = UIImageView()
        var radioButtonViewImage = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))!.withTintColor( #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1), renderingMode: .alwaysOriginal)
        
        radioButtonView.image = radioButtonViewImage
        return radioButtonView
    }()
    
    private lazy var dateString: UILabel = {
        var dateString = UILabel()
        return dateString
    }()
    
    func setImageCell() {
        if self.item.done {
            radioButtonView.image = UIImage(systemName: "checkmark.circle.fill", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))!.withTintColor( .systemGreen, renderingMode: .alwaysOriginal)
        }else if self.item.importance == .important {
            radioButtonView.image = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))!.withTintColor( #colorLiteral(red: 1, green: 0.2332399487, blue: 0.1861645281, alpha: 1), renderingMode: .alwaysOriginal)
        } else {
            radioButtonView.image = UIImage(systemName: "circle", withConfiguration: UIImage.SymbolConfiguration(weight: .regular))!.withTintColor( #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1), renderingMode: .alwaysOriginal)
        }
    }
    
    func configure(with item: TodoItem) {
        self.accessoryType = .disclosureIndicator
        self.item = item
        setTextCell()
        setImageCell()
        if item.deadline != nil {
            dateLabel.isHidden = false
            calendarImageView.image = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(weight: .light))!.withTintColor( #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1), renderingMode: .alwaysOriginal)
            let dateFormat = DateFormatter()
            dateFormat.setLocalizedDateFormatFromTemplate("dd MMMM")
            dateString.text = dateFormat.string(from: self.item.deadline ?? Date())
        } else {
            dateLabel.isHidden = true
        }
        
        setupConstraints()
    }
    
    func setUpLayout() {
        self.addSubview(radioButtonView)
        self.addSubview(cellLabel)
        cellLabel.addArrangedSubview(cellTextLabel)
        cellLabel.addArrangedSubview(dateLabel)
        dateLabel.addArrangedSubview(calendarImageView)
        dateLabel.addArrangedSubview(dateString)
    }
    
    func setupConstraints() {
        radioButtonView.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            radioButtonView.leftAnchor.constraint(equalTo: super.leftAnchor, constant: 16),
            radioButtonView.widthAnchor.constraint(equalToConstant: 24),
            radioButtonView.heightAnchor.constraint(equalToConstant: 24),
            radioButtonView.centerYAnchor.constraint(equalTo: super.contentView.centerYAnchor),
            
            cellLabel.leftAnchor.constraint(equalTo: radioButtonView.rightAnchor, constant: 12),
            cellLabel.centerYAnchor.constraint(equalTo: super.contentView.centerYAnchor)
        ])
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpLayout()
        setupConstraints()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

