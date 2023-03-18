//
//  CustomButton.swift
//  Автодок
//
//  Created by Кирилл Блохин on 17.03.2023.
//

import Foundation
import Combine
import UIKit

final class CustomButton: UIButton {
    
    //MARK: - Image Type
    
    enum ImageType {
        case notIcon
        case leftIcon
        case rightIcon
        case centerIcon
    }
    
    //MARK: - UI
    
    private lazy var containerStackView: UIStackView = {
        let stc = UIStackView()
        stc.axis = .horizontal
        stc.distribution = .equalSpacing
        stc.alignment = .center
        stc.isUserInteractionEnabled = false
        return stc
    }()
    
    private let iconImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.isUserInteractionEnabled = false
        return img
    }()
    
    private let titleMyLabel: UILabel = {
        let lb = UILabel()
        lb.isUserInteractionEnabled = false
        return lb
    }()
    
    //MARK: - Public property
    
    // UIImageView
    var imageContentMode: UIView.ContentMode = .scaleAspectFit
    var imagePozitionType: ImageType = .notIcon
    var image: UIImage? = nil
    var corner: CGFloat = 0
    
    // UIStackView
    var spacing: CGFloat = 0
    
    // UILabel
    var textAligment: NSTextAlignment = .natural
    var font: UIFont = .systemFont(ofSize: 10)
    var textColor: UIColor = .white
    var text: String = ""
    
    //View
    var bgColor: UIColor = ColorHelper.redColor
    
    // Other
    var timeAnimation: CGFloat = 0.25
    var valueIndentEdgesTap: CGFloat = 0
    private(set) var subject = PassthroughSubject<Void, Never>()
    
    //MARK: - Override property
    
    override var isHighlighted: Bool {
        didSet {
            setupActivateAnimationView(isHighlighted)
        }
    }
    
    //MARK: - Private property
    
    private var isActiveTouchInside = false
    
    //MARK: - Initiation
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Override Method
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupViewStyle()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard isActiveTouchInside else { return }
        let multiplier = 0.7
        let withTimeInterval = timeAnimation * multiplier
        Timer.scheduledTimer(withTimeInterval: withTimeInterval, repeats: false) { _ in
            self.subject.send()
        }
    }
    
    override func point(inside point: CGPoint, with _: UIEvent?) -> Bool {
        let area = bounds.insetBy(dx: -valueIndentEdgesTap, dy: -valueIndentEdgesTap)
        return area.contains(point)
    }
    
    //MARK: - Private Method
    
    private func setupActivateAnimationView(_ isHighlighted: Bool) {
        isActiveTouchInside = isTouchInside
        if isHighlighted {
            usingSpringWithDampingAnimation(withDuration: timeAnimation, usingSpringWithDamping: 0.3, delay: 0) { [weak self] in
                guard let self = self else { return }
                self.transform = CGAffineTransform.init(scaleX: 0.9, y: 0.9)
            }
        } else {
            usingSpringWithDampingAnimation(withDuration: timeAnimation, usingSpringWithDamping: 0.3, delay: 0) { [weak self] in
                guard let self = self else { return }
                self.transform = CGAffineTransform.init(scaleX: 1, y: 1)
            }
        }
    }
    
    private func setupViewStyle() {
        isExclusiveTouch = true
        iconImageView.contentMode = imageContentMode
        iconImageView.image = image
        titleMyLabel.textColor = textColor
        titleMyLabel.textAlignment = textAligment
        titleMyLabel.font = font
        titleMyLabel.text = text
        getImageType()
        layer.cornerRadius = corner
        backgroundColor = bgColor
        layer.masksToBounds = false
    }
    
    private func getImageType() {
        switch imagePozitionType {
        case .notIcon:
            containerStackView.addArrangedSubview(titleMyLabel)
        case .leftIcon:
            containerStackView.addArrangedSubview(iconImageView)
            containerStackView.addArrangedSubview(titleMyLabel)
        case .rightIcon:
            containerStackView.addArrangedSubview(titleMyLabel)
            containerStackView.addArrangedSubview(iconImageView)
        case .centerIcon:
            containerStackView.addArrangedSubview(iconImageView)
        }
    }
    
    private func addConstraints() {
        addSubviews(containerStackView)
                
        NSLayoutConstraint.activate([
            containerStackView.topAnchor.constraint(equalTo: topAnchor),
            containerStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
