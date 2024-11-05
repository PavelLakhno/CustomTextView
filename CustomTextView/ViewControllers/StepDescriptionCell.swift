//
//  StepDescriptionCell.swift
//  RecipeAddApp
//
//  Created by Pavel Lakhno on 26.09.2024.
//

import UIKit


class StepDescriptionCell: UITableViewCell, UITextViewDelegate {
    
    static let id = "stepDescription"
    
    var textInput: String? = nil {
        didSet {
            stepDescribeTextView.text = textInput
            stepDescribeTextView.placeholder = textInput == nil ? "Введите описание" : nil
        }
    }
    
    lazy var stepDescribeTextView : UITextView = {
        let field = UITextView()
        field.layer.cornerRadius = 8
        field.layer.borderColor = UIColor.orange.cgColor
        field.layer.borderWidth = 1
        field.textAlignment = .left
        field.text = textInput
        field.returnKeyType = .done
        field.isScrollEnabled = false
        field.leftSpace(10)
        field.placeholder = "Введите описание"
        field.translatesAutoresizingMaskIntoConstraints = false
        
        return field
    }()
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        stepDescribeTextView.delegate = self
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        stepDescribeTextView.text = nil
        stepDescribeTextView.placeholder = nil
    }
    
//    func textViewDidChange(_ textView: UITextView) {
//        adjustTextViewHeight()
//    }
    
//    private func adjustTextViewHeight() {
//        let fixedWidth = stepDescribeTextView.frame.size.width
//        let newSize = stepDescribeTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
//        stepDescribeTextView.frame.size = CGSize(width: fixedWidth, height: max(newSize.height, 100)) // минимальная высота 100
//        
//        // уведомляем таблицу об изменении высоты
//        if let tableView = self.superview as? UITableView {
//            UIView.setAnimationsEnabled(false) // временно отключаем анимацию
//            tableView.beginUpdates()
//            tableView.endUpdates()
//            UIView.setAnimationsEnabled(true) // включаем анимацию обратно
//        }
//    }
    
    private func setupCell() {
        selectionStyle = .none
        contentView.addSubview(stepDescribeTextView)
        
        NSLayoutConstraint.activate([
            stepDescribeTextView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            stepDescribeTextView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stepDescribeTextView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stepDescribeTextView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            stepDescribeTextView.heightAnchor.constraint(greaterThanOrEqualToConstant: 90)
        ])
    }
}

