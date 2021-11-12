//
//  ViewController.swift
//  Desafio_CoreData
//
//  Created by Gui Feitosa on 12/11/21.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var personalDataTableView: UITableView!
    
    let viewModel = PeopleViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configTableView()
        
        viewModel.delegate = self
        viewModel.loadData()
    }

    @IBAction func addButton(_ sender: Any) {
        
        let name = nameTextField.text
        let age = ageTextField.text
        
        viewModel.addPeople(name: name, age: age)
    }
    
    @IBAction func removeButton(_ sender: Any) {
        
        let name = nameTextField.text
        let age = ageTextField.text
        
        viewModel.removePeople(name: name, age: age)
    }
    
    func configTableView() {
        personalDataTableView.delegate = self
        personalDataTableView.dataSource = self
        personalDataTableView.allowsSelection = false
        personalDataTableView.separatorStyle = .none
    }
    
    func alterBorderTextFields() {
        nameTextField.layer.borderWidth = 1
        nameTextField.layer.borderColor = UIColor.red.cgColor
        ageTextField.layer.borderWidth = 1
        ageTextField.layer.borderColor = UIColor.red.cgColor
    }
    
    func clearBorderTextFields() {
        nameTextField.layer.borderColor = UIColor.clear.cgColor
        nameTextField.text = ""
        ageTextField.layer.borderColor = UIColor.clear.cgColor
        ageTextField.text = ""
    }

}

extension ViewController: PeopleViewModelDelegate {
     func errorAddPeople() {
        
        let alert = UIAlertController(title: "", message: "Please, add a valid Name or Age", preferredStyle: .alert)

        let okAction = UIAlertAction(title: "Ok", style: .default) { myAlert in
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
        alterBorderTextFields()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2 ) {
            self.clearBorderTextFields()
        }
    }
    
    func reloadData() {
        personalDataTableView.reloadData()
        clearBorderTextFields()
    }
}

extension ViewController: UITableViewDelegate {}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfPeopleOnTheList()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "peopleTableViewCell", for: indexPath) as? PeopleTableViewCell {
            let people = viewModel.people[indexPath.row]
            guard let name = people.name else { return .init()}
            
            cell.setup(name: name, age: people.age)
            return cell
        }
        
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.removePeople(position: indexPath.row)
            
        } else if editingStyle == .insert {
            
        }
    }
}
