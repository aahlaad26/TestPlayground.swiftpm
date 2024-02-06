import SwiftUI
import PhotosUI
struct ContentView: View {

    @State private var selectedItems : [PhotosPickerItem] = []
    @State var data:Data?
    
    var body: some View {
        VStack{
            if let data = data, let uiimage = UIImage(data: data){
                Image(uiImage: uiimage)
                    .resizable()
            }
            PhotosPicker(selection: $selectedItems,maxSelectionCount:1, matching: .images){
                Text("Pick the photo")
                    .frame(width: 100,height: 100)
            }
            .onChange(of: selectedItems){
                newValue in guard let item = selectedItems.first else{
                    return
                }
                item.loadTransferable(type: Data.self){
                    Result in switch Result{
                    case .success(let data):
                        if let data = data{
                            self.data = data
                        }
                        else{
                            print("Data is nil")
                        }
                    case .failure(let failure):
                        fatalError("\(failure)")
                    }
                }
            }
        }
    }
    
   
    
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

