//
//  ListViewController.swift
//  DemoTableView
//
//  Created by JONG DEOK KIM on 2022/10/01.
//

import UIKit

class ListViewController: UITableViewController {
    
    var list = Array<ResultsData>()
    
    
    @IBOutlet var userTableView: UITableView!
    
    func getRandomUsers() {
        guard let url = URL(string:
                                "https://randomuser.me/api/?results=200")
        else {
            return
        }
        
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request, completionHandler:
                                                { (data, response, error) -> Void in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                self.list = self.parseJsonData(data:data)
                OperationQueue.main.addOperation({
                    self.tableView.reloadData()
                })
            }
        })
        task.resume()
    }
    
    func parseJsonData(data: Data) -> [ResultsData] {
        var list = [ResultsData]()
        do {
            let root = try JSONDecoder().decode(Root.self, from:data)
            print(root.results)
            print(root.results.count)
            list = root.results
        } catch {
            print(error)
        }
        
        return list
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getRandomUsers()
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return self.list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = self.list[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ListCell", for: indexPath) as! UserCell
        
        cell.lastName?.text = row.name.last
        cell.firstName?.text = row.name.first
        cell.street?.text = row.location.street.name
        cell.cellPhone?.text = row.cell
       
        row.retrieveImage { image, error in
            DispatchQueue.main.async {
                cell.thumbnail.image = image
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("touch row \(indexPath.row)")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "segue_detail") {
            let path = self.userTableView.indexPath(for: sender as! UserCell)
            (segue.destination as? DetailViewController)?.user =
            self.list[path!.row]
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
