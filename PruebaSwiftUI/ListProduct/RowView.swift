//
//  RowView.swift
//  PruebaSwiftUI
//
//  Created by Alfredo Salazar on 07/06/22.
//

import SwiftUI

struct RowView: View {
    @ObservedObject var producto: Producto
    var body: some View {
        HStack{
            //Image(systemName: "person").resizable().frame(width: 100, height: 100).padding()
            if let url = URL(string: producto.urlImagenes?.first ?? ""){
                let uima = try? UIImage(data: Data(contentsOf: url))
                Image(uiImage: uima!).resizable().frame(width: 100, height: 100).padding()
            }
            VStack{
                Text("\(producto.nombre ?? "")").font(.title)
            }
            Spacer()
        }
    }
}

struct RowView_Previews: PreviewProvider {
    static var previews: some View {
        RowView(producto: Producto.shared).previewLayout(.fixed(width: 400, height: 120
        ))
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
