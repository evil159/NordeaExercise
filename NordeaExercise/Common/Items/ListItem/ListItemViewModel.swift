//
//  ListItemViewModel.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 1.5.2021.
//

import Foundation

protocol ListItem: AnyObject {
    static var identifier: String { get }

    func configure(with viewModel: ListItemViewModel)
}

extension ListItem {
    static var identifier: String {
        return String(describing: self)
    }
}

protocol ListItemViewModel {
    static var associatedListItem: ListItem.Type { get }
}
