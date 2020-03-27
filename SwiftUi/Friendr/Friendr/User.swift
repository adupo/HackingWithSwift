////
////  User.swift
////  Friendr
////
////  Created by Aaron Dupont on 2/7/20.
////  Copyright © 2020 AaronDupont. All rights reserved.
////
//
//import Foundation
//
//struct Friend: Codable {
//    var id = ""
//    var name = ""
//}
//
//struct User: Codable {
//     var id = ""
//     var isActive = false
//     var name = ""
//     var age = 0
//     var company = ""
//     var email = ""
//     var address = ""
//     var about = ""
//     var registered = ""
//     var tags = [String]()
//     var friends = [Friend]()
//
////    init(id: String, name: String) {
////        self.id = id
////        self.name = name
////    }
////
////    enum CodingKeys: CodingKey {
////        case
////        id,
////        isActive,
////        name,
////        age,
////        company,
////        email,
////        address,
////        about,
////        registered,
////        tags,
////        friends
////    }
////
////    /* Encode and Decode needed to conform to Codable object
////
////        Decode -
////        1. try to create a container from decode (which should contain all data)
////        2. try to read the data using the keys into the User Class
////
////        Encode -
////        1. create temp container from encoder using coding keys
////        2. encode the data
////
////
////     */
////
////     init(from decoder: Decoder) throws {
////        let container = try decoder.container(keyedBy: CodingKeys.self)
////        id = try container.decode(String.self, forKey : .id)
////        isActive = try container.decode(Bool.self, forKey : .isActive)
////        name = try container.decode(String.self, forKey : .name)
////        age = try container.decode(Int.self, forKey : .age)
////        company = try container.decode(String.self, forKey : .company)
////        email = try container.decode(String.self, forKey : .email)
////        address = try container.decode(String.self, forKey : .address)
////        about = try container.decode(String.self, forKey : .about)
////        registered = try container.decode(Date.self, forKey : .registered)
////        tags = try container.decode([String].self, forKey : .tags)
////        friends = try container.decode([User].self, forKey : .friends)
////
////    }
////
////    func encode(to encoder: Encoder) throws {
////        var container = encoder.container(keyedBy: CodingKeys.self)
////        try container.encode(id, forKey : .id)
////        try container.encode(isActive, forKey : .isActive)
////        try container.encode(name, forKey : .name)
////        try container.encode(age, forKey : .age)
////        try container.encode(company, forKey : .company)
////        try container.encode(email, forKey : .email)
////        try container.encode(address, forKey : .address)
////        try container.encode(about, forKey : .about)
////        try container.encode(registered, forKey : .registered)
////        try container.encode(tags, forKey : .tags)
////        try container.encode(friends, forKey : .friends)
////    }
////
//
//
//
//}
///*
//id,
//isActive,
//name,
//age,
//company,
//email,
//address,
//about,
//registered,
//tags,
//friends
//*/
