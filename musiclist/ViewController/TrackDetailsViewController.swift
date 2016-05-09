//
//  TrackDetailsViewController.swift
//  musiclist
//
//  Created by Artem Shuba on 09/05/16.
//  Copyright © 2016 ashuba. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import ChameleonFramework

class TrackDetailsViewController : UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var coverImageView: UIImageView!

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var artistLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var titleView: UIView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var headerView: UIView!
    
    var track: Track?
    
    override func viewDidLoad() {
        
        scrollView.delegate = self
        
        titleLabel.text = track?.title
        artistLabel.text = track?.artist
        
        if let path = NSBundle.mainBundle().pathForResource("description", ofType: "txt")
        {
            do {
                try descriptionLabel.text = String(contentsOfFile: path, encoding: NSUTF8StringEncoding)
            }
            catch {
                descriptionLabel.text = nil
                
                print(error)
            }
        }
        
        if let image = track?.getCoverImage() {
            coverImageView.image = image
            
            applyTheme(image)
        }
    }
    
    func applyTheme(image: UIImage) {
        let colors = NSArray(ofColorsFromImage: image, withFlatScheme: true)
        
        if colors.count > 0 {
            var bgColor = colors[0] as! UIColor
            var fgColor = colors[1] as! UIColor
            
            let statusBarStyle = contrastingStatusBarStyleForColor(bgColor)
            
            //color correction (depending on light or dark content)
            if statusBarStyle == .LightContent {
                bgColor = bgColor.darkenByPercentage(0.85)
                fgColor = fgColor.lightenByPercentage(0.85)
            }
            else {
                bgColor = bgColor.lightenByPercentage(0.85)
                fgColor = fgColor.darkenByPercentage(0.85)
            }
            
            
            self.view.backgroundColor = bgColor
            headerView.backgroundColor = bgColor
            descriptionLabel.textColor = fgColor
            
            titleLabel.textColor = fgColor
            artistLabel.textColor = fgColor
            
            navigationController?.navigationBar.tintColor = fgColor
            
            
            UIApplication.sharedApplication().setStatusBarStyle(statusBarStyle, animated: true)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: .Default)
        navigationController?.navigationBar.translucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        
        titleView.hidden = true
        headerView.frame = CGRect(x: 0, y: 0, width: self.navigationController!.navigationBar.frame.width, height: self.navigationController!.navigationBar.frame.origin.y + self.navigationController!.navigationBar.frame.size.height)
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: .Default)

        UIApplication.sharedApplication().setStatusBarStyle(.Default, animated: true)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        titleView.hidden = false
        titleView.alpha = 0
        
        headerView.alpha = 0
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        //change alpha of elements depending on scroll position
        
        if scrollView.contentOffset.y < coverImageView.frame.height {
            titleView.alpha = max(0, (-coverImageView.frame.height / 1.2 + scrollView.contentOffset.y) / coverImageView.frame.height * 4)
            coverImageView.alpha = 1 - max(0, (-coverImageView.frame.height / 2 + scrollView.contentOffset.y) / coverImageView.frame.height * 2)
  
        }
        else {
            titleView.alpha = 1
            coverImageView.alpha = 0
        }
        
        headerView.alpha = titleView.alpha
    }
    
    //private func taken from ChameleonFramework
    func contrastingStatusBarStyleForColor(backgroundColor: UIColor) -> UIStatusBarStyle {
    
        //Calculate Luminance
        var luminance: CGFloat
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
    
        //Check for clear or uncalculatable color and assume white
        if !backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: nil) {
            return .Default
        }
    
        //Relative luminance in colorimetric spaces - http://en.wikipedia.org/wiki/Luminance_(relative)
        red *= 0.2126
        green *= 0.7152
        blue *= 0.0722
        luminance = red + green + blue
    
        return (luminance > 0.6) ? .Default : .LightContent;
    }
}