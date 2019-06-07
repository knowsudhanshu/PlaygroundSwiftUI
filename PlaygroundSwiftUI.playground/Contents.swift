//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import PlaygroundSupport


struct ListItemModel: Identifiable {
    var id: Int
    var name: String
}

struct MyContentView: View {
    var listItems: [ListItemModel] = [
        ListItemModel(id: 0, name: "item 1"),
        ListItemModel(id: 0, name: "item 2"),
        ListItemModel(id: 0, name: "item 3"),
        ListItemModel(id: 0, name: "item 4"),
        ListItemModel(id: 0, name: "item 5"),
        ListItemModel(id: 0, name: "item 6")
    ]
    
    var body: some View {
        
        NavigationView {
            List (listItems.identified(by: \.id)) { item in
                NavigationButton(destination: DetailView(item: item)) {
                    ItemRow(item: item)
                }
            }
                .navigationBarTitle(Text("Sudhanshu"))
        }
    }
}

struct ItemRow: View {
    var item: ListItemModel
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(named: "mypic.png")!)
                .resizable()
                .aspectRatio(1/1, contentMode: .fit)
            Text(item.name)
            Spacer()
        }
    }
}

struct DetailView: View {
    var item: ListItemModel
    
    var body: some View {
        HStack {
            Image(uiImage: UIImage(named: "mypic.png")!)
                .resizable()
                .aspectRatio(1/1, contentMode: .fit)
            Text(item.name)
            Spacer()
        }
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = UIHostingController(rootView: MyContentView())
