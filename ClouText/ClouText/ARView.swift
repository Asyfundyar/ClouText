import SwiftUI
import RealityKit
import CoreLocation

struct ARViewContainer : UIViewRepresentable {
    
    @State var coor : CLLocationCoordinate2D
    @ObservedObject var model : ViewModel

    func makeUIView(context: Context) -> ARView {

        //the main RealityKit view

        let arView = ARView(frame: .zero)

        //debugging settings

        //add an anchor to the scene

        let anchor = AnchorEntity(plane: .horizontal, minimumBounds: [0.15, 0.15])

        arView.scene.anchors.append(anchor)

        //Create a text

        let textMesh = MeshResource.generateText(

            "\(model.list[model.msgLocations.firstIndex(of: coor) ?? 0].msg)",

            extrusionDepth: 0.1,

            font: .systemFont(ofSize: 1.0),

            containerFrame: CGRect.zero,

            alignment: .left,

            lineBreakMode: .byTruncatingTail)

        //set the environment mapping material

        let textMaterial = SimpleMaterial(color: UIColor.purple, roughness: 0.0, isMetallic: false)

        let textModel = ModelEntity(mesh: textMesh, materials: [textMaterial])

        textModel.scale = SIMD3<Float>(0.1, 0.1, 0.1) //10 minutes reduced to 1

        textModel.position = SIMD3<Float>(0.0, 0.0, -0.2) //back 0.2 m

        anchor.addChild(textModel)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
    
    }
 }
