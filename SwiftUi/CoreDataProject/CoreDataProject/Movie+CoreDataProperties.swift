//
//  Movie+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Aaron Dupont on 2/5/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//
//

import Foundation
import CoreData


extension Movie {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movie> {
        return NSFetchRequest<Movie>(entityName: "Movie")
    }

    @NSManaged public var title: String?
    @NSManaged public var year: Int16
    @NSManaged public var director: String?

    public var wrappedTitle: String {
        return title ?? "Unkown title"
    }
}
