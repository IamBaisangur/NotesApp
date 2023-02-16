//
//  NoteCell.swift
//  NotesApp
//
//  Created by Байсангур on 14.02.2023.
//

import Foundation
import UIKit
import SnapKit

final class NoteCell: UITableViewCell {
    
    private enum Constants {
        static let heightCell = 50
        static let insetLeadingTrailingName = 20
        static let insetLeadingTrailingText = 20
        static let insetTopName = 5
        static let offsetTopTextToName = 5
        static let cornerRadiusCell = CGFloat(10)
        static let sizeFontName = CGFloat(20)
        static let sizeFontText = CGFloat(15)
    }
    
    let name = UILabel()
    let text = UILabel()
    var safeArea = UILayoutGuide()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .systemYellow
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - setupView()
    
    func setupView() {
        safeArea = layoutMarginsGuide
        setupCell()
        setupLabel()
    }
    
    func setupCell() {
        self.layer.cornerRadius = Constants.cornerRadiusCell
        safeArea.snp.makeConstraints { make in
            make.height.equalTo(Constants.heightCell)
        }
    }
    
    func setupLabel() {
        addSubview(name)
        addSubview(text)
        
        name.font = UIFont(name: "AppleSDGothicNeo-Regular", size: Constants.sizeFontName)
        text.font = UIFont(name: "AppleSDGothicNeo-Regular", size: Constants.sizeFontText)
        text.textColor = .systemGray
        
        name.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.insetLeadingTrailingName)
            make.top.equalTo(safeArea).inset(Constants.insetTopName)
        }
        
        text.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(Constants.insetLeadingTrailingText)
            make.top.equalTo(name.snp.bottom).offset(Constants.offsetTopTextToName)
        }
    }
    
}
