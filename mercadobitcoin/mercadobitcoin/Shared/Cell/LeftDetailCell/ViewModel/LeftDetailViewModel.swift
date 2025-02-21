import UIKit
import Combine

class LeftDetailViewModel: ObservableObject {

    // MARK: - Public Properties
    @Published var model = LeftDetail()
}

// MARK: - Public Methods

extension LeftDetailViewModel {
    
    func create(model: LeftDetail) {
        self.model = model
    }
    
    func removeGestureRecognizer(view: UIView) {
        for recognizer in view.gestureRecognizers ?? [] {
            view.removeGestureRecognizer(recognizer)
        }
    }

}
