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
    
    
    @IBOutlet weak var navbarTitleLabel: UILabel!
    
    @IBOutlet weak var navbarArtistLabel: UILabel!
    
    @IBOutlet weak var overviewTitleLabel: UILabel!
    
    private var statusBarStyle: UIStatusBarStyle = .default {
        didSet {
            self.setNeedsStatusBarAppearanceUpdate()
        }
    }
    
    var track: Track?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return statusBarStyle
    }
    
    override func viewDidLoad() {
        
        scrollView.delegate = self
        
        navbarTitleLabel.text = track?.title
        navbarArtistLabel.text = track?.artist
        
        titleLabel.text = track?.title
        artistLabel.text = track?.artist
        
        overviewTitleLabel.setKerning(kerning: 1)
        
        if let path = Bundle.main.path(forResource: "description", ofType: "txt")
        {
            do {
                try descriptionLabel.text = String(contentsOfFile: path, encoding: String.Encoding.utf8)
            }
            catch {
                descriptionLabel.text = nil
                
                print(error)
            }
        }
        
        if let image = track?.getCoverImage() {
            coverImageView.image = image
            
            applyTheme(image: image)
        }
    }
    
    func applyTheme(image: UIImage) {
        let colors = NSArray(ofColorsFrom: image, withFlatScheme: true)
        
        if colors?.count ?? 0 > 1 {
            var bgColor = colors?[0] as! UIColor
            var fgColor = colors?[1] as! UIColor
            
            let statusBarStyle = contrastingStatusBarStyleForColor(backgroundColor: bgColor)
            
            //color correction (depending on light or dark content)
            if statusBarStyle == .lightContent {
                bgColor = bgColor.darken(byPercentage: 0.25) ?? .white
                fgColor = fgColor.lighten(byPercentage: 0.85) ?? .black
            }
            else {
                bgColor = bgColor.lighten(byPercentage: 0.25) ?? .black
                fgColor = fgColor.darken(byPercentage: 0.85) ?? .white
            }
            
            self.view.backgroundColor = bgColor
            headerView.backgroundColor = bgColor
            descriptionLabel.textColor = fgColor
            
            navbarTitleLabel.textColor = fgColor
            navbarArtistLabel.textColor = fgColor
            
            titleLabel.textColor = fgColor
            artistLabel.textColor = fgColor
            
            overviewTitleLabel.textColor = fgColor
            
            navigationController?.navigationBar.tintColor = fgColor
            
            self.statusBarStyle = statusBarStyle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.shadowImage = UIImage()
        
        titleView.isHidden = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil

        self.statusBarStyle = .default
        navigationController?.navigationBar.barStyle = .default
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        titleView.isHidden = false
        titleView.alpha = 0
        
        headerView.alpha = 0
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
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
        
        titleLabel.alpha = coverImageView.alpha
        artistLabel.alpha = coverImageView.alpha
    }
    
    //private func taken from ChameleonFramework
    func contrastingStatusBarStyleForColor(backgroundColor: UIColor) -> UIStatusBarStyle {
    
        //Calculate Luminance
        var luminance: CGFloat
        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0
    
        //Check for clear or uncalculatable color and assume white
        if !backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: nil) {
            return .default
        }
    
        //Relative luminance in colorimetric spaces - http://en.wikipedia.org/wiki/Luminance_(relative)
        red *= 0.2126
        green *= 0.7152
        blue *= 0.0722
        luminance = red + green + blue
    
        return (luminance > 0.6) ? .default : .lightContent;
    }
}
