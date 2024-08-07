//
//  ViewController.swift
//  TaskOrganizer
//
//  Created by Vitali Schumarov on 07.08.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    leere Gruppe erstellt.
    var Groups: [Group] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Navigationbar

    @IBAction func addButton(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Neue Gruppe erstellen", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter new group"
        }
        let saveButton = UIAlertAction(title: "save", style: .default) { action in
            
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    
}

//MARK: - TableView

//extension ViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
//    {
//        <#code#>
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
//    {
//        <#code#>
//    }
//}
