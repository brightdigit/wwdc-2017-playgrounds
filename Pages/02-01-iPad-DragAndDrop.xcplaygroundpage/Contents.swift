import UIKit
import PlaygroundSupport


class MyViewController : UITableViewController, UITableViewDragDelegate, UITableViewDropDelegate {
  
  var items = (1...5).map(NSNumber.init(value:)).flatMap(numberFormatter.string(from:))
  
  static let numberFormatter = {
    () -> NumberFormatter in
    let formatter = NumberFormatter()
    formatter.numberStyle = .ordinal
    return formatter
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Basic")

    self.tableView.dragDelegate = self
    self.tableView.dropDelegate = self
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return items.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let item = items[indexPath.row]
    let cell = self.tableView.dequeueReusableCell(withIdentifier: "Basic")!
    cell.textLabel?.text = item
    return cell
  }
  
  func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
    let item = items[indexPath.row]
    let itemProvider = NSItemProvider(item: NSString(string: item), typeIdentifier: "public.text")
    return [UIDragItem(itemProvider: itemProvider)]
  }
  
  func tableView(_ tableView: UITableView, canHandle session: UIDropSession) -> Bool {
    return true
  }
  
  func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
    if tableView.hasActiveDrag {
      if session.items.count > 1 {
        return UITableViewDropProposal(operation: .cancel)
      } else {
        return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
      }
    } else {
      return UITableViewDropProposal(operation: .copy, intent: .insertAtDestinationIndexPath)
    }
  }
  
  func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
    let destinationIndexPath: IndexPath
    
    if let indexPath = coordinator.destinationIndexPath {
      destinationIndexPath = indexPath
    } else {
      // Get last index path of table view.
      let section = tableView.numberOfSections - 1
      let row = tableView.numberOfRows(inSection: section)
      destinationIndexPath = IndexPath(row: row, section: section)
    }
    
    coordinator.session.loadObjects(ofClass: NSString.self) { items in
      // Consume drag items.
      let stringItems = items as! [String]
      
      var indexPaths = [IndexPath]()
      for (index, item) in stringItems.enumerated() {
        let indexPath = IndexPath(row: destinationIndexPath.row + index, section: destinationIndexPath.section)
        self.items.insert(item, at: indexPath.row)
        indexPaths.append(indexPath)
      }
      
      tableView.insertRows(at: indexPaths, with: .automatic)
    }
  }
  
  override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
    let item = self.items[sourceIndexPath.row]
    self.items.remove(at: sourceIndexPath.row)
    self.items.insert(item, at: destinationIndexPath.row)
  }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
