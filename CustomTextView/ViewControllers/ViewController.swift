//
//  ViewController.swift
//  CustomTextView
//
//  Created by Pavel Lakhno on 01.11.2024.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let button = UIButton(frame: CGRect(x: 150, y: 100, width: 200, height: 50))
        button.backgroundColor = .green
        button.setTitle("Create Recipe", for: .normal)
        button.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)

        self.view.addSubview(button)
        self.view.backgroundColor = .white

    }
    
    @objc func plusButtonTapped() {
        let createRecipeViewController = StepTableViewController() //RecipeAddController() //TableViewController() //TestViewController()//RecipeTVC()
        createRecipeViewController.modalPresentationStyle = .automatic
        present(createRecipeViewController, animated: true, completion: nil)
    }
}

