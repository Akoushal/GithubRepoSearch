//
//  View+Extensions.swift
//  GithubRepoSearch
//
//  Created by Koushal, Kumar Ajitesh | Ajitesh | TDD on 2021/07/28.
//

import UIKit

public extension Array where Element: NSLayoutConstraint {
    /**
     Activates all layout constraints inside the array.
     */
    @discardableResult func activate() -> Array {
        forEach { $0.isActive = true }
        return self
    }
}

public extension UIView {
    /**
     Creates layout constrains for snapping the view to the provided superview
     
     - Important: Constraints are not activated. You need
     to activate them for them to take effect.
     */
    func edgesAnchorEqualTo(destinationView: UIView) -> [NSLayoutConstraint] {
        return [leftAnchor.constraint(equalTo: destinationView.leftAnchor),
                rightAnchor.constraint(equalTo: destinationView.rightAnchor),
                topAnchor.constraint(equalTo: destinationView.topAnchor),
                bottomAnchor.constraint(equalTo: destinationView.bottomAnchor)]
    }
}
