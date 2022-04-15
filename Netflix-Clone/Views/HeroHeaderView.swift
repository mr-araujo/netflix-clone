//
//  HeroHeaderView.swift
//  Netflix-Clone
//
//  Created by Murillo R. Araújo on 14/04/22.
//

import UIKit

class HeroHeaderView: UIView {

    let imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.image = UIImage(named: "heroImage")
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds
    }
}
