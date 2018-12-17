//
//  Story.swift
//  Madlibs
//
//  Created by Julian Jansen on 13-04-16 for Swift 2.
//  Updated by Julian Jansen on 06-11-16 for Swift 3.
//  Updated by Marijn Jansen on 23-10-18 for Swift 4.
//
//  Based on: CS 193A, Marty Stepp
//

import Foundation


struct Story {
    static private let startString = """
<div style='font-family: "Helvetica Neue"; font-size: 12pt'>
"""
    static private let endString = "</div>"
    private var htmlText = ""
    private var placeholders = [String]()
    private var filledIn = 0
    var normalText: String {
        return attributedText.string
    }
    
    /// the story as a NSAttributedString.
    var attributedText: NSAttributedString {
        let data = Data((Story.startString + htmlText + Story.endString).utf8)
        let attributedString = try! NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
        return attributedString
    }
    
    /// constructs a new Story reading its text from the given input stream.
    /// - parameter stream: the story as a String with placeholders.
    init(withText stream: String) {
        self.read(withText: stream)
    }
    
    /// boolean value that determines if the Story is filled in completely.
    var isFilledIn: Bool {
        return filledIn >= placeholders.count
    }
    
    /// replaces the next unfilled placeholder with the given word.
    mutating func fillInPlaceholder(word: String) {
        if (!isFilledIn) {
            htmlText = htmlText.replacingOccurrences(of: "<\(filledIn)>", with: word)
            filledIn += 1
        }
    }
    
    /// next placeholder that can be filled in (e.g.: "adjective").
    var nextPlaceholder: String? {
        if isFilledIn {
            return nil
        } else {
            return placeholders[filledIn]
        }
    }
    
    /// total number of placeholders in the story.
    var totalPlaceholders: Int {
        return placeholders.count
    }
    
    /// ammount of placeholders that still need to be filled in.
    var remainingPlaceholders: Int {
        return placeholders.count - filledIn
    }
    
    /// reads initial story text from the given input stream.
    private mutating func read(withText stream: String) {
        let words = stream.split{ $0 == " " || $0 == "\r\n" || $0 == "\n"}
        
        for word in words {
            if (word.hasPrefix("<") && word.hasSuffix(">")) {
                // placeholder; replace with e.g. " <0>" so I can find/replace it easily later
                htmlText += " <b><\(placeholders.count)></b>"
                
                // "<plural-noun>" becomes "plural noun".
                let range = word.index(after: word.startIndex)..<word.index(before: word.endIndex)
                let placeholder = word[range].replacingOccurrences(of: "-", with: " ")
                placeholders.append(placeholder)
            } else {
                // regular word; just concatenate.
                if (htmlText.count != 0) {
                    htmlText += " ";
                }
                htmlText += word;
            }
        }
    }
}
