//
//  FullUrlNewsCell.swift
//  Автодок
//
//  Created by Кирилл Блохин on 17.03.2023.
//

import UIKit

final class FullUrlNewsCell: UICollectionViewCell, MyCellProtocol {
    
    //MARK: - UI
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .systemBlue
        lb.font = .systemFont(ofSize: UIDevice.isIpad ? 13 : 16, weight: .regular)
        lb.textAlignment = .left
        lb.numberOfLines = 0
        lb.lineBreakMode = .byWordWrapping
        return lb
    }()
    
    //MARK: - Public Property
    
    var viewModel: CellNewsViewModelProtocol? {
        didSet {
            guard let model = viewModel?.model else { return }
            titleLabel.text = model.fullURL
        }
    }
    
    //MARK: - Override Method
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
        titleLabel.preferredMaxLayoutWidth = layoutAttributes.size.width - contentView.layoutMargins.left - contentView.layoutMargins.left
        layoutAttributes.bounds.size.height = systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        return layoutAttributes
    }
    
    //MARK: - Initiation
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellStyle()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Method
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
        ])
    }
}
