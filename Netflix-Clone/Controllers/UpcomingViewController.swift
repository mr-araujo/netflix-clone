//
//  UpcomingViewController.swift
//  Netflix-Clone
//
//  Created by Murillo R. Araújo on 13/04/22.
//

import UIKit

class UpcomingViewController: UIViewController {

    private var medias = [Media]()

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        return table
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Upcoming"
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always

        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

        fetchUpcoming()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        tableView.frame = view.bounds
    }

    private func fetchUpcoming() {
        APICaller.shared.fetchData(url: "movie/upcoming") { result in
            switch result {
                case .success(let medias):
                    self.medias = medias

                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }

                case .failure(let error):
                    print(error)
            }
        }
    }
}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medias.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = medias[indexPath.row].posterPath ?? "Unknown"

        return cell
    }
}
