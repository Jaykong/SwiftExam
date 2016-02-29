//
//  Question.swift
//  SwiftQuiz
//
//  Created by kongyunpeng on 12/13/15.
//  Copyright © 2015 kongyunpeng. All rights reserved.
//

import UIKit

class Question {
    let title:String
    let option:[String]
    let answer:String
    var userAnswer:String?
    var score = 0
    init(title:String,option:[String],answer:String) {
        self.title = title
        self.option = option
        self.answer = answer
    }
 }
