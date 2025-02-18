import UIKit

class ExchangeListViewController: UIViewController {
    
    private var exchangeListView: ExchangeListView = {
        let view = ExchangeListView()
        return view
    }()
        
    override func loadView() {
        super.loadView()
        self.view = exchangeListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeListView.tableView.dataSource = self
        exchangeListView.tableView.delegate = self
    }
}

extension ExchangeListViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}

extension ExchangeListViewController:  UITableViewDelegate { }
