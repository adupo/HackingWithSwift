//
//  Friend+CoreDataClass.swift
//  Friendr
//
//  Created by Aaron Dupont on 2/10/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//
//

import Foundation
import CoreData

@objc(Friend)
public class Friend: NSManagedObject, Codable {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Friend> {
        return NSFetchRequest<Friend>(entityName: "Friend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var user: User?
    
    public var wrappedId: String {
        id ?? "Unkown Id"
    }
    public var wrappedName: String {
        name ?? "Unkown name"
    }
    
    enum CodingKeys: CodingKey {
            case
            id,
            name
        }
    
        /* Encode and Decode needed to conform to Codable object
    
            Decode -
            1. try to create a container from decode (which should contain all data)
            2. try to read the data using the keys into the User Class
    
            Encode -
            1. create temp container from encoder using coding keys
            2. encode the data
    
    
         */
    
    
    required public convenience init(from decoder: Decoder) throws {
            guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext,
                let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext,
                let entity = NSEntityDescription.entity(forEntityName: "Friend", in: managedObjectContext) else {
                fatalError("Failed to decode User")
            }
            self.init(entity: entity, insertInto: managedObjectContext)
        
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey : .id)
            name = try container.decode(String.self, forKey : .name)
        }
    
    public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey : .id)
            try container.encode(name, forKey : .name)
        }
}
