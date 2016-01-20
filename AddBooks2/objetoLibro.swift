//
//  objetoLibro.swift
//  AddBooks2
//
//  Created by Gandhi Mena Salas on 19/01/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit

class objetoLibro: NSObject {
    
        
        var nombre:NSString
        var author:NSString
        var portada: UIImage
    
    init(name nombre : NSString, author autor: NSString, portada image: UIImage) {
            
            self.nombre = nombre
            self.author = autor
            self.portada = image
            super.init()
        }
    convenience override init() {
        self.init()
    }
}

