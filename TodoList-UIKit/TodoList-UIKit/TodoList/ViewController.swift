import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{

    // 테이블뷰 생성
    private var tableView: UITableView = {
       let tableView = UITableView(frame: .zero, style: .plain)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cell")
        
        return tableView
    }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let addButton = UIBarButtonItem(title: "추가하기", style: .done, target: self, action: #selector(addButtonTapped))
        addButton.tintColor = .systemBrown
        
        self.navigationItem.rightBarButtonItem = addButton
        
        setUpUI()
    }
    
    private func setUpUI() {
        navigationItem.title = "TodoList"


        // TableView
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
          
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
        
    }
    
    // 테이블 뷰를 리로드하여 새로운 데이터를 반영
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return TodoStore.shared.listCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let todoList = TodoStore.shared.getTodo(at: indexPath)
        cell.selectionStyle = .none
        cell.configure(item: todoList)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            TodoStore.shared.removeTodo(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            tableView.reloadData()
        }
    }
    
    // 클릭 시 TodoDetailViewController로 뷰이동 && 데이터 전달
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoInfo = TodoStore.shared.getTodo(at: indexPath)
        let todoDetailViewController = TodoDetailViewController(todoDetailData: todoInfo)
        show(todoDetailViewController, sender: self)
    }
    
    // addButtonTapped
    @objc func addButtonTapped() {
        let addTodoListViewController = AddTodoListViewController()
        self.show(addTodoListViewController, sender: nil)
    }
    
}
