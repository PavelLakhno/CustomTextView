//
//  StepTVController.swift
//  RecipeAddApp
//
//  Created by Pavel Lakhno on 26.09.2024.
//

import UIKit

struct CellData{
    var id: String
    var image: UIImage?
    var describe: String?
}

class StepTableViewController: UIViewController {
    
    var sectionData:[CellData] = []
    var customIndexPathSection: Int = 0
    var indexPath: IndexPath!
    
    private var contentSize : CGSize {
        CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    private lazy var scrollView : UIScrollView = {
        let scroll = UIScrollView()
        scroll.contentSize = contentSize
        scroll.frame = view.bounds
        return scroll
    }()
    
    private lazy var contentView : UIView = {
        let content = UIView()
        content.frame.size = contentSize
        return content
    }()
    
    private lazy var contentStackView : UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.distribution = .fill
        stack.alignment = .leading
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let stepsTableView : UITableView = {
        let tableView = UITableView()
        tableView.isScrollEnabled = false
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var addNewStepButton : UIButton = {
        let btn = UIButton()
        btn.setTitle("Добавить шаг", for: .normal)
        btn.setTitleColor(.gray, for: .normal)
//        btn.titleLabel?.font = .helveticalBold(withSize: 16)
//        btn.setImage(Resources.Images.Icons.plus, for: .normal)
        btn.addTarget(self, action: #selector(addStepTapped(_:)), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    

    @objc private func addStepTapped(_ sender: UIButton) {

        sectionData.append(CellData(id: StepDescriptionCell.id))

        let indexPath = IndexPath(row: sectionData.count - 1, section: 0)
        stepsTableView.insertRows(at: [indexPath], with: .automatic)
        stepsTableView.beginUpdates()
        stepsTableView.endUpdates()
        stepsTableView.dynamicViewHeight()
    }

    
    // MARK: - LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        sectionData = [CellData(id: StepDescriptionCell.id)]

        addSubviews()
        setupTableViews()
        setupConstraints()
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        print(sectionData)
        
        stepsTableView.dynamicViewHeight()
    }
    
    private func setupTableViews() {
        stepsTableView.delegate = self
        stepsTableView.dataSource = self
        stepsTableView.register(StepDescriptionCell.self, forCellReuseIdentifier: StepDescriptionCell.id)

    }
    
    // MARK: - Configure UI
    private func addSubviews() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(contentStackView)

        contentStackView.addArrangedSubview(stepsTableView)
        contentStackView.addArrangedSubview(addNewStepButton)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            stepsTableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            stepsTableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),

            addNewStepButton.heightAnchor.constraint(equalToConstant: 24),
        ])
    }
}


// MARK: - UITableViewDataSource, UITableViewDelegate
extension StepTableViewController : UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(sectionData)
        let cell = sectionData[indexPath.row]
        
        let cellDescription = tableView.dequeueReusableCell(withIdentifier: cell.id, for: indexPath) as! StepDescriptionCell

        cellDescription.textInput = cell.describe
        cellDescription.stepDescribeTextView.delegate = self

        return cellDescription
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        sectionData.count > 1
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        self.indexPath = indexPath
        
        if editingStyle == .delete {
            sectionData.remove(at: indexPath.row)
            stepsTableView.deleteRows(at: [indexPath], with: .none)
        }

        stepsTableView.beginUpdates()
        DispatchQueue.main.async {
            self.stepsTableView.reloadData()
        }
        stepsTableView.endUpdates()
        stepsTableView.dynamicViewHeight()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        50
    }

}



// MARK: - UITextViewDelegate
extension StepTableViewController : UITextViewDelegate {

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

        if textView.textColor == UIColor.lightGray {
            textView.textColor = UIColor.black
        }
        return true
    }

    func textViewDidBeginEditing(_ textView: UITextView) {


        textView.clearButtonStatus = !textView.hasText

        let cell: StepDescriptionCell = textView.superview?.superview as! StepDescriptionCell
        let tableView: UITableView  = cell.superview as! UITableView
        indexPath = tableView.indexPath(for: cell)!
        print("Begin")
        print(indexPath)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        textView.endEditing(true)
        textView.resignFirstResponder()
        textView.clearButtonStatus = true

    }

    func textViewDidChange(_ textView: UITextView) {

        textView.placeholder = textView.hasText ? nil : "Введите описание"
        textView.clearButtonStatus = !textView.hasText

        print("section: \(indexPath.section)")
        print("row: \(indexPath.row)")
        sectionData[indexPath.row].describe = textView.text
        
         //Обновляем высоту ячейки
        stepsTableView.beginUpdates()
        stepsTableView.endUpdates()
        stepsTableView.dynamicViewHeight()
    }
}
