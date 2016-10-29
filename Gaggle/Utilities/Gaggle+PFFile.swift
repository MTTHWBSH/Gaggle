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
    
    func convertToImage(_ imageCompletion: ((UIImage) -> Void)?) {
        getDataInBackground { (data, error) in
            guard let data = data else { return }
            if error == nil {
                guard let image = UIImage(data: data) else { return }
                imageCompletion?(image)
            } else {
                print(error?.localizedDescription ?? "Error converting to image")
            }
        }
    }
    
}
