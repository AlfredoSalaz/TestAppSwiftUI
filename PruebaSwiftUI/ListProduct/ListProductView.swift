//
//  ListProductView.swift
//  PruebaSwiftUI
//
//  Created by Alfredo Salazar on 07/06/22.
//

import SwiftUI

struct ListProductView: View {
    @State var productos: Productos?
    @State var producto = Producto.shared
    @State private var isLoading = false
    @State private var ocurredError = false
    @EnvironmentObject var prod: Product
    
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        ZStack{
            
            VStack{
                List(productos?.resultado?.productos ?? [], id: \.id){
                    producto in
                    Button(action: {
                        prod.productSeleccionado.urlImagenes.removeAll()
                        prod.productSeleccionado.id = producto.id ?? ""
                        prod.productSeleccionado.nombre = producto.nombre ?? ""
                        prod.productSeleccionado.categoria = productos?.resultado?.categoria ?? ""
                        prod.productSeleccionado.precioFinal = producto.precioFinal ?? 0.0
                        prod.productSeleccionado.isSelected = true
                        var count = 0
                        producto.urlImagenes?.forEach{
                            count += count
                            let a = Imageness(idenfifier: count, image: $0)
                            prod.productSeleccionado.urlImagenes.append(a)
                            count += 1
                        }
                        
                        prod.productSeleccionado.codigoCategoria = producto.codigoCategoria ?? ""
                        self.presentationMode.wrappedValue.dismiss()
                    }, label: {
                        RowView(producto: producto)
                    })
                }
            }
            if isLoading{
                VStack{
                    ActivityIndicator().frame(width: 100, height: 100, alignment: .center).foregroundColor(.orange)
                }
            }
            if ocurredError{
                VStack{
                    Text("Sin resultados")
                }
            }
            
        }.onAppear{
            prod.productSeleccionado.isSelected = false
            isLoading = true
            DispatchQueue.main.async {
                self.loadListproduct()
            }
        }
        .navigationTitle("Lista de Productos")
    }
    private func loadListproduct(){
        guard let url = URL(string: "http://alb-dev-ekt-875108740.us-east-1.elb.amazonaws.com/sapp/productos/plp/1/ad2fdd4bbaec4d15aa610a884f02c91a") else{return}
        
        let session = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard let data = data else {return}
            do{
                let respuesta = try JSONDecoder().decode(Productos.self, from: data)
                productos = respuesta
                isLoading = false
            }catch{
                print("Ocurrio un error")
                isLoading = false
                ocurredError = true
            }
        }
        session.resume()
    }
}


struct ListProductView_Previews: PreviewProvider {
    static var previews: some View {
        ListProductView()
    }
}
