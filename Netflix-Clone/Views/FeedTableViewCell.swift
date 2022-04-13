//
//  FeedTableViewCell.swift
//  Netflix-Clone
//
//  Created by Murillo R. Araújo on 13/04/22.
//

import UIKit

class FeedTableViewCell: UITableViewCell {

    static let identifier = "FeedTableViewCell"
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 140, height: 200)
        
        let colletion = UICollectionView(frame: .zero, collectionViewLayout: layout)
        colletion.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
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
}

extension FeedTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .green
        return cell
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct FeedTableViewCellPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let feedTableViewCell = FeedTableViewCell()
       
            return feedTableViewCell
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width,
                              height: 200))
    }
}
#endif
