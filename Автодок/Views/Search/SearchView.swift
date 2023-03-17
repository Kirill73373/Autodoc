//
//  SearchView.swift
//  Автодок
//
//  Created by Кирилл Блохин on 16.03.2023.
//

import Foundation
import UIKit
import Combine

final class SearchView: UIView {
    
    //MARK: - Delegate Type
    
    enum TypeDelegate {
        case textFieldShouldReturn
        case textFieldDidChangeSelection(String)
    }
    
    //MARK: - UI
    
    private let searchTextView: UITextField = {
        let tf = UITextField()
        tf.textColor = .black
        tf.font = .systemFont(ofSize: 16, weight: .regular)
        tf.textAlignment = .left
        tf.tintColor = ColorHelper.grayColor
        return tf
    }()
    
    private let searchIconView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = ImageHelper.searchIcon
        return img
    }()
    
    private let clearTextIconView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.image = ImageHelper.clearTextIcon.withTintColor(ColorHelper.blackColor)
        img.isHidden = true
        return img
    }()
    
    //MARK: - Private(Read Only) Property
    
    private(set) var typeDelegate = PassthroughSubject<TypeDelegate, Never>()
    private(set) var clearText = PassthroughSubject<Void, Never>()

    //MARK: - Initiation
    
    init(placeholder: String) {
        searchTextView.placeholder = placeholder
        super.init(frame: .zero)
        setupStyleView()
        addConstraints()
        addGestureClearText()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private Method
    
    private func addGestureClearText() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(gestureClearText))
        gesture.numberOfTouchesRequired = 1
        clearTextIconView.isUserInteractionEnabled = true
        clearTextIconView.addGestureRecognizer(gesture)
    }
    
    private func setupStyleView() {
        layer.cornerRadius = 5
        searchTextView.delegate = self
        backgroundColor = ColorHelper.grayColor.withAlphaComponent(0.1)
    }
    
    @objc private func gestureClearText() {
        UIImpactFeedbackGenerator(style: .soft).impactOccurred(intensity: 0.7)
        searchTextView.text?.removeAll()
        clearTextIconView.isHidden = true
        clearText.send()
    }
    
    private func addConstraints() {
        addSubviews(
            searchIconView,
            searchTextView,
            clearTextIconView
        )
        
        searchIconView.translatesAutoresizingMaskIntoConstraints = false
        searchTextView.translatesAutoresizingMaskIntoConstraints = false
        clearTextIconView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            searchIconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchIconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            searchIconView.heightAnchor.constraint(equalToConstant: 20),
            searchIconView.widthAnchor.constraint(equalToConstant: 20),
            
            searchTextView.centerYAnchor.constraint(equalTo: centerYAnchor),
            searchTextView.leadingAnchor.constraint(equalTo: searchIconView.trailingAnchor, constant: 15),
            searchTextView.trailingAnchor.constraint(equalTo: clearTextIconView.leadingAnchor, constant: -15),
            searchTextView.heightAnchor.constraint(equalToConstant: 40),
            
            clearTextIconView.centerYAnchor.constraint(equalTo: centerYAnchor),
            clearTextIconView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            clearTextIconView.heightAnchor.constraint(equalToConstant: 15),
            clearTextIconView.widthAnchor.constraint(equalToConstant: 15),
        ])
    }
}

//MARK: - Text Field Delegate

extension SearchView: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        typeDelegate.send(.textFieldShouldReturn)
        textField.endEditing(true)
        return true
    }
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        guard let text = textField.text else { return }
        clearTextIconView.isHidden = text.isEmpty
        typeDelegate.send(.textFieldDidChangeSelection(text))
    }
}
