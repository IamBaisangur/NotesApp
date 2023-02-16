//
//  ViewController.swift
//  NotesApp
//
//  Created by Байсангур on 28.01.2023.
//

import UIKit
import SnapKit
import CoreData

final class ListNotesVC: UIViewController {
    
    private enum Text {
        static let title = "Notes"
    }
    
    private lazy var dataManager = DataManager(delegate: self)
    
    private var note = NoteEntity()

    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = Text.title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        self.configureItems()
        self.setupView()
        self.tableView.register(NoteCell.self, forCellReuseIdentifier: "cellid")
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    

    private func configureItems() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add,
                                                                 target: self,
                                                                 action: #selector(createNewNote))
    }
    
    @objc private func createNewNote() {
        let controller = NewNoteVC()
        let navController = UINavigationController(rootViewController: controller)
        self.splitViewController?.showDetailViewController(navController, sender: nil)
    }
    
    private func setupView() {
        self.view.addSubview(tableView)
        tableView.separatorColor = .white
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension ListNotesVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataManager.count()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellid", for: indexPath)
        let object = self.dataManager.object(at: indexPath)
        
        guard let noteCell = cell as? NoteCell else {
            return cell
        }
        
        noteCell.name.text = object.text
        noteCell.text.text = object.bodyNote
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let note = self.dataManager.object(at: indexPath)
            dataManager.deleteNote(note)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
        let controller = DetailVC()
        controller.note = self.dataManager.object(at: indexPath)
        let navController = UINavigationController(rootViewController: controller)
        self.splitViewController?.showDetailViewController(navController, sender: nil)
    }
}

// MARK: - NSFetchedResultsControllerDelegate

extension ListNotesVC: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

