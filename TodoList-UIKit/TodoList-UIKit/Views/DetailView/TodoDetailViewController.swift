import UIKit

class TodoDetailViewController: UIViewController {
    
    // Props 데이터
    var todoDetailData: Todo
    
    // 초기화
    init(todoDetailData: Todo) {
        self.todoDetailData = todoDetailData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    private let contentTitle: UILabel = {
        let contentTitle = UILabel()
        contentTitle.text = "할 일"
        contentTitle.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        contentTitle.translatesAutoresizingMaskIntoConstraints = false
        return contentTitle
    }()
    
    private let contentLabel: UILabel = {
        let contentLabel = UILabel()
        contentLabel.numberOfLines = 0
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        return contentLabel
    }()
    
    private let dateTitle: UILabel = {
        let dateTitle = UILabel()
        dateTitle.text = "등록 날짜"
        dateTitle.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        dateTitle.translatesAutoresizingMaskIntoConstraints = false
        return dateTitle
    }()
    
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        return dateLabel
    }()
    
    private let statusTitle: UILabel = {
        let statusTitle = UILabel()
        statusTitle.text = "상태"
        statusTitle.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        statusTitle.translatesAutoresizingMaskIntoConstraints = false
        return statusTitle
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    let statusSwitch = UISwitch()
    let statusLabel = UILabel()
    
    private let saveBtn: UIButton = {
        let saveBtn = UIButton()
        var config = UIButton.Configuration.filled()
        config.title = "저장하기"
        config.cornerStyle = .capsule
        config.baseBackgroundColor = .systemBrown
        
        saveBtn.configuration = config
        saveBtn.translatesAutoresizingMaskIntoConstraints = false
        return saveBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        statusSwitch.isOn = todoDetailData.isDone
        statusSwitch.addTarget(self, action: #selector(switchChanged), for: .valueChanged)
        statusLabel.text = todoDetailData.isDone ? "완료한 일" : "해야할 일"
        
        stackView.addArrangedSubview(statusSwitch)
        stackView.addArrangedSubview(statusLabel)
        
        // date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        // PropsData
        navigationItem.title = todoDetailData.title
        contentLabel.text = todoDetailData.content
        if let date = todoDetailData.date {
            dateLabel.text = dateFormatter.string(from: date)
        } else {
            dateLabel.text = ""
        }
        
        saveBtn.addAction(UIAction { [weak self] _ in
            guard let self = self else { return }
            // todoDetailData의 변경 사항을 TodoStore에 업데이트
            TodoStore.shared.updateTodo(todoDetailData)
            
            // 이전 화면으로 돌아가기
            navigationController?.popViewController(animated: true)
        }, for: .touchUpInside)
        
        contentView.addSubview(contentTitle)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateTitle)
        contentView.addSubview(dateLabel)
        contentView.addSubview(statusTitle)
        contentView.addSubview(stackView)
        contentView.addSubview(saveBtn)
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            contentTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            contentLabel.topAnchor.constraint(equalTo: contentTitle.bottomAnchor, constant: 10),
            contentLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            contentLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            dateTitle.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 20),
            dateTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dateTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            dateLabel.topAnchor.constraint(equalTo: dateTitle.bottomAnchor, constant: 10),
            dateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            dateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            statusTitle.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 20),
            statusTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            statusTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: statusTitle.bottomAnchor, constant: 10),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            saveBtn.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 30),
            saveBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            saveBtn.heightAnchor.constraint(equalToConstant: 50),
            saveBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }
    
    @objc func switchChanged(_ sender: UISwitch) {
        statusLabel.text = sender.isOn ? "완료한 일" : "해야할 일"
        todoDetailData.isDone = sender.isOn
    }
}
