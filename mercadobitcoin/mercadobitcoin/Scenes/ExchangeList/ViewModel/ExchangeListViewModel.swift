import Foundation
import Combine
import UIKit

class ExchangeListViewModel {

    // MARK: - Private Properties

    private var exchangesLogo: [ExchangeLogo] = []
    private var model = [ExchangeModel]()
    
    private let dataRepository: ExchangeListService
    
    // MARK: - Public Properties
    
    var numberOfRows: Int {
        return model.count
    }
        
    // MARK: - Init
    
    init(repository: ExchangeListService = MBExchangeListService()) {
        dataRepository = repository
    }
}

extension ExchangeListViewModel {
    
    // MARK: - Requests
    
    func getExchanges() -> Future<Void, NetworkError> {
        Future { promise in
            self.dataRepository.getExchanges() { completion in
                switch completion {
                case .success(let response):
                    
                    for exchange in response {
                        let object = ExchangeModel(exchangeId: exchange.exchangeId, website: exchange.website, name: exchange.name, image: nil)
                        self.model.append(object)
                    }
                    
                    promise(Result.success(()))
                case .failure(let error):
                    print(error.localizedDescription)
                    promise(.failure(error))
                }
            }
        }
    }
    
    func getLogos() -> Future<Void, NetworkError> {
        Future { promise in
            self.dataRepository.getLogo() { completion in
                switch completion {
                case .success(let response):
                    self.exchangesLogo = response
                    promise(Result.success(()))
                case .failure(let error):
                    print(error.localizedDescription)
                    promise(.failure(error))
                }
            }
        }
    }
}

extension ExchangeListViewModel {
    
    // MARK: - generateCell
    
    func generateCell(tableView: UITableView,
                      indexPath: IndexPath,
                      leftDetailTableViewCellDelegate: LeftDetailTableViewCellDelegate) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: LeftDetailTableViewCell.IDENTIFIER, for: indexPath) as? LeftDetailTableViewCell else {
            assertionFailure("could not dequeue left detail cell")
            return UITableViewCell()
        }
        
        let leftDetailCellViewModel = LeftDetailViewModel()
        let exchange = model[indexPath.row]

        loadImage(cell: cell, exchangeId: exchange.exchangeId ?? "", index: indexPath.row)
        
        leftDetailCellViewModel.create(model: LeftDetail(title: exchange.name ?? "",
                                                         subtitle: exchange.website,
                                                         image: exchange.image ?? UIImage(systemName: "photo.circle.fill"),
                                                         isSafeSubtitle: false,
                                                         isCircularImage: true,
                                                         accessoryType: .disclosureIndicator,
                                                         selectionStyle: .none
                                                        ))
        
        cell.setupValues(with: leftDetailCellViewModel)
        cell.indexPath = indexPath
        cell.delegate = leftDetailTableViewCellDelegate
        
        return cell
    }
}

extension ExchangeListViewModel {
    
    // MARK: - loadImage
    func loadImage(cell: LeftDetailTableViewCell,
                   exchangeId: String,
                   index: Int) {
        
        let imageView = UIImageView()
        
        let logoUrlString = exchangesLogo.first(where: {$0.exchangeId == exchangeId})?.url ?? ""
        var model = self.model.first(where: {$0.exchangeId == exchangeId})

        if let url = URL(string: logoUrlString) {
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                if let cachedImage = ImageCache.shared.image(forKey: logoUrlString) {
                    DispatchQueue.main.async {
                        imageView.image = cachedImage
                    }
                    return
                }
                
                if let error = error {
                    print("Erro ao carregar a imagem: \(error)")
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    print("Dados inválidos ou falha ao converter para UIImage")
                    return
                }
                
                ImageCache.shared.setImage(image, forKey: logoUrlString)

                DispatchQueue.main.async {
                    let imgView = cell.leftDetailTableView.leftImage
                    imgView.image = image
                    
                    model?.image = image
                    self.model[index].image = model?.image
                }
            }.resume()
            
        } else {
            print("URL inválida")
        }
    }
}
