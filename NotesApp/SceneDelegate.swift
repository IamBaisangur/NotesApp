//
//  SceneDelegate.swift
//  NotesApp
//
//  Created by Байсангур on 28.01.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        let listNotesVC = ListNotesVC()
        let detailVC = DetailVC()
        
        let navListNotesVC = UINavigationController.init(rootViewController: listNotesVC)
        let navDetailVC = UINavigationController.init(rootViewController: detailVC)

        let splitController = UISplitViewController()
        splitController.viewControllers = [navListNotesVC, navDetailVC]
        splitController.preferredDisplayMode = .allVisible
        splitController.delegate = self
        
        splitController.preferredPrimaryColumnWidthFraction = 0.5
        splitController.maximumPrimaryColumnWidth = 2000
        
        self.window?.windowScene = windowScene
        self.window?.rootViewController = splitController
        self.window?.makeKeyAndVisible()
        
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        CoreDataService.shared.saveContext()
    }

}

extension SceneDelegate: UISplitViewControllerDelegate {
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
}

