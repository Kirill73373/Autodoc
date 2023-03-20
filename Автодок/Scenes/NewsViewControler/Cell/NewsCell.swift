//
//  NewsCell.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import UIKit

final class NewsCell: UICollectionViewCell, MyCellProtocol {    
    
    //MARK: - UI
    
    private let containeView: UIView = {
        let vw = UIView()
        return vw
    }()
    
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
        lb.font = .systemFont(ofSize: 16, weight: .bold)
        lb.textAlignment = .left
        lb.numberOfLines = 2
        return lb
    }()
        
    //MARK: - Public Property

    var viewModel: CellNewsViewModelProtocol? {
        didSet {
            guard let model = viewModel?.model else{ return }
            titleImageView.loadImage(urlString: model.titleImageURL)
            titleLabel.text = model.title
        }
    }
    
    //MARK: - Override Method
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleImageView.image = nil
        titleLabel.text = nil
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
        contentView.addSubviews(containeView)
        containeView.addSubviews(titleImageView, titleLabel)
        
        NSLayoutConstraint.activate([
            containeView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containeView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containeView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containeView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            titleImageView.topAnchor.constraint(equalTo: containeView.topAnchor),
            titleImageView.trailingAnchor.constraint(equalTo: containeView.trailingAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: containeView.leadingAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: containeView.bottomAnchor, constant: -50),
            
            titleLabel.topAnchor.constraint(equalTo: titleImageView.bottomAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: containeView.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: containeView.leadingAnchor)
        ])
    }
}
