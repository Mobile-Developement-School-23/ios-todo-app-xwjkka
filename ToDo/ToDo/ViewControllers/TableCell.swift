//import UIKit
//
//final class ListToDoTableCell: UITableViewCell {
//    static let identifier = "cellId"
//    var item: TodoItem!
//    var IndexPath: IndexPath!
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
//
//    func setupConstraints() {
//        cellLabel.translatesAutoresizingMaskIntoConstraints = false
//
//        NSLayoutConstraint.activate([
//            cellLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 26),
//            cellLabel.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor)
//        ])
//    }
//
//    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        setupConstraints()
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func configureCell(with item: TodoItem, at indexPath: IndexPath) {
//        item = item
//        IndexPath = indexPath
//
//        cellTextLabel.text = item.text
//
//        self.contentView.addSubview(cellLabel)
//        cellLabel.addArrangedSubview(cellTextLabel)
//
//        if let _ = item.deadline {
//            cellLabel.addArrangedSubview(dateLabel)
//        }
//    }
//
//    private lazy var cellTextLabel: UILabel = {
//        let cellTextLabel = UILabel()
//        if item.done {
//            cellTextLabel.text = item.text
//            cellTextLabel.textColor = ##colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1)
//            cellTextLabel.font = UIFont.systemFont(ofSize: 17)
//            let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: item.text)
//                attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributeString.length))
//            cellTextLabel.attributedText = attributeString
//
//        } else {
//            cellTextLabel.text = item.text
//        }
//
//        return cellTextLabel
//    }()
//
//    private lazy var cellLabel: UIStackView = {
//        let cellLabel = UIStackView()
//        cellLabel.axis = .vertical
//        cellLabel.distribution = .fill
//        cellLabel.alignment = .leading
//        cellLabel.spacing = 2
//        cellLabel.translatesAutoresizingMaskIntoConstraints = false
//        return cellLabel
//    }()
//
//    private lazy var dateLabel: UILabel = {
//        let dateLabel = UILabel()
//        dateLabel.textColor = #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1)
//        dateLabel.font = UIFont.systemFont(ofSize: 15)
//        let calendarImage = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))!.withTintColor(#colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1), renderingMode: .alwaysOriginal)
//        let calendarAttachment = NSTextAttachment()
//
//        calendarAttachment.image = calendarImage
//
//        let calendarAttributedString = NSAttributedString(attachment: calendarAttachment)
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "dd MMMM"
//        let dateString = dateFormatter.string(from: item.deadline!)
//        let dateAttributedString = NSAttributedString(string: " " + dateString)
//
//        let attributedString = NSMutableAttributedString()
//        attributedString.append(calendarAttributedString)
//        attributedString.append(dateAttributedString)
//
//        dateLabel.attributedText = attributedString
//
//        return dateLabel
//    }()
//
////    func make() {
////        self.contentView.addSubview(cellLabel)
////        cellLabel.addArrangedSubview(cellTextLabel)
////
////        if let _ = item.deadline {
////            cellLabel.addArrangedSubview(dateLabel)
////        }
////    }
//}

import UIKit

class ListToDoTableCell: UITableViewCell {
    
    static let identifier = "ListToDoTableCell"
    var item: TodoItem!
    
    override func prepareForReuse() {
        cellLabel.arrangedSubviews.forEach { subview in
            cellLabel.removeArrangedSubview(subview)
            subview.removeFromSuperview()
        }
        cellTextLabel.text = ""
//        dateLabel.text = ""
        let attributedText = NSMutableAttributedString(string: dateLabel.text ?? "")
//        dateLabel.attributedText = attributedText
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
    
    private lazy var dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.textColor =  #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1)
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        let calendarImage = UIImage(systemName: "calendar", withConfiguration: UIImage.SymbolConfiguration(weight: .bold))!.withTintColor( #colorLiteral(red: 0.6274510622, green: 0.6274510026, blue: 0.6274510026, alpha: 1), renderingMode: .alwaysOriginal)
        let calendarAttachment = NSTextAttachment()

        calendarAttachment.image = calendarImage
        
        let calendarAttributedString = NSAttributedString(attachment: calendarAttachment)

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM"
        let dateString = dateFormatter.string(from: item.deadline ?? Date())
        let dateAttributedString = NSAttributedString(string: " " + dateString)

        let attributedString = NSMutableAttributedString()
        attributedString.append(calendarAttributedString)
        attributedString.append(dateAttributedString)

        dateLabel.attributedText = attributedString
        
        return dateLabel
    }()
    
    func configure(with item: TodoItem) {
//        titleLabel.text = item.text
        self.item = item
        
        self.addSubview(cellLabel)
        cellTextLabel.text = item.text
        cellLabel.addArrangedSubview(cellTextLabel)
        if item.deadline != nil {
            dateLabel.text = DateFormatter.DateFormatter.string(from: item.deadline!)
            cellLabel.addArrangedSubview(dateLabel)
        }
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
        
//        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

