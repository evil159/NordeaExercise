//
//  SubtitleCell.swift
//  NordeaExercise
//
//  Created by Laitarenko Roman on 1.5.2021.
//

import Foundation
import UIKit

final class SubtitleItem: UITableViewCell, ListItem {
    private var accessoryLabel: UILabel? {
        return accessoryView as? UILabel
    }

    // MARK: - Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()

        accessoryLabel?.textColor = .tertiaryLabel
        accessoryLabel?.font = UIFont.preferredFont(forTextStyle: .body)
    }

    // MARK: - ListItem

    func configure(with viewModel: ListItemViewModel) {
        guard let viewModel = viewModel as? SubtitleItemViewModel else {
            return
        }

        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.description
        accessoryLabel?.text = viewModel.infoText

        accessoryLabel?.sizeToFit()
    }
}
