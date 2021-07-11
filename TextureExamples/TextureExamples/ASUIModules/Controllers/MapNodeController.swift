//
//  MapNodeController.swift
//  TextureExamples
//
//  Created by YYKJ0048 on 2021/7/9.
//

import AsyncDisplayKit
import TextureSwiftSupport

class MapNodeController: BaseNodeController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configBackgroundNode()
        node.setNeedsLayout()
    }
}

extension MapNodeController {
    private func configBackgroundNode() {
        let contentNode = MapContentNode()
        node.addSubnode(contentNode)
        node.layoutSpecBlock = { node, constrainedSize in
            ASInsetLayoutSpec(insets: node.safeAreaInsets, child: contentNode)
        }
    }
}

// MARK: - MapContentNode
class MapContentNode: ASDisplayNode {

    let mapNode = ASMapNode()
    let updateNode = ASButtonNode()
    let toggleNode = ASButtonNode()

    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        updateRegion()
        mapNode.style.flexGrow = 1.0
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        LayoutSpec {
            mapNode
        }
    }
    
    override func didLoad() {
        super.didLoad()
        mapNode.mapDelegate = self
        mapNode.isLiveMap = true
        mapNode.imageForStaticMapAnnotationBlock = { (annotation, point) -> UIImage? in
            if let point = annotation as? CustomAnnotation {
                return point.image
            }
            return nil
        }
        
        configAnnotaions()
    }
}

// MARK: - MKAnnotation Configs
extension MapContentNode {
    private func updateRegion() {
        mapNode.region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 23.15792, longitude: 113.27324),
                                            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
    }
    
    private func configAnnotaions() {
        let point1 = MKPointAnnotation()
        point1.coordinate = CLLocationCoordinate2D(latitude: 23.15792, longitude: 113.27324)
        point1.title = "GuangZhou"
        point1.subtitle = "This is GuangZhou"
        
        let point2 = CustomAnnotation()
        point2.image = #imageLiteral(resourceName: "mapPoint")
        point2.coordinate = CLLocationCoordinate2D(latitude: 23.10647, longitude: 113.324463)
        point2.title = "Guang Zhou Town"
        point2.subtitle = "This is Guang Zhou Town"

        let point3 = CustomAnnotation()
        point3.image = #imageLiteral(resourceName: "mapPoint")
        point3.coordinate = CLLocationCoordinate2D(latitude: 23.126717, longitude: 113.285688)
        point3.title = "Lie Shi Ling Yuan"
        point3.subtitle = "This is Lie Shi Ling Yuan"
        
        mapNode.annotations = [point1, point2, point3]
    }
}

// MARK: - MKMapViewDelegate
extension MapContentNode: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let point = annotation as? CustomAnnotation else {
            return nil
        }
        
        let view = MKAnnotationView()
        view.image = point.image
        view.isOpaque = false
        return view
    }
}

// MARK: - MKAnnotation
class CustomAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var image: UIImage?
    var title: String?
    var subtitle: String?
}
