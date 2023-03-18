//
//  OpenNewsCell.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import UIKit

final class PictureNewsCell: UICollectionViewCell {
    
    //MARK: - UI
    
    private let titleImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.backgroundColor = ColorHelper.lightGrayColor.withAlphaComponent(0.1)
        return img
    }()
    
    private var task: URLSessionDataTask?
    
    override func prepareForReuse() {
        super.prepareForReuse()
        task?.cancel()
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
        DispatchQueue.main.async {
            self.task = self.titleImageView.loadImageCache(urlString: modelCopy.titleImageURL)
        }
    }
    
    //MARK: - Private Method
    
    private func setupCellStyle() {
        backgroundColor = .clear
    }
    
    private func addConstraints() {
        contentView.addSubviews(
            titleImageView
        )
        
        titleImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            titleImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
