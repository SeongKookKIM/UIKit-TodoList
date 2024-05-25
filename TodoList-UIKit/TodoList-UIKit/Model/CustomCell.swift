import UIKit

class CustomCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let contentLabel = UILabel()
    let dateLabel = UILabel()
    let isDoneLabel = UILabel()
    let toggleSwitch = UISwitch()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp() {
        
        
        
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        isDoneLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let hStackView = UIStackView(arrangedSubviews: [titleLabel, isDoneLabel])
        hStackView.axis = .horizontal
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.numberOfLines = 2
        contentLabel.lineBreakMode = .byTruncatingTail
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // 간격을 위한 뷰 추가
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
        
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.textColor = .white
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        
        let stackViewContainer = UIView()
        stackViewContainer.backgroundColor = .systemBrown
        stackViewContainer.layer.cornerRadius = 10
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [hStackView, contentLabel, spacer, dateLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackViewContainer.addSubview(stackView)
        contentView.addSubview(stackViewContainer)
        
        NSLayoutConstraint.activate([
            stackViewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            stackViewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackViewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackViewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            stackView.topAnchor.constraint(equalTo: stackViewContainer.topAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: stackViewContainer.trailingAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: stackViewContainer.leadingAnchor, constant: 10),
            stackView.bottomAnchor.constraint(equalTo: stackViewContainer.bottomAnchor, constant: -10),
        ])
    }
    
    func configure(item: Todo) {
        titleLabel.text = item.title
        contentLabel.text = item.content
        isDoneLabel.text = item.isDone ? "완료한 일" : "해야할 일"
        isDoneLabel.textColor = item.isDone ? .green : .red
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = item.date {
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = ""
        }
    }
    
}

