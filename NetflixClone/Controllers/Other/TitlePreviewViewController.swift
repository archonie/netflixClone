//
//  TitlePreviewViewController.swift
//  NetflixClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 2.12.2024.
//

import UIKit
import WebKit

class TitlePreviewViewController: UIViewController {

    private let viewModel: TitlePreviewViewModel?
 
    
    private let preview: TitlePreviewView = {
        let preview = TitlePreviewView()
        preview.translatesAutoresizingMaskIntoConstraints = false
        return preview
    }()
    
    init(model: TitlePreviewViewModel) {
        self.viewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(preview)
        guard let model = viewModel else {
            return
        }
        preview.configure(with: model)
        configureConstraints()
    }
    
    private func configureConstraints() {
        let preview = [
            preview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            preview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            preview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            preview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
        ]
        
        NSLayoutConstraint.activate(preview)
    }
    
}


