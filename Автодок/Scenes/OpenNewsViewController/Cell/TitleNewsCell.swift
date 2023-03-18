//
//  TitleNewsCell.swift
//  Автодок
//
//  Created by Кирилл Блохин on 17.03.2023.
//

import UIKit

final class TitleNewsCell: UICollectionViewCell {
    
    //MARK: - UI
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.blackColor
        lb.font = .systemFont(ofSize: 25, weight: .semibold)
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        return lb
    }()
    
    var dataModel: NewsItemModel? {
        didSet{
            guard let model = dataModel else{ return }
            titleLabel.text = model.title
        }
    }
    
    var isUpdateConstraints: Bool {
        didSet{
            addConstraints(isUpdateConstraints)
        }
    }
    
    //MARK: - Override Method
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        titleLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    //MARK: - Initiation
    
    override init(frame: CGRect) {
        isUpdateConstraints = false
        super.init(frame: frame)
        setupCellStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Method
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints(_ isUpdateConstraints: Bool) {
        contentView.addSubviews(
            titleLabel
        )
        if isUpdateConstraints {
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
                titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
                titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
                titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            ])
        } else {
            
        }
    }
}
