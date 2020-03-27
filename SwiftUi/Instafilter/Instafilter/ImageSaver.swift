//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Aaron Dupont on 2/12/20.
//  Copyright © 2020 AaronDupont. All rights reserved.
//

import UIKit

class ImageSaver: NSObject {
    var successHandler: (() -> Void)?
    var errorHandler: ((Error) -> Void)?
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveError), nil)
    }
    
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        //save complete so tell Swift UI!
        if let error = error {
            errorHandler?(error)
        } else {
            successHandler?()
        }
    }
}
