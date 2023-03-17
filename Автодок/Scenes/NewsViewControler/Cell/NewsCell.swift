//
//  NewsCell.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import UIKit

final class NewsCell: UICollectionViewCell {
    
    //MARK: - UI
    
    private let titleImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.cornerType(type: .all, radius: 10)
        img.backgroundColor = ColorHelper.lightGrayColor.withAlphaComponent(0.1)
        img.clipsToBounds = true
        return img
    }()
    
    private let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = ColorHelper.blackColor
        lb.font = .systemFont(ofSize: 16, weight: .regular)
        lb.textAlignment = .left
        lb.numberOfLines = 2
        return lb
    }()
    
    //MARK: - Initiation
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleImageView.image = nil
        titleLabel.text = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellStyle()
        addConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Configure Cell
    
    func configure(model: NewsItemModel?) {
        DispatchQueue.main.async {
            self.titleImageView.loadImageCache(urlString: model?.titleImageURL ?? "", size: 400)
            self.titleLabel.text = model?.title
        }
    }
    
    //MARK: - Private Method
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(
            titleImageView,
            titleLabel
        )
        
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -50),
            
            titleLabel.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
