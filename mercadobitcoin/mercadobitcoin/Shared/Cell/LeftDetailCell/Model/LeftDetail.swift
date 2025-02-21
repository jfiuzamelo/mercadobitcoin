import UIKit

struct LeftDetail: Equatable {

    var title = String()
    var subtitle: String?

    var image: UIImage?

    var isSafeSubtitle = Bool()
    var isCircularImage = Bool()
    
    var accessoryType: UITableViewCell.AccessoryType = .none
    var selectionStyle: UITableViewCell.SelectionStyle = .default
    
}
