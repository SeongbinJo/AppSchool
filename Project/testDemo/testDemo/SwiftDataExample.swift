//
//  SwiftDataExampleView.swift
//  SwiftUIPlaygroundApp
//
//  Created by Minyoung Yoo on 10/5/23.
//

import SwiftUI
import SwiftData

//Model
@Model
final class ProductDataModel {
    @Attribute(.unique) var id: String = UUID().uuidString
    var productName: String
    var productPrice: Double
    var productReleaseDate: Date
    
    init(productName: String, productPrice: Double, productReleaseDate: Date) {
        self.productName = productName
        self.productPrice = productPrice
        self.productReleaseDate = productReleaseDate
    }
}

struct SwiftDataExampleView: View {
    //Env Properties
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    //Swift Data Query
    @Query var productData: [ProductDataModel]
    
    //Binding properties
    @State private var isCreateSheetIsOn: Bool = false
    @State private var selectedItem: ProductDataModel?
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(productData){ product in
                    HStack {
                        Text("\(product.productName)")
                        Spacer()
                        Text("\(product.productPrice.formatted(.currency(code: "USD")))")
                    }
                    .onTapGesture {
                        selectedItem = product
                    }
                }
                .onDelete(perform: { indexSet in
                    for index in indexSet {
                        let product = productData[index]
                        modelContext.delete(product)
                    }
                })
            }
            .toolbar{
                ToolbarItem {
                    Button(action: {
                        isCreateSheetIsOn = true
                    }, label: {
                        Text("Add")
                    })
                }
            }
            .sheet(item: $selectedItem){ item in
                EditProductView(productData: item)
            }
            .sheet(isPresented: $isCreateSheetIsOn){
                CreateItemView()
            }
        }
        
    }
}

//Create Data View
struct CreateItemView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var productName: String = ""
    @State private var productPrice: Double = 0.0
    @State private var productReleaseDate: Date = .now
    
    var body: some View {
        NavigationStack {
            Form{
                TextField("Product Name", text: $productName)
                TextField("Product Price", value: $productPrice, format: .currency(code: "USD"))
                DatePicker("Released in", selection: $productReleaseDate, displayedComponents: .date)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Close")
                    })
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: {
                        let modelValue: ProductDataModel = ProductDataModel(productName: productName, productPrice: productPrice, productReleaseDate: productReleaseDate)
                        modelContext.insert(modelValue)
                        dismiss()
                    }, label: {
                        Text("Save Product")
                    })
                }
            }
        }
    }
}

//Update Data View
struct EditProductView: View {
    @Environment(\.dismiss) var dismiss
    @Bindable var productData: ProductDataModel
    
    var body: some View {
        NavigationStack {
            Form{
                TextField("Product Name", text: $productData.productName)
                TextField("Product Price", value: $productData.productPrice, format: .currency(code: "USD"))
                DatePicker("Released in", selection: $productData.productReleaseDate, displayedComponents: .date)
            }
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    Button(action: {
                        dismiss()
                    }, label: {
                        Text("Close")
                    })
                }
            }
        }
    }
}

#Preview {
    SwiftDataExampleView()
}
