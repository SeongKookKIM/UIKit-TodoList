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
    
    // John: 이 부분을 버튼이아니라 레이블로 구현한 이유가 따로 있나요? 버튼으로 구현하면 메인뷰에서 제어가 가능해서 더 편리할 것 같습니다.
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
    


    // John: 얘는 왜 있는 건가요?
    let toggleSwitch = UISwitch()
    
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
            // John: 스택뷰 사이즈가 너무 커서 constant를 10정도로 줄이고 날짜를 완료한 일 밑에다가 적어서 위아래 간격도 좁히면 조금 더 가시성이 좋아질 것 같습니다.
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

