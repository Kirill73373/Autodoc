//
//  NewsViewControler.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import UIKit
import Combine

final class NewsViewControler: UIViewController {
    
    //MARK: - UI
    
    private let searchView = SearchView(placeholder: "Поиск")
    
    private let refresherControl: UIRefreshControl = {
        let ref = UIRefreshControl()
        ref.tintColor = ColorHelper.redColor
        return ref
    }()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 40
        layout.scrollDirection = .vertical
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.registerCells(NewsCell.self)
        collection.backgroundColor = ColorHelper.whiteColor
        collection.showsVerticalScrollIndicator = false
        collection.contentInset = UIEdgeInsets(top: 85, left: 10, bottom: 100, right: 10)
        return collection
    }()
    
    private let emptyImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = ImageHelper.emptyIcon
        return img
    }()
    
    private let scrollToTopView: CustomButton = {
        let vw = CustomButton()
        vw.imagePozitionType = .centerIcon
        vw.image = ImageHelper.backToTopIcon
        vw.corner = 35
        vw.isHidden = true
        vw.alpha = 0
        return vw
    }()
    
    private let viewModel: NewsViewModel
    
    //MARK: - Initiation
    
    init(viewModel: NewsViewModel) {
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
        addSearchDelegate()
    }
    
    //MARK: - Private Method
    
    private func bindUI() {
        viewModel.subjectModel.receive(on: DispatchQueue.main).sink { [weak self] model in
            guard let self = self else { return }
            self.viewModel.model = model
            self.reloadData()
            self.refresherControl.endRefreshing()
        }.store(in: &viewModel.cancellables)
        
        scrollToTopView.subject.sink { [weak self] in
            guard let self = self else { return }
            self.collectionView.scroll(row: 0)
        }.store(in: &viewModel.cancellables)
        
        searchView.clearText.sink { [weak self] in
            guard let self = self else { return }
            self.reloadData()
        }.store(in: &viewModel.cancellables)
        
        NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification).sink { [weak self] _ in
            guard let self = self else { return }
            self.viewModel.getNewsRequest()
        }.store(in: &viewModel.cancellables)
    }
    
    private func reloadData() {
        viewModel.modelCopy = viewModel.model
        emptyImageView.isHidden = !(viewModel.modelCopy?.news.isEmpty ?? true)
        collectionView.animationReloadData()
    }
    
    private func showOpenNewsViewController(_ model: NewsItemModel) {
        let viewModel = OpenNewsViewModel()
        viewModel.model = model
        let viewController = OpenNewsViewController(viewModel: viewModel)
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func setupStyleView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        view.backgroundColor = ColorHelper.whiteColor
        navigationController?.navigationBar.isHidden = true
        refresherControl.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc private func didPullToRefresh() {
        viewModel.getNewsRequest()
    }
    
    private func addConstraints() {
        view.addSubviews(
            collectionView,
            emptyImageView,
            searchView,
            scrollToTopView
        )
        
        collectionView.addSubview(refresherControl)
        
        emptyImageView.translatesAutoresizingMaskIntoConstraints = false
        searchView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        scrollToTopView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            emptyImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            emptyImageView.heightAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 400 : 200),
            emptyImageView.widthAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .pad ? 450 : 250),
            
            searchView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIDevice.current.hasNotch ? 60 : 30),
            searchView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            searchView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            searchView.heightAnchor.constraint(equalToConstant: 45),
            
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            scrollToTopView.heightAnchor.constraint(equalToConstant: 70),
            scrollToTopView.widthAnchor.constraint(equalToConstant: 70),
            scrollToTopView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            scrollToTopView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}

extension NewsViewControler {
    
    private func addSearchDelegate() {
        searchView.typeDelegate.sink { [weak self] type in
            guard let self = self else { return }
            switch type {
            case .textFieldShouldReturn:
                self.collectionView.animationReloadData()
            case .textFieldDidChangeSelection(let text):
                guard let modelNews = self.viewModel.model else { return }
                if text.count != 0 {
                    self.reloadData()
                    if !modelNews.news.isEmpty {
                        let search = self.viewModel.model?.news.filter { model in
                            return model.title.range(of: text, options: .caseInsensitive, range: nil, locale: nil) != nil
                        }
                        self.viewModel.modelCopy?.news = search ?? []
                        self.emptyImageView.isHidden = !(search?.isEmpty ?? false)
                    }
                    self.reloadData()
                } else {
                    self.reloadData()
                }
            }
        }.store(in: &viewModel.cancellables)
    }
}

// MARK: - Collection View Delegate

extension NewsViewControler: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - 20, height: .zero)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.7)
        guard let model = viewModel.modelCopy?.news[indexPath.row] else { return }
        showOpenNewsViewController(model)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let model = viewModel.modelCopy else { return 0 }
        return model.news.count
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.05, delay: 0) {
            self.searchView.alpha = scrollView.contentOffset.y >= (UIDevice.current.hasNotch ? -110 : -90) ? 0 : 1
            self.scrollToTopView.alpha = scrollView.contentOffset.y >= 100 ? 0.8 : 0
            self.scrollToTopView.isHidden = scrollView.contentOffset.y <= 100
        }
        view.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCell", for: indexPath) as? NewsCell else { return UICollectionViewCell() }
        cell.configure(viewModel.modelCopy?.news[indexPath.row])
        return cell
    }
}
