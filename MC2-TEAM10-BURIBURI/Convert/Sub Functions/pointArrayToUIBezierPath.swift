//
//  pointArrayToUIBezierPath.swift
//  MC2 Removing Background
//
//  Created by Wonil Lee on 2023/05/11.
//

import Foundation
import UIKit

func pointArrayToUIBezierPath(_ pointArray: [CGPoint]) -> UIBezierPath {
	
	//https://zeddios.tistory.com/846
	
	var path = UIBezierPath()
	if !(pointArray.isEmpty) {
		path.move(to: pointArray[0])
	}
	
	if pointArray.count >= 1 {
		for i in 1..<pointArray.count {
			path.addLine(to: pointArray[i])
		}
	}
	
	path.close()
	
	return path
}
