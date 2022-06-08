//
//  ContentView.swift
//  PruebaSwiftUI
//
//  Created by Alfredo Salazar on 06/06/22.
//

import SwiftUI
class Product: ObservableObject {
    @Published var productSeleccionado = ProductoSeleccionado()
}

struct ContentView: View {
    @State var productos: Productos?
    @State var producto = Producto.shared
    @State var isLoad = false
    
    
    @EnvironmentObject var prod: Product
    //@Binding var cambio: Bool
    var body: some View {
        NavigationView{
            VStack( spacing: 20) {
                HStack{
                    Spacer()
                    Button(action: {
                        print("he pulsado el boton")
                    }, label: {
                        NavigationLink(destination: ListProductView()) {
                            Text("LISTA PRODUCTOS").padding()
                         }
                    })
                }
                VStack{
                    Card().padding()
                }
                Spacer()
            }
            .navigationBarTitle(Text("Mis productos"), displayMode: .large)
        }
    }
    
}
struct Card: View {
    @EnvironmentObject var prod: Product
    
    var body: some View {
        if prod.productSeleccionado.nombre != "" && prod.productSeleccionado.isSelected{
            VStack{
                HStack{
                    Text("CATEGORIA: \(prod.productSeleccionado.categoria )")
                    Spacer()
                }
                VStack{
                    CollectioViewImage()
                }
                
                VStack{
                    Text("\(prod.productSeleccionado.nombre)").padding().fixedSize(horizontal: false, vertical: true).multilineTextAlignment(.center)
                }
                HStack{
                    Text("Precio: \(prod.productSeleccionado.precioFinal, specifier: "%.2f")")
                    Spacer()
                }
                HStack{
                    Text("CODIGO CATEGORIA: \(prod.productSeleccionado.codigoCategoria )")
                    Spacer()
                }
                
            }.padding().frame(width: 350, height: 300, alignment: .center).border(Color.blue, width: 1)
            
        }
        
    }
    struct CollectioViewImage: View{
        @EnvironmentObject var prod: Product
        var body: some View{
            ScrollView(.horizontal){
                HStack {
                    ForEach(prod.productSeleccionado.urlImagenes ,id:\.idenfifier){
                       image in
                        let urlss = String(image.image)
                        if let url = URL(string: urlss){
                            let uima = try? UIImage(data: Data(contentsOf: url))
                            Image(uiImage: uima!).resizable().frame(width: 100, height: 100).padding()
                        }
                   }
            }.frame(height: 120)
          }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(Product())
    }
}

