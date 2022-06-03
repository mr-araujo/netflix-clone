//
//  FeedTableViewCell.swift
//  Netflix-Clone
//
//  Created by Murillo R. Araújo on 13/04/22.
//

import UIKit

class FeedTableCell: UITableViewCell {

    static let identifier = "FeedTableViewCell"

    private var medias = [Media]()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        
        let colletion = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletion.register(MediaCollectionViewCell.self, forCellWithReuseIdentifier: MediaCollectionViewCell.identifier)
        
        return colletion
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        collectionView.frame = contentView.bounds
    }

    func configure(with medias: [Media]) {
        self.medias = medias

        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension FeedTableCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return medias.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MediaCollectionViewCell.identifier, for: indexPath) as? MediaCollectionViewCell else {
            print("Deu ruim aq")
            return UICollectionViewCell()
        }

        guard let posterPath = medias[indexPath.row].posterPath else {
            print("Ha não, foi aq")
            return UICollectionViewCell()
        }

        cell.configure(with: posterPath)

        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct FeedTableCellPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let feedTableViewCell = FeedTableCell()
       
            return feedTableViewCell
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 200))
    }
}
#endif
