//
//  HighScoreViewController.swift
//  Bubble Pop
//
//

import Foundation
import UIKit
import CoreData

let gameViewController = GameViewController();
let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;
var highScore = [HighScores]();

class HighScoreViewController: UIViewController {
    
    @IBOutlet weak var highScoreTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getAllHighScores();
        
    }
    
}

extension HighScoreViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

extension HighScoreViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return highScore.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "highScoreCell", for: indexPath);
        let playerData = highScore[indexPath.row];
        // Adding player data to cells
        cell.textLabel?.text = playerData.name;
        cell.detailTextLabel?.text = "Score: \(playerData.score)";
        
        return cell;
    }
    
    // getting all high scores from data base
    func getAllHighScores() {
        do {
            let requestData = HighScores.fetchRequest() as NSFetchRequest<HighScores>;
            // Sorting out the request made to the database;
            let sort = NSSortDescriptor(key: "score", ascending: false);
            requestData.sortDescriptors = [sort];
            
            highScore = try context.fetch(requestData);
            
            DispatchQueue.main.async {
                self.highScoreTableView.reloadData();
            }
        }
        catch {
            print("NO ERROR");
        }
    }
    
}
