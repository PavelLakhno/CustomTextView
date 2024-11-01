//
//  StepDescriptionCell.swift
//  RecipeAddApp
//
//  Created by Pavel Lakhno on 26.09.2024.
//

import UIKit


class StepDescriptionCell: UITableViewCell {
    
    static let id = "stepDescription"
    
    
    lazy var stepDescribeTextView : UITextView = {
        let field = UITextView()
        field.layer.cornerRadius = 8
        field.layer.borderColor = UIColor.orange.cgColor
        field.layer.borderWidth = 1
        field.textAlignment = .left
        field.textColor = .lightGray
        field.returnKeyType = .done
        field.isScrollEnabled = false
        field.leftSpace(10)
        field.placeholder = "Введите описание"
        field.translatesAutoresizingMaskIntoConstraints = false

        return field
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        checkText()
        setupCell()
    }
    
    override func prepareForReuse() {
        stepDescribeTextView.text = nil
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func checkText() {
        if stepDescribeTextView.text != nil {
            stepDescribeTextView.placeholder = nil
            stepDescribeTextView.textColor = UIColor.black
        } else {
            stepDescribeTextView.placeholder = "Введите описание"
            stepDescribeTextView.textColor = UIColor.lightGray
        }
    }
   
    private func setupCell() {
        selectionStyle = .none
        contentView.addSubview(stepDescribeTextView)
//        stepDescribeTextView.setConstraints()
        
        NSLayoutConstraint.activate([
            stepDescribeTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stepDescribeTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stepDescribeTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            stepDescribeTextView.heightAnchor.constraint(equalToConstant: 88)
            stepDescribeTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),

        ])
    }
    
    
}

