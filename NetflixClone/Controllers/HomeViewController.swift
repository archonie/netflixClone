//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 1.12.2024.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    let sectionTitles: [String] = [
        "Trending Movies",
        "Trending TV",
        "Popular",
        "Upcoming Movies",
        "Top Rated"
    ]
    
    private let homeFeedView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedView)
        homeFeedView.dataSource = self
        homeFeedView.delegate = self
        
        configureNavbar()
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
        homeFeedView.tableHeaderView = headerView
        
        getTrendingMovies()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedView.frame = view.bounds
    }

    private func configureNavbar() {
        if let logoImage = UIImage(named: "netflixLogo") {
            let resizedImage = resizeImage(image: logoImage, targetSize: CGSize(width: 28, height: 30))
            navigationItem.leftBarButtonItem = UIBarButtonItem(image: resizedImage.withRenderingMode(.alwaysOriginal), style: .done, target: self, action: nil)
        }

        let personImage = UIImage(systemName: "person")?.withRenderingMode(.alwaysOriginal)
        let playImage = UIImage(systemName: "play.rectangle")?.withRenderingMode(.alwaysOriginal)

        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: personImage, style: .done, target: self, action: nil),
            UIBarButtonItem(image: playImage, style: .done, target: self, action: nil)
        ]

        navigationController?.navigationBar.tintColor = .label
    }
    
    private func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let renderer = UIGraphicsImageRenderer(size: targetSize)
        return renderer.image { _ in
            image.draw(in: CGRect(origin: .zero, size: targetSize))
        }
    }
    
    private func getTrendingMovies() {
        APICaller.shared.getTrendingMovies { result in
            switch result {
            case .success(let movies):
                print(movies)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {
            return
        }
        header.textLabel?.textColor = .label
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x+20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.text = header.textLabel?.text?.capitalized
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
