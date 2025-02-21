import Foundation
import UIKit

class LeftDetailTableView: UIView {
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .center
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let stackView2: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .fill
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let leftImage: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 10
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.tintColor = UIColor(named: "brandPrimaryColor")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Title"
        label.font = UIFont.preferredFont(forTextStyle: .body)
        label.textColor = UIColor(named: "labelPrimaryColor")
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.textColor = UIColor(named: "labelSecondaryColor")
        label.numberOfLines = 2
        label.lineBreakMode = .byTruncatingTail
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LeftDetailTableView: ViewCode {
    func addSubviews() {
        addSubview(stackView)
      
        stackView.addArrangedSubview(leftImage)
        stackView.addArrangedSubview(stackView2)
        
        stackView2.addArrangedSubview(titleLabel)
        stackView2.addArrangedSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            leftImage.heightAnchor.constraint(equalToConstant: 40),
            leftImage.widthAnchor.constraint(equalToConstant: 40),
        ])
    }
    
    func setupStyle() {
        self.titleLabel.adjustsFontForContentSizeCategory = true
        self.subtitleLabel.adjustsFontForContentSizeCategory = true
        
        DispatchQueue.main.async(qos: .userInteractive, flags: .assignCurrentContext) {
            self.backgroundColor = UIColor(named: "backgroundQuaternaryColor")
        }
    }
}
