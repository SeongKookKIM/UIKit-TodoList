import UIKit

class CustomCell: UITableViewCell {
    

    // Container View
    private let stackViewContainer: UIView = {
        let stackViewContainer = UIView()
        stackViewContainer.backgroundColor = .systemBrown
        stackViewContainer.layer.cornerRadius = 10
        stackViewContainer.translatesAutoresizingMaskIntoConstraints = false
        
        return stackViewContainer
    }()
    
    // title
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return titleLabel
    }()
    
    // isDone
    private let isDoneLabel: UILabel = {
        let isDoneLabel = UILabel()
        isDoneLabel.translatesAutoresizingMaskIntoConstraints = false
        return isDoneLabel
    }()
    
    // content
    private let contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.font = UIFont.systemFont(ofSize: 16)
        contentLabel.numberOfLines = 2
        contentLabel.lineBreakMode = .byTruncatingTail
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return contentLabel
    }()
    
    // date
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = UIFont.systemFont(ofSize: 15)
        dateLabel.textColor = .white
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        return dateLabel
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    // setUp 설정
    func setUp() {
        
        let hStackView = UIStackView(arrangedSubviews: [titleLabel, isDoneLabel])
        hStackView.axis = .horizontal
        hStackView.translatesAutoresizingMaskIntoConstraints = false
        

        // 간격을 위한 뷰 추가 (content - date)
        let spacer = UIView()
        spacer.translatesAutoresizingMaskIntoConstraints = false
        spacer.heightAnchor.constraint(equalToConstant: 10).isActive = true
        
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
    
    // congifure
    func configure(item: Todo) {
        titleLabel.text = item.title
        contentLabel.text = item.content
        
        // isDone 상태 체크
        isDoneLabel.text = item.isDone ? "완료한 일" : "해야할 일"
        isDoneLabel.textColor = item.isDone ? .green : .red
        
        // Date String으로 변환
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        if let date = item.date {
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = ""
        }
    }
    
}

