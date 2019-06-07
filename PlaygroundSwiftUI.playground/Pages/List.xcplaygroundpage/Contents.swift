//: A UIKit based Playground for presenting user interface
  
import SwiftUI
import PlaygroundSupport


struct ListItemModel: Identifiable {
    var id: Int
    var name: String
    var imageName: String
}

struct MyContentView: View {
    @State var listItems: [ListItemModel] = [
        ListItemModel(id: 0, name: "Sudhanshu 1", imageName: "mypic.png")
    ]
    
    var body: some View {
        
        NavigationView {
            List (listItems.identified(by: \.id)) { item in
                NavigationButton(destination: DetailView(item: item)) {
                    ItemRow(item: item)
                }
            }
                .navigationBarTitle(Text("Sudhanshu"))
                .navigationBarItems(trailing: Button(action: {
                    let count = self.listItems.count + 1
                    let item = ListItemModel(id: count, name: "Sudhanshu \(count)", imageName: "mypic.png")
                    self.listItems.append(item)
                }, label: {
                    Text("Add")
                }))
        }
    }
}

// Mark: - ItemRow
struct ItemRow: View {
    var item: ListItemModel
    
    var body: some View {
        HStack {
            CircularImage(name: item.imageName).frame(width: 50, height: 50, alignment: .init(horizontal: .leading, vertical: .top))
            Text(item.name)
            Spacer()
            }
            .padding(10)
    }
}

// Mark: - DetailView
struct DetailView: View {
    var item: ListItemModel
    let imageHeight: CGFloat = 100
    
    var body: some View {
        VStack {
            MapView()
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)
            CircularImage(name: item.imageName).frame(width: imageHeight, height: imageHeight, alignment: .init(horizontal: .leading, vertical: .top))
                .offset(y: -(imageHeight/2))
                .padding(.bottom, -(imageHeight/2))
            Text(item.name)
            Spacer()
        }
    }
}

import MapKit
// Mark: - MapView
struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        let coordinate = CLLocationCoordinate2D(
            latitude: 34.011286, longitude: -116.166868)
        let span = MKCoordinateSpan(latitudeDelta: 2.0, longitudeDelta: 2.0)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        view.setRegion(region, animated: true)
    }
}

// Mark: - CircularImage
struct CircularImage: View {
    var name: String
    
    var body: some View {
        Image(uiImage: UIImage(named: name)!)
            .resizable()
            .aspectRatio(1/1, contentMode: .fit)
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.white, lineWidth: 2))
            .shadow(radius: 5)
        
    }
}

// Present the view controller in the Live View window
PlaygroundPage.current.liveView = UIHostingController(rootView: MyContentView())
