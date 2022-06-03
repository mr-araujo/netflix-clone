//
//  MediaCollectionViewCell.swift
//  Netflix-Clone
//
//  Created by Murillo R. Araújo on 22/05/22.
//

import UIKit
import SDWebImage

class MediaCollectionViewCell: UICollectionViewCell {

    static let identifier = "MediaCollectionViewCell"

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill

        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.addSubview(imageView)
    }

    required init?(coder: NSCoder) {
        fatalError()
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        imageView.frame = contentView.bounds
    }

    func configure(with url: String) {
        guard let image = URL(string: "https://image.tmdb.org/t/p/w500/\(url)") else { return }

        imageView.sd_setImage(with: image)
    }
}
