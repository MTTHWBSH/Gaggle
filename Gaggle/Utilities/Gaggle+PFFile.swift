//
//  Gaggle+PFFile.swift
//  Gaggle
//
//  Created by Matt Bush on 4/25/16.
//  Copyright © 2016 Matthew Bush. All rights reserved.
//

import Foundation
import Parse

extension PFFile {
    
    func convertToImage() -> UIImage? {
        var image: UIImage?
        getDataInBackgroundWithBlock { (data, error) in
            guard let data = data else { return }
            if error == nil {
                image = UIImage(data: data)
            } else {
                print(error?.localizedDescription)
            }
        }
        return image
    }
    
}
