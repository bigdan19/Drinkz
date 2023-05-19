//
//  TabBarViewController.swift
//  Drinkz
//
//  Created by Daniel on 19/05/2023.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var upperLineView: UIView!

    let spacing: CGFloat = 22

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2){
                self.addTabbarIndicatorView(index: 0, isFirstTime: true)
            }
    }
    
    func addTabbarIndicatorView(index: Int, isFirstTime: Bool = false){
          guard let tabView = tabBar.items?[index].value(forKey: "view") as? UIView else {
              return
          }
          if !isFirstTime{
              upperLineView.removeFromSuperview()
          }
          upperLineView = UIView(frame: CGRect(x: tabView.frame.minX + spacing, y: tabView.frame.minY + 0.1, width: tabView.frame.size.width - spacing * 2, height: 2))
          upperLineView.backgroundColor = UIColor.orange
          tabBar.addSubview(upperLineView)
      }
}

extension TabBarViewController : UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        addTabbarIndicatorView(index: self.selectedIndex)
    }
}


@IBDesignable class TabBarWithCorners: UITabBar {
    @IBInspectable var color: UIColor?
    @IBInspectable var radii: CGFloat = 18
    
    private var shapeLayer: CALayer?
    
    override func draw(_ rect: CGRect) {
        addShape()
    }
    
    private func addShape() {
        let shapeLayer = CAShapeLayer()
        
        shapeLayer.path = createPath()
        shapeLayer.strokeColor = UIColor.darkGray.cgColor
        shapeLayer.fillColor = color?.cgColor ?? UIColor.white.cgColor
        shapeLayer.lineWidth = 0.2
        shapeLayer.shadowColor = UIColor.darkGray.cgColor
        shapeLayer.shadowOffset = CGSize(width: 0, height: -2);
        shapeLayer.shadowOpacity = 0.21
        shapeLayer.shadowRadius = 8
        shapeLayer.shadowPath =  UIBezierPath(roundedRect: bounds, cornerRadius: radii).cgPath
        
        if let oldShapeLayer = self.shapeLayer {
            layer.replaceSublayer(oldShapeLayer, with: shapeLayer)
        } else {
            layer.insertSublayer(shapeLayer, at: 0)
        }
        
        self.shapeLayer = shapeLayer
    }
    
    private func createPath() -> CGPath {
        let path = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radii, height: 0.0))
        
        return path.cgPath
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.isTranslucent = true
        var tabFrame = self.frame
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let bottomSafeArea = window.safeAreaInsets.bottom
            tabFrame.size.height = 55 + bottomSafeArea
            tabFrame.origin.y = self.frame.origin.y + self.frame.height - 55 - bottomSafeArea
        }
        self.layer.cornerRadius = 18
        self.frame = tabFrame
        self.items?.forEach({ $0.titlePositionAdjustment = UIOffset(horizontal: 0.0, vertical: -5.0) })
    }
    
}



