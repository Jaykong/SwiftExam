//
//  ViewController.swift
//  SwiftQuiz
//
//  Created by kongyunpeng on 12/12/15.
//  Copyright © 2015 kongyunpeng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var _scoreLbl: UILabel?
    @IBOutlet weak var _imageView: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    }

    
    //用函数类型回调
    //setScoreLblValue的调用不是本页进行，而是通过传递一个setScoreLblValue（函数类型）在QuizViewController中调用
    
    func setScoreLblValue(value:Int) {
        _scoreLbl?.text = "分数：\(value)"
        if value >= 60 {
            _imageView?.image = UIImage(imageLiteral: "passExam")
        } else {
            _imageView?.image = UIImage(imageLiteral: "failExam")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     let controller = segue.destinationViewController as! QuizViewController
      controller.setScoreLblValue = setScoreLblValue
    }
    
}

