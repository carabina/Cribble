//
//    Copyright (c) 2016 Max Sokolov https://twitter.com/max_sokolov
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy of
//    this software and associated documentation files (the "Software"), to deal in
//    the Software without restriction, including without limitation the rights to
//    use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of
//    the Software, and to permit persons to whom the Software is furnished to do so,
//    subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS
//    FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//    COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//    IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
//    CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

import UIKit

class CribbleView: UIView {

    private var cribbleOptions = CribbleOptions.defaultOptions() {
        didSet {
            setNeedsDisplay()
        }
    }

    override func drawRect(rect: CGRect) {
        
        let lineWidth = 1 / UIScreen.mainScreen().scale
        
        let context = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(context, lineWidth)
        CGContextSetStrokeColorWithColor(context, cribbleOptions.color.CGColor)
        
        // Calculate column width and row height
        let columnWidth: CGFloat = cribbleOptions.horizontalStep
        let rowHeight: CGFloat = cribbleOptions.verticalStep
        
        let numberOfColumns: CGFloat = UIScreen.mainScreen().bounds.width / columnWidth
        let numberOfRows: CGFloat = UIScreen.mainScreen().bounds.height / rowHeight
        
        // Drawing column lines
        for var i in 0..<Int(numberOfColumns) + 1 {
            
            let startPoint = CGPoint(x: columnWidth * CGFloat(i) - lineWidth, y: 0)
            let endPoint = CGPoint(x: startPoint.x, y: frame.size.height)
            
            CGContextMoveToPoint(context, startPoint.x, startPoint.y)
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y)
            CGContextStrokePath(context)
            
            i += 1
        }
        
        // Drawing row lines
        for var j in 0..<Int(numberOfRows) + 1 {
            
            let startPoint = CGPoint(x: 0, y: rowHeight * CGFloat(j) - lineWidth)
            let endPoint = CGPoint(x: frame.size.width, y: startPoint.y)
            
            CGContextMoveToPoint(context, startPoint.x, startPoint.y)
            CGContextAddLineToPoint(context, endPoint.x, endPoint.y)
            CGContextStrokePath(context)
            
            j += 1
        }
    }
}