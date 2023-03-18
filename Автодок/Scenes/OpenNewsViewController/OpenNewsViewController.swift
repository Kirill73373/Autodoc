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
        layout.sectionInsetReference = .fromContentInset
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.registerCells(
            PictureNewsCell.self,
            TitleNewsCell.self,
            DescriptionNewsCell.self,
            FullUrlNewsCell.self,
            DateNewsCell.self
        )
        collection.backgroundColor = ColorHelper.whiteColor
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    
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
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = ColorHelper.whiteColor
    }
    
    private func showOpenImageViewController(_ model: NewsItemModel) {
        let viewModel = OpenImageViewModel()
        viewModel.urlStrng = model.titleImageURL
        let viewController = OpenImageViewController(viewModel: viewModel)
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overFullScreen
        present(viewController, animated: true)
    }
    
    private func addConstraints() {
        view.addSubviews(
            collectionView,
            backView
        )
        
        backView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
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
        return CGSize(width: size.width, height: UIDevice.current.userInterfaceIdiom == .pad ? 500 : (UIDevice.current.hasNotch ? 300 : 200))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.contentOffset.y = scrollView.contentOffset.y < 0 ? 0 : scrollView.contentOffset.y
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let modelIsType = viewModel.items[indexPath.row]
        switch modelIsType.type {
        case .picture:
            guard let model = viewModel.model else { return }
            showOpenImageViewController(model)
        case .fullUrl:
            guard let model = viewModel.model, let url = URL(string: model.fullURL) else {
                AlertHelper.shared.showAlert(title: "Ссылка не работает", actionTitle: "Закрыть")
                return
            }
            UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.7)
            UIApplication.shared.open(url)
        default:
            break
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let modelIsType = viewModel.items[indexPath.row]
        switch modelIsType.type {
        case .picture:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PictureNewsCell", for: indexPath) as? PictureNewsCell else { return UICollectionViewCell() }
            cell.configure(viewModel.model)
            return cell
        case .title:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TitleNewsCell", for: indexPath) as? TitleNewsCell else { return UICollectionViewCell() }
            cell.dataModel = viewModel.model
            return cell
        case .description:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DescriptionNewsCell", for: indexPath) as? DescriptionNewsCell else { return UICollectionViewCell() }
            cell.dataModel = viewModel.model
            return cell
        case .fullUrl:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FullUrlNewsCell", for: indexPath) as? FullUrlNewsCell else { return UICollectionViewCell() }
            cell.dataModel = viewModel.model
            return cell
        case .date:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DateNewsCell", for: indexPath) as? DateNewsCell else { return UICollectionViewCell() }
            cell.dataModel = viewModel.model
            return cell
            
        }
    }
}
