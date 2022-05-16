//
//  GameViewController.swift
//  Bubble Pop
//
//

import Foundation
import UIKit
import CoreData

var highestScores = [HighScores]();
let gameContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext;

class GameViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var remainingTimeLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highScoreLabel: UILabel!
    
    var name:String?;
    var remainingTime = 60;
    var timer = Timer();
    var bubble = Bubble();
    var bubblesArray = [Bubble]();
    var maxBubbles = 15;
    var clickedBubble = 0;
    var currentScore: Double = 0;
    var curHighScore: Double = 0;
    var pName: String = "Player";
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.navigationItem.setHidesBackButton(true, animated: true);
        getFirstScoreInDb();
        // remaining time
        remainingTimeLabel.text = String(remainingTime);
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true){
            timer in
            self.generateBubble();
            self.removeBubblesFromArray();
            self.counting();
        }
        // if there is no highscore then defaults to 0
        // else then use first high score
        if (highestScores.isEmpty){
            curHighScore = 0;
            highScoreLabel.text = "0";
        } else {
            let highestPlayer = highestScores[0];
            curHighScore = Double(highestPlayer.score);
            highScoreLabel.text = "\(highestPlayer.score)";
        }
    }
    
    @objc func counting(){
        remainingTime -= 1;
        remainingTimeLabel.text = String(remainingTime);
        
        if remainingTime == 0 {
            timer.invalidate();
            // saving current score to the highscore table
            saveHighScore(name: name!, score: currentScore);
            // show high score screen
            let vc = storyboard?.instantiateViewController(identifier: "HighScoreViewController") as! HighScoreViewController;
            self.navigationController?.pushViewController(vc, animated: true);
            vc.navigationItem.setHidesBackButton(true, animated: true);
        }
        
        
    }
    
    
    @objc func generateBubble(){
        // random number to create at a time
        let numberToCreated = arc4random_uniform(UInt32(maxBubbles - bubblesArray.count)) + 1;
        var i = 0;
        // while loop for how many bubbles being created
        while i < numberToCreated {
        bubble = Bubble();
        if !isOverlapping(createdBubble: bubble){
        bubble.addTarget(self, action: #selector(bubblePressed), for: .touchUpInside);
        self.view.addSubview(bubble);
            bubble.animation();
            i += 1;
            // adding bubble to array
            bubblesArray += [bubble];
        }
        }
    }
    
    
    @IBAction func bubblePressed(_ sender: Bubble){
        // remove pressed bubble from view
        sender.removeFromSuperview();
        // add points to the score
        // checks for last bubble clicked and * 1.5 to score
        if(clickedBubble == sender.value){
            currentScore += Double(sender.value) * 1.5;
        } else {
            currentScore += Double(sender.value);
        }
        clickedBubble = sender.value;
        scoreLabel.text = "\(currentScore)"
        
    }
    
    func isOverlapping(createdBubble: Bubble) -> Bool {
        // loops in bubble array
        for currentBubble in bubblesArray{
            // checks if bubbles in array is ovelapping each other
            if createdBubble.frame.intersects(currentBubble.frame) {
                return true;
            }
        }
        return false;
    }
    
    @objc func removeBubblesFromArray(){
        // loops in bubbles array to remove the bubbles after a random time
        var i = 0
        while i < bubblesArray.count {
            if arc4random_uniform(100) < 30 {
                bubblesArray[i].removeFromSuperview()
                bubblesArray.remove(at: i)
                i += 1
            }
        }
    }
    
    func saveHighScore(name: String, score: Double){
        // saving new highscore
        let nPlayer = HighScores(context: context);
        if (name.isEmpty){
            nPlayer.name = pName;
        } else {
            nPlayer.name = name;
        }
        nPlayer.score = Double(score);

        do {
            try context.save();
        } catch {
            print("NO ERROR")
        }
    }
    // get first high score in db
    func getFirstScoreInDb() {
        do {
            let request = HighScores.fetchRequest() as NSFetchRequest<HighScores>;
            // Sorting out the request made to the HighScore data base
            let sort = NSSortDescriptor(key: "score", ascending: false);
            request.sortDescriptors = [sort];
            request.fetchLimit = 1;
            
            highestScores = try gameContext.fetch(request);
        }
        catch {
            print("No Error!");
        }
    }
}
