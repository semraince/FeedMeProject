//
//  TabBarPresenter.swift
//  yemeksepeti
//
//  Created by semra on 14.08.2021.
//

import Foundation

protocol TabBarPresenterInterface {
    func load()
}
final class TabBarPresenter {
    private weak var view: TabBarControllerInterface!
    init(view: TabBarControllerInterface) {
        self.view = view
    }
}

extension TabBarPresenter: TabBarPresenterInterface {
    func load() {
        view.setViewControllers()
    }
}
