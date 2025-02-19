import UIKit
import Combine

class ExchangeListViewController: UIViewController {
    
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
    
    // MARK: getCarsFromAPI

    private func getExchanges() {

        viewModel.getExchanges().sink { completion in
            switch completion {
            case .finished:
                break
            case .failure(let error):
                print(error)
            }
        } receiveValue: { result in
            // Needed .now() + 0.3 to avoid loading view animation stuck
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, qos: .userInteractive, flags: .assignCurrentContext) {
                self.exchangeListView.tableView.reloadData()
            }
        }.store(in: &cancellables)
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
