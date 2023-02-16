//
//  NewNoteVC.swift
//  NotesApp
//
//  Created by Байсангур on 12.02.2023.
//

import Foundation
import UIKit
import SnapKit
import CoreData

final class NewNoteVC: UIViewController, NSFetchedResultsControllerDelegate {
    
    private enum Text {
        static let aletrTitle = "Name note"
        static let alertPlaceholder = "Enter note title"
        static let alertActionCreateNoteTitle = "OK"
        static let alertActionCancelTitle = "Cancel"
        static let noteTitleNotEntered = "No name note"
        static let text = "Text"
    }
    
    private enum Constants {
        static let sizeFontTextView = CGFloat(20)
    }
    
    private lazy var dataManager = DataManager(delegate: self)

    let textView = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.configureItems()
        self.setupView()
        self.createAlert()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(updateTextView(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func saveNote() {
        let text = self.navigationItem.title ?? Text.text
        let bodyNote = self.textView.text ?? Text.text
        self.dataManager.createNote(text: text, bodyNote: bodyNote)
    }

    @objc private func updateTextView(notification: Notification) {
        guard let userInfo = notification.userInfo as? [String: AnyObject],
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            textView.contentInset = UIEdgeInsets.zero
        } else {
            textView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
            textView.scrollIndicatorInsets = textView.contentInset
        }
        
        textView.scrollRangeToVisible(textView.selectedRange)
    }
    
    @objc private func createAlert() {
        let alert = UIAlertController(title: Text.aletrTitle, message: nil, preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = Text.alertPlaceholder
        }
        
        let alertActionCreateNote = UIAlertAction(title: Text.alertActionCreateNoteTitle, style: .default) {_ in
            if let text = alert.textFields?.first?.text,
               alert.textFields?.first?.text != "" {
                self.navigationItem.title = text
            } else {
                self.navigationItem.title = Text.noteTitleNotEntered
            }
        }
        let alertActionCancel = UIAlertAction(title: "Cancel", style: .destructive) {_ in
            if self.navigationItem.title == nil {
                self.navigationItem.title = Text.noteTitleNotEntered
            }
        }
        
        alert.addAction(alertActionCancel)
        alert.addAction(alertActionCreateNote)
        
        present(alert, animated: true)
    }
    
    private func configureItems() {
        let saveButton = UIBarButtonItem(barButtonSystemItem: .save,
                                         target: self,
                                         action: #selector(saveNote))
        
        let renameButton = UIBarButtonItem(barButtonSystemItem: .edit,
                                           target: self,
                                           action: #selector(createAlert))
        
        self.navigationItem.rightBarButtonItems = [saveButton, renameButton]
    }
    
    private func setupView() {
        self.view.addSubview(textView)
        textView.font = UIFont(name: "AppleSDGothicNeo-Regular", size: Constants.sizeFontTextView)

        textView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

}
