//
//  ConfidenceMapViewController.swift
//  ExampleOfiOSLiDAR
//
//  Created by TokyoYoshida on 2021/01/31.
//

import RealityKit
import ARKit

class ConfidenceMapViewController: UIViewController, ARSessionDelegate {    
    @IBOutlet var arView: ARView!
    @IBOutlet weak var imageView: UIImageView!
    
    var orientation: UIInterfaceOrientation {
        guard let orientation = UIApplication.shared.windows.first?.windowScene?.interfaceOrientation else {
            fatalError()
        }
        return orientation
    }
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    lazy var imageViewSize: CGSize = {
        CGSize(width: view.bounds.size.width, height: imageViewHeight.constant)
    }()

    override func viewDidLoad() {
        func buildConfigure() -> ARWorldTrackingConfiguration {
            let configuration = ARWorldTrackingConfiguration()

            configuration.environmentTexturing = .automatic
            if type(of: configuration).supportsFrameSemantics(.sceneDepth) {
               configuration.frameSemantics = .sceneDepth
            }

            return configuration
        }
        super.viewDidLoad()
        
        arView.session.delegate = self
        let configuration = buildConfigure()
        arView.session.run(configuration)
    }

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        imageView.image = session.currentFrame?.ConfidenceMapTransformedImage(orientation: orientation, viewPort: self.imageView.bounds)
    }
}
