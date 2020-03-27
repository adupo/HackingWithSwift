//
//  User+CoreDataClass.swift
//  Friendr
//
//  Created by Aaron Dupont on 2/10/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//
//

import Foundation
import CoreData

public extension CodingUserInfoKey {
    // Helper property to retrieve the context
    static let managedObjectContext = CodingUserInfoKey(rawValue: "managedObjectContext")
}

@objc(User)
public class User: NSManagedObject, Codable {
        @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
            return NSFetchRequest<User>(entityName: "User")
        }

        @NSManaged public var id: String?
        @NSManaged public var name: String?
        @NSManaged public var isActive: Bool
        @NSManaged public var age: Int16
        @NSManaged public var company: String?
        @NSManaged public var email: String?
        @NSManaged public var address: String?
        @NSManaged public var about: String?
        @NSManaged public var registered: String?
        @NSManaged public var tags: [String]?
        @NSManaged public var friends: NSSet?
        
        
        
        public var wrappedId: String {
            id ?? "unkown id"
        }
        
        public var wrappedName: String {
            name ?? "unkownname"
        }
        
        public var wrappedIsActive: Bool {
            isActive
        }
        
        public var wrappedAge: Int16 {
            age
        }
        
        public var wrappedCompany: String {
            company ?? "Unkown company"
        }
        
        public var wrappedEmail: String {
            email ?? "Unkown email"
        }
        
        public var wrappedAddress: String {
            address ?? "Unkown address"
        }
        
        public var wrappedAbout: String {
            about ?? "Unkown about"
        }
        public var wrappedRegistered: String {
            registered ?? "Unkown registered"
        }
        
        public var wrappedTags: [String] {
            tags ?? ["Unkown tags"]
        }
        
        public var friendArray: [Friend] {
            let set = friends as? Set<Friend> ?? []
            
            return set.sorted {
                $0.wrappedName < $1.wrappedName
            }
        }
        
        func setFriends(friends: Set<Friend>) {
            
        }
    
        @objc(addFriendObject:)
        @NSManaged public func addToFriend(_ value: Friend)

        @objc(removeFriendObject:)
        @NSManaged public func removeFromFriend(_ value: Friend)

        @objc(addFriend:)
        @NSManaged public func addToFriend(_ values: NSSet)

        @objc(removeFriend:)
        @NSManaged public func removeFromFriend(_ values: NSSet)
    
        enum CodingKeys: CodingKey {
            case
            id,
            isActive,
            name,
            age,
            company,
            email,
            address,
            about,
            registered,
            tags,
            friends
        }
    
        /* Encode and Decode needed to conform to Codable object
    
            Decode -
            1. try to create a container from decode (which should contain all data)
            2. try to read the data using the keys into the User Class
    
            Encode -
            1. create temp container from encoder using coding keys
            2. encode the data
    
    
         */

    
    required convenience public init(from decoder: Decoder) throws {
        guard let codingUserInfoKeyManagedObjectContext = CodingUserInfoKey.managedObjectContext else {
            fatalError("Failed to get codingUserInfoKeyManagedObject")
        }
        guard let managedObjectContext = decoder.userInfo[codingUserInfoKeyManagedObjectContext] as? NSManagedObjectContext else {
            fatalError("failed to get managedObjectContext")
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "User", in: managedObjectContext) else {
        fatalError("Failed to decode User entity")
        }
        
            self.init(entity: entity, insertInto: managedObjectContext)
        
            let container = try decoder.container(keyedBy: CodingKeys.self)
            id = try container.decode(String.self, forKey : .id)
            isActive = try container.decode(Bool.self, forKey : .isActive)
            name = try container.decode(String.self, forKey : .name)
            age = Int16(try container.decode(Int.self, forKey : .age))
            company = try container.decode(String.self, forKey : .company)
            email = try container.decode(String.self, forKey : .email)
            address = try container.decode(String.self, forKey : .address)
            about = try container.decode(String.self, forKey : .about)
            registered = try container.decode(String.self, forKey : .registered)
            tags = try container.decode([String].self, forKey : .tags)
           // friends = try container.decode([Friend].self, forKey : .friends)
    
        }
    
    public func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            try container.encode(id, forKey : .id)
            try container.encode(isActive, forKey : .isActive)
            try container.encode(name, forKey : .name)
            try container.encode(age, forKey : .age)
            try container.encode(company, forKey : .company)
            try container.encode(email, forKey : .email)
            try container.encode(address, forKey : .address)
            try container.encode(about, forKey : .about)
            try container.encode(registered, forKey : .registered)
            try container.encode(tags, forKey : .tags)
           // try container.encode(friends, forKey : .friends)
        }
}



