//
//  SubtitleItemViewModel.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 1.5.2021.
//

import Foundation

struct SubtitleItemViewModel: ListItemViewModel {
    static var associatedListItem: ListItem.Type = SubtitleItem.self

    let title: String
    let description: String?
    let infoText: String?
}
