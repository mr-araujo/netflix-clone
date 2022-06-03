//
//  HomeViewController.swift
//  Netflix-Clone
//
//  Created by Murillo R. Araújo on 13/04/22.
//

import UIKit

enum Sections: Int {
    case TrendingMovies = 0
    case TrendingTV = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    private let sectionTitles = [
        "Trending Movies",
        "Trending TV",
        "Popular",
        "Upcoming Movies",
        "Top Rated"
    ]

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(FeedTableCell.self, forCellReuseIdentifier: FeedTableCell.identifier)
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        configNavbar()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableHeaderView = HeroHeaderView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 450))
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func configNavbar() {
        var image = UIImage(named: "netflixLogo")
        image = image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)
        ]
        
        navigationController?.navigationBar.tintColor = .white
    }

    private func getMedias(with url: String, completion: @escaping ([Media]) -> Void) {
        APICaller.shared.fetchData(url: url) { result in
            switch result {
                case .success(let medias):
                    completion(medias)

                case .failure(let error):
                    print(error)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        
        header.textLabel?.textColor = .white
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        header.textLabel?.frame = CGRect(
            x: header.bounds.origin.x + 20,
            y: header.bounds.origin.y,
            width: 100,
            height: header.bounds.height
        )
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell( withIdentifier: FeedTableCell.identifier, for: indexPath) as? FeedTableCell else {
            return UITableViewCell()
        }

        switch indexPath.section {
            case Sections.TrendingMovies.rawValue:
                getMedias(with: "trending/movies/day") { medias in
                    cell.configure(with: medias)
                }
            case Sections.TrendingTV.rawValue:
                getMedias(with: "trending/tv/day") { medias in
                    cell.configure(with: medias)
                }
            case Sections.Popular.rawValue:
                getMedias(with: "movie/popular") { medias in
                    cell.configure(with: medias)
                }
            case Sections.Upcoming.rawValue:
                getMedias(with: "movie/upcoming") { medias in
                    cell.configure(with: medias)
                }
            case Sections.TopRated.rawValue:
                getMedias(with: "movie/top_rated") { medias in
                    cell.configure(with: medias)
                }
            default:
                return UITableViewCell()
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let defaultOffset = view.safeAreaInsets.top
        let offset = scrollView.contentOffset.y + defaultOffset
        
        navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
    }
}
