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
    var groups: [Group] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
//MARK: - Navigationbar

    @IBAction func addButton(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Neue Gruppe erstellen", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter new group"
        }
        let saveButton = UIAlertAction(title: "save", style: .default) { action in
            if let input = alert.textFields?.first?.text
            {
                let newGroup = Group(context: self.context)
                newGroup.title = input
                self.groups.append(newGroup)
                self.saveData(group: newGroup)
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    
 //MARK: - CoreData
    
    func saveData(group data: Group)
    {
        do
        {
            try context.save()
            print("Daten wurden erfolgreich gespeichert.")
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.viewDidLoad()
            }
        } catch
        {
            print("das Speichern hat nicht funktioniert")
        }
    }
    
    func loadData()
    {
        do
        {
            groups = try context.fetch(Group.fetchRequest())
            print("Daten erfolgreich geladen.")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch
        {
            print("error beim laden der Daten.")
        }
    }
    
    func deletData()
    {
        do
        {
            try context.save()
            print("Daten wurden erfolgreich gespeichert.")
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.viewDidLoad()
            }
        } catch
        {
            print("das Speichern hat nicht funktioniert")
        }
    }
}

//MARK: - TableView

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return groups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: K_Strings.name.groupCell, for: indexPath)
        cell.textLabel?.text = groups[indexPath.row].title
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle 
    {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) 
    {
        if editingStyle == .delete
        {
            context.delete(groups[indexPath.row])
            groups.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: K_Strings.name.segue, sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let itemVC = segue.destination as! ItemViewController
        if let index = tableView.indexPathForSelectedRow
        {
            itemVC.group = groups[index.row]
        }
    }
}
