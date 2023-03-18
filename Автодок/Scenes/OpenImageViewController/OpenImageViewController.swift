//
//  OpenImageViewController.swift
//  Автодок
//
//  Created by Кирилл Блохин on 17.03.2023.
//

import UIKit

final class OpenImageViewController: UIViewController {
    
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
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 5.0
        sv.showsVerticalScrollIndicator = false
        return sv
    }()
    
    private let photoImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = ImageHelper.appLaunchIcon
        return img
    }()
    
    private var task: URLSessionDataTask?
    private let viewModel: OpenImageViewModel
    
    //MARK: - Initiation
    
    init(viewModel: OpenImageViewModel) {
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
            self.dismiss(animated: true)
        }.store(in: &viewModel.cancellables)
    }
    
    private func setupStyleView() {
        scrollView.delegate = self
        view.backgroundColor = ColorHelper.blackColor.withAlphaComponent(0.9)
        DispatchQueue.main.async {
            self.task = self.photoImageView.loadImageCache(urlString: self.viewModel.urlStrng)
        }
    }
    
    private func addConstraints() {
        view.addSubviews(scrollView, backView)
        scrollView.addSubviews(photoImageView)
        
        NSLayoutConstraint.activate([
            backView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            backView.topAnchor.constraint(equalTo: view.topAnchor, constant: UIDevice.current.hasNotch ? 60 : 30),
            backView.heightAnchor.constraint(equalToConstant: UIDevice.current.hasNotch ? 50 : 40),
            backView.widthAnchor.constraint(equalToConstant: UIDevice.current.hasNotch ? 50 : 40),
            
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            photoImageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            photoImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: view.frame.width),
            photoImageView.heightAnchor.constraint(equalToConstant: view.frame.height)
        ])
    }
}

// MARK: - Scroll View Delegate

extension OpenImageViewController: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return photoImageView
    }
}
