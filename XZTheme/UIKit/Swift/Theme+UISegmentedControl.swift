//
//  Theme+UISegmentedControl.swift
//  XZTheme
//
//  Created by mlibai on 2018/5/28.
//

import Foundation


//extension Theme.Attribute {
//    
//    public static let <#Attribute Name#> = Theme.Attribute.init("<#T##rawValue: String##String#>")
//    
//}
//
//extension Theme.Style {
//    
//    public var <#string#>: String? {
//        get { return stringValue(forThemeAttribute: .<#T##Theme.Attribute#>) }
//        set { setValue(newValue, forThemeAttribute: .<#T##Theme.Attribute#>) }
//    }
//    
//    public var <#color#>: UIColor? {
//        get { return color(forThemeAttribute: .<#T##Theme.Attribute#>) }
//        set { setValue(newValue, forThemeAttribute: .<#T##Theme.Attribute#>) }
//    }
//    
//    public var <#image#>: UIImage? {
//        get { return image(forThemeAttribute: .<#T##Theme.Attribute#>) }
//        set { setValue(newValue, forThemeAttribute: .<#T##Theme.Attribute#>)}
//    }
//    
//    public var <#bool#>: Bool {
//        get { return boolValue(forThemeAttribute: .<#T##Theme.Attribute#>)  }
//        set { setValue(newValue, forThemeAttribute: .<#T##Theme.Attribute#>) }
//    }
//    
//}
//
extension UISegmentedControl {
    
    open override func updateAppearance(with themeStyles: Theme.Style.Collection) {
        super.updateAppearance(with: themeStyles)
        
//        open var isMomentary: Bool // if set, then we don't keep showing selected state after tracking ends. default is NO
//        
//        open var numberOfSegments: Int { get }
//        
//        
//        // For segments whose width value is 0, setting this property to YES attempts to adjust segment widths based on their content widths. Default is NO.
//        @available(iOS 5.0, *)
//        open var apportionsSegmentWidthsByContent: Bool
//        
//        
//        open func insertSegment(withTitle title: String?, at segment: Int, animated: Bool) // insert before segment number. 0..#segments. value pinned
//        
//        open func insertSegment(with image: UIImage?, at segment: Int, animated: Bool)
//        
//        open func removeSegment(at segment: Int, animated: Bool)
//        
//        open func removeAllSegments()
//        
//        
//        open func setTitle(_ title: String?, forSegmentAt segment: Int) // can only have image or title, not both. must be 0..#segments - 1 (or ignored). default is nil
//        
//        open func titleForSegment(at segment: Int) -> String?
//        
//        
//        open func setImage(_ image: UIImage?, forSegmentAt segment: Int) // can only have image or title, not both. must be 0..#segments - 1 (or ignored). default is nil
//        
//        open func imageForSegment(at segment: Int) -> UIImage?
//        
//        
//        open func setWidth(_ width: CGFloat, forSegmentAt segment: Int) // set to 0.0 width to autosize. default is 0.0
//        
//        open func widthForSegment(at segment: Int) -> CGFloat
//        
//        
//        open func setContentOffset(_ offset: CGSize, forSegmentAt segment: Int) // adjust offset of image or text inside the segment. default is (0,0)
//        
//        open func contentOffsetForSegment(at segment: Int) -> CGSize
//        
//        
//        open func setEnabled(_ enabled: Bool, forSegmentAt segment: Int) // default is YES
//        
//        open func isEnabledForSegment(at segment: Int) -> Bool
//        
//        
//        // ignored in momentary mode. returns last segment pressed. default is UISegmentedControlNoSegment until a segment is pressed
//        // the UIControlEventValueChanged action is invoked when the segment changes via a user event. set to UISegmentedControlNoSegment to turn off selection
//        open var selectedSegmentIndex: Int
//        
//        
//        // The tintColor is inherited through the superview hierarchy. See UIView for more information.
//        open var tintColor: UIColor!
//        
//        
//        /* If backgroundImage is an image returned from -[UIImage resizableImageWithCapInsets:] the cap widths will be calculated from that information, otherwise, the cap width will be calculated by subtracting one from the image's width then dividing by 2. The cap widths will also be used as the margins for text placement. To adjust the margin use the margin adjustment methods.
//         
//         In general, you should specify a value for the normal state to be used by other states which don't have a custom value set.
//         
//         Similarly, when a property is dependent on the bar metrics, be sure to specify a value for UIBarMetricsDefault.
//         In the case of the segmented control, appearance properties for UIBarMetricsCompact are only respected for segmented controls in the smaller navigation and toolbars.
//         */
//        @available(iOS 5.0, *)
//        open func setBackgroundImage(_ backgroundImage: UIImage?, for state: UIControlState, barMetrics: UIBarMetrics)
//        
//        @available(iOS 5.0, *)
//        open func backgroundImage(for state: UIControlState, barMetrics: UIBarMetrics) -> UIImage?
//        
//        
//        /* To customize the segmented control appearance you will need to provide divider images to go between two unselected segments (leftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal), selected on the left and unselected on the right (leftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal), and unselected on the left and selected on the right (leftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected).
//         */
//        @available(iOS 5.0, *)
//        open func setDividerImage(_ dividerImage: UIImage?, forLeftSegmentState leftState: UIControlState, rightSegmentState rightState: UIControlState, barMetrics: UIBarMetrics)
//        
//        @available(iOS 5.0, *)
//        open func dividerImage(forLeftSegmentState leftState: UIControlState, rightSegmentState rightState: UIControlState, barMetrics: UIBarMetrics) -> UIImage?
//        
//        
//        /* You may specify the font, text color, and shadow properties for the title in the text attributes dictionary, using the keys found in NSAttributedString.h.
//         */
//        @available(iOS 5.0, *)
//        open func setTitleTextAttributes(_ attributes: [AnyHashable : Any]?, for state: UIControlState)
//        
//        @available(iOS 5.0, *)
//        open func titleTextAttributes(for state: UIControlState) -> [AnyHashable : Any]?
//        
//        
//        /* For adjusting the position of a title or image within the given segment of a segmented control.
//         */
//        @available(iOS 5.0, *)
//        open func setContentPositionAdjustment(_ adjustment: UIOffset, forSegmentType leftCenterRightOrAlone: UISegmentedControlSegment, barMetrics: UIBarMetrics)
//        
//        @available(iOS 5.0, *)
//        open func contentPositionAdjustment(forSegmentType leftCenterRightOrAlone: UISegmentedControlSegment, barMetrics: UIBarMetrics) -> UIOffset
    }
    
}
