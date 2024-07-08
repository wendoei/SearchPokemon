//
//  String+Extension.swift
//  SearchPokemon
//
//  Created by jihye kim on 08/07/2024.
//

import UIKit

extension String {
   func width(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
