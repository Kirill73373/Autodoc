//
//  OpenNewsCell.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import UIKit

final class PictureNewsCell: UICollectionViewCell, MyCellProtocol {
    
    //MARK: - UI
    
    private let titleImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = ColorHelper.lightGrayColor.withAlphaComponent(0.1)
        return img
    }()
    
    //MARK: - Public Property
    
    var viewModel: CellNewsViewModelProtocol? {
        didSet {
            guard let model = viewModel?.model else { return }
            titleImageView.loadImage(urlString: model.titleImageURL)
        }
    }
    
    //MARK: - Override Method

    override func prepareForReuse() {
        super.prepareForReuse()
        titleImageView.image = nil
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
    
    //MARK: - Public Method
    
    func configure(_ model: NewsItemModel?) {
        guard let modelCopy = model else { return }
        titleImageView.loadImage(urlString: modelCopy.titleImageURL)
    }
    
    //MARK: - Private Method
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(titleImageView)
        
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
