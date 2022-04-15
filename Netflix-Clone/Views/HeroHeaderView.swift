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
        addGradient()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.frame = bounds
    }
    
    private func addGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.systemBackground.cgColor
        ]
        gradientLayer.frame = bounds
        layer.addSublayer(gradientLayer)
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct HeroHeaderViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            let heroHeaderView = HeroHeaderView()
       
            return heroHeaderView
        }
        .previewLayout(.fixed(width: UIScreen.main.bounds.width, height: 450))
    }
}
#endif
