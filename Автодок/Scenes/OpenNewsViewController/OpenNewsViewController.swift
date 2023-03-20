//
//  OpenNewsViewController.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import UIKit

final class OpenNewsViewController: UIViewController {
    
    //MARK: - UI
    
    private let backView: CustomButton = {
        let vw = CustomButton()
        vw.imagePozitionType = .centerIcon
        vw.image = ImageHelper.backIcon.withTintColor(ColorHelper.redColor)
        vw.bgColor = ColorHelper.whiteColor
        vw.alpha = 0.8
        vw.corner = 5
        return vw
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.registerCells(PictureNewsCell.self, TitleNewsCell.self, DescriptionNewsCell.self, FullUrlNewsCell.self, DateNewsCell.self)
        collection.backgroundColor = ColorHelper.whiteColor
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
    //MARK: - Private Property
    
    private let viewModel: OpenNewsViewModel
    
    //MARK: - Initiation
    
    init(viewModel: OpenNewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setupStyleView()
        addConstraints()
    }
    
    //MARK: - Private Method
    
    private func bindUI() {
        backView.subject.sink { [weak self] in
            guard let self = self else { return }
            self.navigationController?.popViewController(animated: true)
        }.store(in: &viewModel.cancellables)
    }
    
    private func setupStyleView() {
        viewModel.appendCell()
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = ColorHelper.whiteColor
    }
    
    private func showOpenImageViewController(_ model: NewsItemModel) {
        let viewModel = OpenImageViewModel(urlStrng: model.titleImageURL)
        let viewController = OpenImageViewController(viewModel: viewModel)
        viewController.style(.crossDissolve, presentationStyle: .overFullScreen)
        present(viewController, animated: true)
    }
    
    private func addConstraints() {
        view.addSubviews(collectionView, backView)
        
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIDevice.current.hasNotch ? 60 : 30),
            backView.heightAnchor.constraint(equalToConstant: UIDevice.current.hasNotch ? 50 : 40),
            backView.widthAnchor.constraint(equalToConstant: UIDevice.current.hasNotch ? 50 : 40),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

// MARK: - Collection View Delegate

extension OpenNewsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.size
        return CGSize(width: size.width, height: UIDevice.isIpad ? 500 : (UIDevice.current.hasNotch ? 300 : 200))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModels.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = scrollView.contentOffset.y < 0 ? 0 : scrollView.contentOffset.y
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.getCellViewModel(at: indexPath)
        switch model.type {
        case .picture:
            showOpenImageViewController(viewModel.model)
        case .fullUrl:
            guard let url = URL(string: viewModel.model.fullURL) else {
                AlertHelper.shared.showAlert(title: "Ссылка не работает", actionTitle: "Закрыть")
                return
            }
            UIApplication.shared.open(url)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let model = viewModel.getCellViewModel(at: indexPath)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: model.identifier, for: indexPath)
        cell.viewModel(viewModel.getCellViewModel(at: indexPath))
        return cell
    }
}
