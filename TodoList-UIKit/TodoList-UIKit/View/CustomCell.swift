//
//  CustomCell.swift
//  TodoList-UIKit
//
//  Created by mac on 5/24/24.
//

import UIKit

class CustomCell: UITableViewCell {

    let animalImageView = UIImageView()
    let nameLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    func setUp() {
        animalImageView.contentMode = .scaleAspectFit
        animalImageView.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(animalImageView)
        contentView.addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            animalImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            animalImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            animalImageView.widthAnchor.constraint(equalToConstant: 50),
            animalImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nameLabel.leadingAnchor.constraint(equalTo: animalImageView.trailingAnchor, constant: 16),
            nameLabel.centerYAnchor.constraint(equalTo: animalImageView.centerYAnchor)
        ])
    }
    


}
