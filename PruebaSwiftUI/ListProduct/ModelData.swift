//
//  ModelData.swift
//  PruebaSwiftUI
//
//  Created by Alfredo Salazar on 07/06/22.
//

import Foundation
import SwiftUI
struct Productos: Codable{
    var codigo: String?
    var resultado: Resultado?
}

struct Resultado: Codable{
    var categoria: String?
    var productos: [Producto]?
}

class Producto: Codable, ObservableObject{
    static var shared = Producto()
    init() {
        
    }
    //var identifier = UUID()
    var id: String?
    var nombre: String?
    var urlImagenes: [String]?
    var precioFinal: Double?
    var categoria: String?
    var codigoCategoria: String?
}
struct ProductoSeleccionado{
    var id: String = ""
    var nombre: String = ""
    var urlImagenes: [Imageness] = []
    var precioFinal: Double = 0.0
    var categoria: String = ""
    var codigoCategoria: String = ""
    var isSelected = false
}

struct Imageness{
    var idenfifier = 0
    var image: String = ""
}
