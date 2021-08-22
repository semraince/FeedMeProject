//
//  String+Extension.swift
//  yemeksepeti
//
//  Created by semra on 15.08.2021.
//

import Foundation
extension String {
    var imageUrlPath: String {
        "https://restaurantbootcampapp.herokuapp.com/getImage/" + self
    }
}
