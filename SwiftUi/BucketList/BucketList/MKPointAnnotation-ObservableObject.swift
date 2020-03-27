//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Aaron Dupont on 2/17/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    
    public var wrappedTitle : String {
        get {
            self.title ?? "Unknown Value"
        }
        set {
            title = newValue
        }
    }
    
    public var wrappedSubtitle : String {
        get {
            self.subtitle ?? "Unknown Value"
        }
        set {
            subtitle = newValue
        }
    }
}
