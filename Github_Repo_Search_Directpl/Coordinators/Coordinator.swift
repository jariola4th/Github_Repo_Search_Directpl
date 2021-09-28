//
//  Coordinator.swift
//  Github_Repo_Search_Directpl
//
//  Created by Joyce on 9/27/21.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    var childCoordinators: [Coordinator] { get set }
    func start()
}
