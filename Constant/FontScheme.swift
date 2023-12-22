//
//  FontScheme.swift
//  GreenWorld
//
//  Created by zouaoui on 29/11/2023.
//

import Foundation
import SwiftUI

class FontScheme: NSObject {
    static func kInterSemiBold(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kInterSemiBold, size: size)
    }

    static func kInterRegular(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kInterRegular, size: size)
    }

    static func kInterMedium(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kInterMedium, size: size)
    }

    static func kInterBold(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kInterBold, size: size)
    }

    static func kUrbanistRomanMedium(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kUrbanistRomanMedium, size: size)
    }

    static func kPoppinsRegular(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kPoppinsRegular, size: size)
    }

    static func kGilroyRegular(size: CGFloat) -> Font {
        return Font.custom(FontConstant.kGilroyRegular, size: size)
    }

    static func fontFromConstant(fontName: String, size: CGFloat) -> Font {
        var result = Font.system(size: size)

        switch fontName {
        case "kInterSemiBold":
            result = self.kInterSemiBold(size: size)
        case "kInterRegular":
            result = self.kInterRegular(size: size)
        case "kInterMedium":
            result = self.kInterMedium(size: size)
        case "kInterBold":
            result = self.kInterBold(size: size)
        case "kUrbanistRomanMedium":
            result = self.kUrbanistRomanMedium(size: size)
        case "kPoppinsRegular":
            result = self.kPoppinsRegular(size: size)
        case "kGilroyRegular":
            result = self.kGilroyRegular(size: size)
        default:
            result = self.kInterSemiBold(size: size)
        }
        return result
    }

    enum FontConstant {
        /**
         * Please Add this fonts Manually
         */
        static let kInterSemiBold: String = "Inter-SemiBold"
        /**
         * Please Add this fonts Manually
         */
        static let kInterRegular: String = "InterRegular"
        /**
         * Please Add this fonts Manually
         */
        static let kInterMedium: String = "Inter-Medium"
        /**
         * Please Add this fonts Manually
         */
        static let kInterBold: String = "InterBold"
        /**
         * Please Add this fonts Manually
         */
        static let kUrbanistRomanMedium: String = "UrbanistRoman-Medium"
        /**
         * Please Add this fonts Manually
         */
        static let kPoppinsRegular: String = "Poppins-Regular"
        /**
         * Please Add this fonts Manually
         */
        static let kGilroyRegular: String = "Gilroy-Regular"
    }
}
