import UIKit

class ItemViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var items: [Item] = []
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
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
                let newGroup = Item(context: self.context)
                newGroup.title = input
                self.items.append(newGroup)
            }
        }
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(saveButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true)
    }
    
}

extension ItemViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K_Strings.name.itemCell, for: indexPath)
        return cell
    }
    
    
}

