import UIKit
import Combine

class ExchangeListViewController: UIViewController, LeftDetailTableViewCellDelegate {
    
    // MARK: - Private Properties
    private var cancellables = Set<AnyCancellable>()
    
    private var exchangeListView: ExchangeListView = {
        let view = ExchangeListView()
        return view
    }()
    
    let viewModel = ExchangeListViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = exchangeListView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        exchangeListView.tableView.dataSource = self
        exchangeListView.tableView.delegate = self
    }
    
    // MARK: View Did Appear
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getExchanges()
    }
    
}

extension ExchangeListViewController {
    
    private func getExchanges() {
        
        viewModel.getExchanges().sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        } receiveValue: { result in
            self.getLogo()
        }.store(in: &cancellables)
    }
    
    private func getLogo() {
        
        viewModel.getLogos().sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        } receiveValue: { result in
            DispatchQueue.main.async(qos: .userInteractive, flags: .assignCurrentContext) {
                self.exchangeListView.tableView.reloadData()
            }
        }.store(in: &cancellables)
    }
    
}

extension ExchangeListViewController:  UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return viewModel.generateCell(tableView: tableView, indexPath: indexPath, leftDetailTableViewCellDelegate: self)
    }
}

extension ExchangeListViewController:  UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
}

extension ExchangeListViewController {
    func leftDetailCellSelected(index: IndexPath?) {
        
    }
}
