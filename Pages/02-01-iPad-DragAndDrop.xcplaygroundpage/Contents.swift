import UIKit
import PlaygroundSupport


class MyViewController : UITableViewController, UITableViewDragDelegate, UITableViewDropDelegate {
  
  let items = (1...5).map(NSNumber.init(value:)).flatMap(numberFormatter.string(from:))
  
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
    //self.tableView.dropDelegate = self
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
    return false
  }
  
  func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
    return UITableViewDropProposal(operation: UIDropOperation.cancel)
  }
  
  func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) {
  }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
