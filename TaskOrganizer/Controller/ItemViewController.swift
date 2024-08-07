import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Item] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var group: Group!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
    }
    
    @IBAction func addItem(_ sender: UIBarButtonItem)
    {
        let alert = UIAlertController(title: "Neue Gruppe erstellen", message: "", preferredStyle: .alert)
        alert.addTextField { textField in
            textField.placeholder = "Enter new group"
        }
        let saveButton = UIAlertAction(title: "save", style: .default) { action in
            if let input = alert.textFields?.first?.text
            {
                print("text: \(input)")
                let newItem = Item(context: self.context)
                newItem.todo = input
                newItem.done = false
                newItem.title = self.group.title
                self.items.append(newItem)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.viewDidLoad()
                }
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    
    func saveData(item: Item)
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
            items = try context.fetch(Item.fetchRequest())
            print("Daten erfolgreich geladen.")
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } catch
        {
            print("error beim laden der Daten.")
        }
    }
}

extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K_Strings.name.itemCell, for: indexPath)
        cell.textLabel?.text = items[indexPath.row].todo
        return cell
    }
}

