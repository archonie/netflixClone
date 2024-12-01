//
//  Extensions.swift
//  NetflixClone
//
//  Created by Doğan Ensar Papuçcuoğlu on 1.12.2024.
//


import Foundation

extension String {
    func capitalizeFirstLetter() -> String {
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
