//
//  ContentView.swift
//  UI-581
//
//  Created by nyannyan0328 on 2022/06/10.
//

import SwiftUI

struct ContentView: View {
    @State var tags : [Tag] = rawTags.compactMap { tag -> Tag? in
        
            .init(name: tag)
    }
    @State var alignmenValue : Int = 1
    @State var text : String = ""
    var body: some View {
        NavigationStack{
            
            
            
            VStack{

                Picker("", selection: $alignmenValue) {


                      Text("Leading")
                        .tag(0)

                    Text("Center")
                      .tag(1)

                    Text("Tragilng")
                      .tag(3)
                }
                .pickerStyle(.segmented)
                .padding(.bottom,10)
                
                
        
                TabView(alignmetn: alignmenValue == 0 ? .leading : alignmenValue == 1 ? .center : .trailing, spacing: 10){
                    
                    
                    ForEach($tags){$tag in
                        
                        Toggle(tag.name, isOn: $tag.isSelected)
                            .toggleStyle(.button)
                            .buttonStyle(.bordered)
                            .tint(tag.isSelected ? .red : .gray)
                            
                            
                        
                        
                        
                    }
                    
                }
                
                
                HStack{
                    
                    TextField("Searc", text: $text,axis:.vertical)
                        .textFieldStyle(.roundedBorder)
                        .lineLimit(1...3)
                    
                    Button("Add"){
                        
                        tags.append(Tag(name: text))
                        text = ""
                        
                    }
                    .buttonStyle(.bordered)
                    .buttonBorderShape(.roundedRectangle(radius: 10))
                    .tint(.red)
                    .disabled(text == "")
                    
                  
                }
                
            }
            .padding()
            .navigationTitle("Layout")
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct TabView : Layout{
    
    var alignmetn : Alignment = .center
    var spacing : CGFloat = 10
    
    init(alignmetn: Alignment, spacing: CGFloat) {
        self.alignmetn = alignmetn
        self.spacing = spacing
    }
    func sizeThatFits(proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) -> CGSize {
        
        return .init(width: proposal.width ?? 0, height: proposal.height ?? 0)
        
        
    }
    
    func placeSubviews(in bounds: CGRect, proposal: ProposedViewSize, subviews: Subviews, cache: inout ()) {
        
        var origin = bounds.origin
        let maxWidth = bounds.width
        
        subviews.forEach { view in
            
            
            let viewSize = view.sizeThatFits(proposal)
            
            if (origin.x + viewSize.width + spacing) > maxWidth{
                
                origin.y += (viewSize.height + spacing)
                origin.x = bounds.origin.x
                
                
              view.place(at: origin, proposal: proposal)
                
                origin.x += (viewSize.width + spacing)
                
            }
            else{
                
                
                view.place(at: origin, proposal: proposal)
                origin.x += (viewSize.width + spacing)
                
            }
        }
    
    }
    
    
    
}

var rawTags: [String] = [
    "SwiftUI","Xcode","Apple","WWDC 22","iOS 16","iPadOS 16","macOS 13","watchOS 9","Xcode 14","API's"
]

struct Tag : Identifiable{
    
    var id = UUID().uuidString
    var name : String
    var isSelected : Bool = false
}
