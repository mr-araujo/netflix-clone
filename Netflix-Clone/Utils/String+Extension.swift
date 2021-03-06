//
//  String+Extension.swift
//  Netflix-Clone
//
//  Created by Murillo R. Araújo on 23/04/22.
//

import Foundation

extension String {
    
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
