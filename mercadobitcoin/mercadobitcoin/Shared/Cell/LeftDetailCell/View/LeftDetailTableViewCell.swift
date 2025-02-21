import UIKit
import Combine

// MARK: - LeftDetailTableViewCellDelegate

protocol LeftDetailTableViewCellDelegate: AnyObject {
    func leftDetailCellSelected(index: IndexPath?)
}

// MARK: - LeftDetailTableViewCell

class LeftDetailTableViewCell: UITableViewCell {
    
    static let IDENTIFIER: String = "LeftDetailTableViewCell"
    
    // MARK: - Private Properties
    
    var leftDetailTableView: LeftDetailTableView = {
        let view = LeftDetailTableView()
        return view
    }()
 
    
    // MARK: - Public Properties

    weak var delegate: LeftDetailTableViewCellDelegate?
    var indexPath: IndexPath?
    var disableGestureRecognizer = false

    // MARK: - Public Properties
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        contentView.addSubview(leftDetailTableView)
    }
    
    override func prepareForReuse() {
        leftDetailTableView.titleLabel.text = String()
        leftDetailTableView.subtitleLabel.text = String()
        leftDetailTableView.leftImage.image = UIImage()
    }

}

extension LeftDetailTableViewCell {
    
    // MARK: Setup Values with view model
 
    /// Setup initial values
    func setupValues(with viewModel: LeftDetailViewModel) {
        
        // Title
        leftDetailTableView.titleLabel.text = viewModel.model.title
        
        layoutSubviews()
        
        // Accessory Type
        self.accessoryType = viewModel.model.accessoryType
        
        // Selection Style
        self.selectionStyle = viewModel.model.selectionStyle
        
        // Subtitle
        if viewModel.model.subtitle == "" {
            leftDetailTableView.subtitleLabel.isHidden = true
        } else {
            leftDetailTableView.subtitleLabel.isHidden = false
        }
        
        if let text = viewModel.model.subtitle {
            leftDetailTableView.subtitleLabel.text = text
            leftDetailTableView.subtitleLabel.isHidden = false
        } else {
            leftDetailTableView.subtitleLabel.isHidden = true
        }
        
        if leftDetailTableView.subtitleLabel.isHidden == false {
            // Apply mask on subtitleLabel if needed
            if viewModel.model.isSafeSubtitle {
                leftDetailTableView.subtitleLabel.text = viewModel.model.subtitle
            }
        }
        
        // Image
        if viewModel.model.image == nil {
            leftDetailTableView.leftImage.isHidden = true
        } else {
            leftDetailTableView.leftImage.image = viewModel.model.image
            leftDetailTableView.leftImage.isHidden = false
        }
        
        // Circular Image: turn leftImage circular if needed
        if viewModel.model.isCircularImage {
            leftDetailTableView.leftImage.roundAllCorners(radius: leftDetailTableView.leftImage.frame.height/2)
            leftDetailTableView.leftImage.contentMode = .scaleAspectFit
        }
   
    }
}

extension UIView {
    /// Apply custom corners in a view
    func round(_ corners: UIRectCorner, radius: CGFloat) {
        let uiBezierPath = UIBezierPath(roundedRect: bounds,
                                        byRoundingCorners: corners,
                                        cornerRadii: CGSize(width: radius,
                                                            height: radius))
        
        let caShapeLayer = CAShapeLayer()
        
        caShapeLayer.path = uiBezierPath.cgPath
        layer.mask = caShapeLayer
    }

    func roundAllCorners(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }

    func makeCircle() {
        roundAllCorners(radius: self.frame.width/2)
    }
    
    func removeRoundCorners() {
        self.layer.cornerRadius = .infinity
        self.layer.masksToBounds = false
    }
}
