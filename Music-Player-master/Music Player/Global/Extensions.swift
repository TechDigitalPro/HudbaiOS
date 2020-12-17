//
//  Extensions.swift
//  equalnote
//
//  Created by Chun Tianhong on 07/25/19.
//  Copyright © 2019 Chun Tianhong. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

extension UIColor{
    
    enum EqualNoteColor{
        
        //        case: appDefaultColor
        case appDefaultColor
        //case gray
        
        func color(with alpha: CGFloat) -> UIColor {
            
            var colorToReturn:UIColor?
            
            switch self {
            case .appDefaultColor:
                
                colorToReturn = UIColor(red: 255/255, green: 22/255, blue: 84/255, alpha: alpha)
                
                
                return colorToReturn!
            }
            
        }
    }
}


extension UIView {
    
    enum ViewSide {
        case Left, Right, Top, Bottom
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.backgroundColor = color

        switch side {
        case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
        case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
        case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
        case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }

        layer.addSublayer(border)
    }
    
    func setCornerRadius(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    
    func setLeftCornerRadius(radius: CGFloat) {
        if #available(iOS 11.0, *){
          self.clipsToBounds = true
          self.layer.cornerRadius = radius
          self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMinXMaxYCorner]
        }else{
          let path = UIBezierPath(roundedRect: self.bounds,byRoundingCorners:[.topLeft, .bottomLeft],cornerRadii: CGSize(width: radius, height:  radius))
          let maskLayer = CAShapeLayer()
          maskLayer.path = path.cgPath
          self.layer.mask = maskLayer
        }
    }
    
    func setTopCornerRadius(radius: CGFloat) {
        if #available(iOS 11.0, *){
          self.clipsToBounds = true
          self.layer.cornerRadius = radius
          self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }else{
          let path = UIBezierPath(roundedRect: self.bounds,byRoundingCorners:[.topLeft, .bottomLeft],cornerRadii: CGSize(width: radius, height:  radius))
          let maskLayer = CAShapeLayer()
          maskLayer.path = path.cgPath
          self.layer.mask = maskLayer
        }
    }
    
    func setBottomCornerRadius(radius: CGFloat) {
        if #available(iOS 11.0, *){
          self.clipsToBounds = true
          self.layer.cornerRadius = radius
          self.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }else{
          let path = UIBezierPath(roundedRect: self.bounds,byRoundingCorners:[.topLeft, .bottomLeft],cornerRadii: CGSize(width: radius, height:  radius))
          let maskLayer = CAShapeLayer()
          maskLayer.path = path.cgPath
          self.layer.mask = maskLayer
        }
    }
    
    func setRightCornerRadius(radius: CGFloat) {
        if #available(iOS 11.0, *){
          self.clipsToBounds = true
          self.layer.cornerRadius = radius
          self.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        }else{
          let path = UIBezierPath(roundedRect: self.bounds,byRoundingCorners:[.topRight, .bottomRight],cornerRadii: CGSize(width: radius, height:  radius))
          let maskLayer = CAShapeLayer()
          maskLayer.path = path.cgPath
          self.layer.mask = maskLayer
        }
    }
    
    func showView() {
        self.isHidden = false
    }
    
    func hideView() {
        self.isHidden = true
    }
    
    func setBorderShadow(){
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1).cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.8
        layer.cornerRadius = 6
    }
    
    func setBorder1(){
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.8
        layer.shadowRadius = 2
        layer.cornerRadius = 20
    }
    
    func setBorder2(){
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.04860587628, green: 0.602712866, blue: 0.3499623093, alpha: 1)
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5
        layer.cornerRadius = 12
    }
    
    func setBorder3(){
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
        layer.shadowColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1).cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.7
        layer.shadowRadius = 5
        layer.cornerRadius = 12
    }
    
    func setBorder4(){
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowColor = #colorLiteral(red: 0.5, green: 0.5, blue: 0.5, alpha: 1).cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 1
        layer.cornerRadius = 8
    }
    
    func setBorder5(){
        layer.borderWidth = 1
        layer.borderColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        layer.shadowColor = #colorLiteral(red: 0.6999999881, green: 0.6999999881, blue: 0.6999999881, alpha: 1).cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 2
        layer.cornerRadius = 12
    }
    
    
    func setShadow(radius: CGFloat, opacity: Float) {
        let shadow = UIView(frame: self.frame)
        shadow.backgroundColor = .white
        shadow.isUserInteractionEnabled = false
        shadow.layer.shadowColor = UIColor.black.cgColor
        shadow.layer.shadowOffset = .zero
        shadow.layer.shadowRadius = radius
        shadow.layer.masksToBounds = false
        shadow.layer.cornerRadius = self.layer.cornerRadius
        shadow.layer.shadowOpacity = opacity
        self.superview?.addSubview(shadow)
        self.superview?.sendSubviewToBack(shadow)
    }
    
    func setBorder(color: UIColor, width: CGFloat) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
    
    func generateShadowUsingBezierPath(radius: CGFloat, opacity: Float)  {
        self.layer.cornerRadius = 4.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
        
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
        self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.layer.cornerRadius).cgPath
    }
    
    func fadeIn(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 1.0
        })
    }
    
    func fadeOut(duration: TimeInterval = 1.0) {
        UIView.animate(withDuration: duration, animations: {
            self.alpha = 0.0
        })
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.3), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    var heightConstaint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .height && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
    
    var widthConstaint: NSLayoutConstraint? {
        get {
            return constraints.first(where: {
                $0.firstAttribute == .width && $0.relation == .equal
            })
        }
        set { setNeedsLayout() }
    }
}

// MARK: Textfield
extension UITextField {
    
    var isEmpty: Bool {
        if self.text == nil || self.text == "" || self.text!.trimmingCharacters(in: .whitespaces) == "" {
            return true
        }
        return false
    }
    
    var isValidEmail: Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.text!)
    }
    
    var isValidPassword: Bool{
        if self.text!.count >= 8 {
            return true
        }
        return false
    }
    
    var isValidPhoneNo: Bool{
        if self.text!.count >= 6 && self.text!.count <= 14 {
            return true
        }
        return false
    }
    
    var isValidName: Bool{
        if self.text!.count >= 3 && self.text!.count <= 120 {
            return true
        }
        return false
    }
    
    var isValidText: Bool{
        if self.text!.count >= 2 && self.text!.count <= 200 {
            return true
        }
        return false
    }
    
    func whitePlaceholder(placeholder: String){
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                             attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
    }
    
}

extension UIFont {
    
    enum RqualNoteFont: String {
        case black = "Raleway-Black"
        case bold = "Raleway-Bold"
        case medium = "Raleway-Medium"
        case regular = "Raleway-Regular"
        
        func fontWithSize(size: CGFloat) -> UIFont {
            return UIFont(name: rawValue, size: size)!
        }
    }
}

extension  UITextView{
    
    var isEmpty: Bool {
        if self.text == nil || self.text == "" || self.text!.trimmingCharacters(in: .whitespaces) == "" {
            return true
        }
        return false
    }
}

enum DateFormat: String {
    case dateAndTime = "yyyy-MM-dd hh:mm:ss"
    case dateAndTimea = "MM-dd-yyyy hh:mm a"
    case dateAndTimeAndSecs = "yyyy-MM-dd hh:mm:ss a"
    case dateTimeee = "yyyy-MM-dd HH:mm:ss"
    case dateSlash = "yyyy-MM-dd"
    case dateTime = "yyyy/MM/dd hh:mm a"
    case date = "MM/yyyy"
    case dateFormatToWebEnd = "MM-YYYY"
    case dateTimeUTC = "yyyy-MM-dd'T'HH:mm:ss"
    case dateTimeUTC1 = "yyyy-MM-ddTHH:mm:ss"
    case dateNow = "yyyy/MM/dd"
    case time = "hh:mm a"
    case times = "hh:mm:ss a"
    case dateWeek = "E HH:mm"
    case weekMonthDay = "EEEE, MMM d"
    case weekDayMonthYear = "E dd MMM yyyy"
    case weekMonthDayTime = "EEEE MM-dd h:mm a"
    case hhmm = "HH:mm"
    case MMMdd = "MMM dd"
    case MMddHHmm = "MMM dd HH:mm"
    case MMddyyyy = "MM/dd/yyyy"
    case ddMMMyyyyhhmma = "dd MMM, yyyy | hh:mm a"
}

extension String {
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
    
    func dateFromString(format: DateFormat) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format.rawValue
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.locale =  NSLocale(localeIdentifier: "en_US_POSIX") as Locale?
        return dateFormatter.date(from: self)
    }
    
    func toDateFormattedWith(format:String)-> NSDate? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self) as NSDate?
    }
    
    func getDate()-> NSDate?{
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: "UTC") as TimeZone?
        let dataDate = dateFormatter.date(from: self) as NSDate?
        return dataDate
    }
    
    // Check Email Validation
    func isValidEmail() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self)
    }
    
    // Check Password complexity
    func isValidPassword()->Bool{
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        let capitalresult = texttest.evaluate(with: self)
        
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        let numberresult = texttest1.evaluate(with: self)
        
//        let specialCharacterRegEx  = ".*[!&^%$#@()/]+.*"
//        let texttest2 = NSPredicate(format:"SELF MATCHES %@", specialCharacterRegEx)
//        let specialresult = texttest2.evaluate(with: self)

        return capitalresult && numberresult// && specialresult
    }
    
    func isPass8Length()->Bool{
        if self.count < 8{
            return false
        }else{
            return true
        }
    }
    
    func isPassUpper()->Bool{
        let capitalLetterRegEx  = ".*[A-Z]+.*"
        let texttest = NSPredicate(format:"SELF MATCHES %@", capitalLetterRegEx)
        return texttest.evaluate(with: self)
    }
    
    func isPassNum()->Bool{
        let numberRegEx  = ".*[0-9]+.*"
        let texttest1 = NSPredicate(format:"SELF MATCHES %@", numberRegEx)
        return texttest1.evaluate(with: self)
    }
    
    var isNumber: Bool {
        return !isEmpty && rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
    
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    
    var intValue: Int{
        return (self as NSString).integerValue
    }
    
    var doubleValue: Double{
        return (self as NSString).doubleValue
    }
    
    func withCommas() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value:self.floatValue))!
        
//        let lVal = self.floatValue - Float(self.intValue)
//        if lVal == 0.0{
//           return formatter.string(from: NSNumber(value:self.intValue))!
//        }else{
//            return "\(formatter.string(from: NSNumber(value:self.intValue))!).\(String(format: "%.2f", lVal))"
//        }
    }
    
    func fromJson(json: AnyObject) -> String {
        do {
            let data =  try JSONSerialization.data(withJSONObject: json)
            return String(data: data, encoding: .utf8)!
        } catch {
            return ""
        }
    }
    
    func toJson(string: String) -> Any {
        do {
            let jsonData = string.data(using: .utf8)
            let jsonObject = try JSONSerialization.jsonObject(with: jsonData!, options: .mutableContainers)
            return jsonObject
        } catch {}
        return []
    }
    
    func toDictionary()->NSDictionary{
        let data = Data(self.utf8)
        do {
            // make sure this JSON is in the format we expect
            if let dic = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                return dic
            }
        } catch {}
        return NSDictionary()
    }
    
    func toEncoding() -> String? {
        let unreserved = "-._~/?"
        let allowed = NSMutableCharacterSet.alphanumeric()
        allowed.addCharacters(in: unreserved)
        return addingPercentEncoding(withAllowedCharacters: allowed as CharacterSet)
    }
}

extension Date
{
    func stringFromDate(format: DateFormat) -> String {
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format.rawValue
           
           //check for local time zome
           if format == .dateTime {
               //debugPrint("End date in fomatter method \(stringFormDateInLocalTimeZone(format: format))")
               return localTimeString(format: format)
           }
           dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
           //debugPrint(dateFormatter.string(from: self))
           return dateFormatter.string(from: self)
       }
       
       func isToday() -> Bool {
           return Calendar.current.isDateInToday(self)
       }
       
       var hour: Int{
           let calendar = Calendar.current
           return calendar.component(.hour, from: self)
       }
       var minute: Int{
           let calendar = Calendar.current
           return calendar.component(.minute, from: self)
       }
       
       var second: Int{
           let calendar = Calendar.current
           return calendar.component(.second, from: self)
       }
       
       var year: Int{
           let calendar = Calendar.current
           return calendar.component(.year, from: self)
       }
       
       var month: Int{
           let calendar = Calendar.current
           return calendar.component(.month, from: self)
       }
       
       var day: Int{
           let calendar = Calendar.current
           return calendar.component(.day, from: self)
       }
       
       var weekday: Int{
           let calendar = Calendar.current
           return calendar.component(.weekday, from: self)
       }
       
       func timeAgoSinceDate(_ date:Date, numericDates:Bool = false) -> String {
           let calendar = NSCalendar.current
           let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
           let now = Date()
           let earliest = now < date ? now : date
           let latest = (earliest == now) ? date : now
           let components = calendar.dateComponents(unitFlags, from: earliest,  to: latest)
           
           if (components.year! >= 2) {
               return "\(components.year!) years ago"
           } else if (components.year! >= 1){
               if (numericDates){
                   return "1 year ago"
               } else {
                   return "Last year"
               }
           } else if (components.month! >= 2) {
               return "\(components.month!) months ago"
           } else if (components.month! >= 1){
               if (numericDates){
                   return "1 month ago"
               } else {
                   return "Last month"
               }
           } else if (components.weekOfYear! >= 2) {
               return "\(components.weekOfYear!) weeks ago"
           } else if (components.weekOfYear! >= 1){
               if (numericDates){
                   return "1 week ago"
               } else {
                   return "Last week"
               }
           } else if (components.day! >= 2) {
               return "\(components.day!) days ago"
           } else if (components.day! >= 1){
               if (numericDates){
                   return "1 day ago"
               } else {
                   return "Yesterday"
               }
           } else if (components.hour! >= 2) {
               return "\(components.hour!) hours ago"
           } else if (components.hour! >= 1){
               if (numericDates){
                   return "1 hour ago"
               } else {
                   return "An hour ago"
               }
           } else if (components.minute! >= 2) {
               return "\(components.minute!) minutes ago"
           } else if (components.minute! >= 1){
               if (numericDates){
                   return "1 minute ago"
               } else {
                   return "A minute ago"
               }
           } else if (components.second! >= 3) {
               return "\(components.second!) seconds ago"
           } else {
               return "Just now"
           }
       }
       
       func timeRemaining(numericDates:Bool = false) -> String {
           let calendar = NSCalendar.current
           let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
           let now = Date()
           
           if now >= self {
               return "Expired"
           }
           
           let components = calendar.dateComponents(unitFlags, from: now,  to: self)
           
           if (components.year! >= 2) {
               return "\(components.year!) years remaining"
           } else if (components.year! >= 1){
               return "1 year remaining"
           } else if (components.month! >= 2) {
               return "\(components.month!) months remaining"
           } else if (components.month! >= 1){
               return "1 month"
           } else if (components.weekOfYear! >= 2) {
               return "\(components.weekOfYear!) weeks remaining"
           } else if (components.weekOfYear! >= 1){
               return "1 week remaining"
           } else if (components.day! >= 2) {
               return "\(components.day!) days remaining"
           } else if (components.day! >= 1){
               return "1 day remaining"
           } else if (components.hour! >= 2) {
               return "\(components.hour!) hours remaining"
           } else if (components.hour! >= 1){
               if (numericDates) {
                   return "1 hour remaining"
               } else {
                   return "An hour remaining"
               }
           } else if (components.minute! >= 2) {
               return "\(components.minute!) minutes remaining"
           } else if (components.minute! >= 1){
               if (numericDates){
                   return "1 minute remaining"
               } else {
                   return "A minute remaining"
               }
           } else if (components.second! >= 3) {
               return "\(components.second!) seconds remaining"
           } else {
               return "Just now"
           }
       }
    
       
       func localTimeString(format: DateFormat)->String{
           let dateFormatter = DateFormatter()
           dateFormatter.dateFormat = format.rawValue
           dateFormatter.timeZone = .current
           let localDate = dateFormatter.string(from: self)
           return localDate
       }
       
       var startOfWeek: Date? {
           let gregorian = Calendar(identifier: .gregorian)
           guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
           return gregorian.date(byAdding: .day, value: 1, to: sunday)
       }

       var endOfWeek: Date? {
           let gregorian = Calendar(identifier: .gregorian)
           guard let sunday = gregorian.date(from: gregorian.dateComponents([.yearForWeekOfYear, .weekOfYear], from: self)) else { return nil }
           return gregorian.date(byAdding: .day, value: 7, to: sunday)
       }
    
    var timestamp:Int64 {
        return Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }

    init(timestamp:Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(timestamp) / 1000)
    }
}


extension UIImageView{
    
    func setRounded() {
        let radius = 12//self.frame.width / 2
        self.layer.cornerRadius = CGFloat(radius)
        self.layer.masksToBounds = true
    }
    
    func makeCircular(){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
    }
    
    func makeCircular(borderColor: UIColor){
        self.clipsToBounds = true
        self.layer.cornerRadius = self.frame.size.width / 2
        self.layer.borderColor = borderColor.cgColor
        self.layer.borderWidth = 2
    }
}

extension NSDictionary{
    func parseInt(param: String)->Int{
        let str: String? = "\(self[param] ?? 0)"
        if let val = str{
            return val.intValue
        }else{
            return 0
        }
    }
    
    func parseString(param: String)->String{
        var str: String? = "\(self[param] ?? "")"
        if str!.containsIgnoringCase(find: "null"){
            str = ""
        }
        return str!
    }
    
    func parseDouble(param: String)->Double{
        let str: String? = "\(self[param] ?? 0)"
        if let val = str{
            return val.doubleValue
        }else{
            return 0.0
        }
    }
    
    func parseFloat(param: String)->Float{
        let str: String? = "\(self[param] ?? 0)"
        if let val = str{
            return val.floatValue
        }else{
            return 0.0
        }
    }
    
    func parseBool(param: String)->Bool{
        if let val = self[param] as? Bool{
            return val
        }else{
            return false
        }
    }
}

extension Encodable {
  func asDictionary() throws -> [String: Any] {
    let data = try JSONEncoder().encode(self)
    guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
      throw NSError()
    }
    return dictionary
  }
}

extension String: ParameterEncoding {
    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try urlRequest.asURLRequest()
        request.httpBody = data(using: .utf8, allowLossyConversion: false)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        return request
    }
}

extension UITapGestureRecognizer {

    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        //let textContainerOffset = CGPointMake((labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x,
                                              //(labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y);
        let textContainerOffset = CGPoint(x: (labelSize.width - textBoundingBox.size.width) * 0.5 - textBoundingBox.origin.x, y: (labelSize.height - textBoundingBox.size.height) * 0.5 - textBoundingBox.origin.y)

        //let locationOfTouchInTextContainer = CGPointMake(locationOfTouchInLabel.x - textContainerOffset.x,
                                                        // locationOfTouchInLabel.y - textContainerOffset.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x, y: locationOfTouchInLabel.y - textContainerOffset.y)
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        return NSLocationInRange(indexOfCharacter, targetRange)
    }

}

extension UIImage {
    func tinted(color: UIColor) -> UIImage? {
        let image = withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image)
        imageView.tintColor = color

        UIGraphicsBeginImageContextWithOptions(image.size, false, 0.0)
        if let context = UIGraphicsGetCurrentContext() {
            imageView.layer.render(in: context)
            let tintedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            return tintedImage
        } else {
            return self
        }
    }
    
    func resized(toWidth width: CGFloat) -> UIImage? {
        let canvasSize = CGSize(width: width, height: CGFloat(ceil(width/size.width * size.height)))
        UIGraphicsBeginImageContextWithOptions(canvasSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        draw(in: CGRect(origin: .zero, size: canvasSize))
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
