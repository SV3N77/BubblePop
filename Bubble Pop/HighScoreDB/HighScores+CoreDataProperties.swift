//
//  HighScores+CoreDataProperties.swift
//  Bubble Pop
//
//
//

import Foundation
import CoreData


extension HighScores {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HighScores> {
        return NSFetchRequest<HighScores>(entityName: "HighScores")
    }

    @NSManaged public var name: String?
    @NSManaged public var score: Double

}

extension HighScores : Identifiable {

}
