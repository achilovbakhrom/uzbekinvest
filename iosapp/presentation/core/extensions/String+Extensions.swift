//
//  String.swift
//  iosapp
//
//  Created by Bakhrom Achilov on 2/29/20.
//  Copyright © 2020 Bakhrom Achilov. All rights reserved.
//
import Foundation
extension String {
    var digits: String {
        return components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
}


extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }

    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return String(self[fromIndex...])
    }

    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return String(self[..<toIndex])
    }

    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return String(self[startIndex..<endIndex])
    }
}


extension String {
    func localized() -> String {
        let lang = UserDefaults.standard.string(forKey: "language") ?? "ru";
        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}

extension String {
    func toLang() -> Int {
        switch self {
        case "ru":
            return 0;
        case "uz-Cyrl":
            return 1;
        case "uz-UZ":
            return 2;
        default:
            return 0;
        }
    }
}

public extension String {
    
    func byConvertingHTMLToPlainText() -> String {
        
        let stopCharacters = CharacterSet(charactersIn: "< \t\n\r\(0x0085)\(0x000C)\(0x2028)\(0x2029)")
        let newLineAndWhitespaceCharacters = CharacterSet(charactersIn: " \t\n\r\(0x0085)\(0x000C)\(0x2028)\(0x2029)")
        let tagNameCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ")
        
        let result = NSMutableString(capacity: count)
        let scanner = Scanner(string: self as String)
        scanner.charactersToBeSkipped = nil
        scanner.caseSensitive = true
        var str: NSString? = nil
        var tagName: NSString? = nil
        var dontReplaceTagWithSpace = false
        
        repeat {
            // Scan up to the start of a tag or whitespace
            if scanner.scanUpToCharacters(from: stopCharacters, into: &str), let s = str {
                result.append(s as String)
                str = nil
            }
            // Check if we've stopped at a tag/comment or whitespace
            if scanner.scanString("<", into: nil) {
                // Stopped at a comment, script tag, or other tag
                if scanner.scanString("!--", into: nil) {
                    // Comment
                    scanner.scanUpTo("-->", into: nil)
                    scanner.scanString("-->", into: nil)
                } else if scanner.scanString("script", into: nil) {
                    // Script tag where things don't need escaping!
                    scanner.scanUpTo("</script>", into: nil)
                    scanner.scanString("</script>", into: nil)
                } else {
                    // Tag - remove and replace with space unless it's
                    // a closing inline tag then dont replace with a space
                    if scanner.scanString("/", into: nil) {
                        // Closing tag - replace with space unless it's inline
                        tagName = nil
                        dontReplaceTagWithSpace = false
                        if scanner.scanCharacters(from: tagNameCharacters, into: &tagName), let t = tagName {
                            tagName = t.lowercased as NSString
                            dontReplaceTagWithSpace =
                                tagName == "a" ||
                                tagName == "b" ||
                                tagName == "i" ||
                                tagName == "q" ||
                                tagName == "span" ||
                                tagName == "em" ||
                                tagName == "strong" ||
                                tagName == "cite" ||
                                tagName == "abbr" ||
                                tagName == "acronym" ||
                                tagName == "label"
                        }
                        // Replace tag with string unless it was an inline
                        if !dontReplaceTagWithSpace && result.length > 0 && !scanner.isAtEnd {
                            result.append(" ")
                        }
                    }
                    // Scan past tag
                    scanner.scanUpTo(">", into: nil)
                    scanner.scanString(">", into: nil)
                }
            } else {
                // Stopped at whitespace - replace all whitespace and newlines with a space
                if scanner.scanCharacters(from: newLineAndWhitespaceCharacters, into: nil) {
                    if result.length > 0 && !scanner.isAtEnd {
                        result.append(" ") // Dont append space to beginning or end of result
                    }
                }
            }
        } while !scanner.isAtEnd
        
        // Cleanup
        
        // Decode HTML entities and return (this isn't included in this gist, but is often important)
        // let retString = (result as String).stringByDecodingHTMLEntities
        
        // Return
        return result as String // retString;
    }
    
}
