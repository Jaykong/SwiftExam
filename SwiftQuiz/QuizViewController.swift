//
//  QuizViewController.swift
//  SwiftQuiz
//
//  Created by kongyunpeng on 12/12/15.
//  Copyright © 2015 kongyunpeng. All rights reserved.
//

import UIKit

class QuizViewController: UIViewController,UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate {

    //@IBOutlet weak var tableView: 
    var _scrollView:UIScrollView!
    var _tableView1:UITableView!
    var _tableView2:UITableView!
    var _tableView3:UITableView!
    var questions:[Question] = []
    var currentPage = 0
    var prePage = 0
    var nextPage = 0
    var reusedPage = 0
    var setScoreLblValue:((Int) -> Void)!
    
    func pageCheck(page:Int) ->Int {
        if page == -1 {
            return questions.count - 1
        }
        if page >= questions.count {
            return 0
        }
        return page
    }
    func initReusedPage(tableview:UITableView) {
        switch tableview {
        case _tableView1:
            
            prePage = pageCheck(prePage)
            reusedPage = prePage
        case _tableView2:
            
            currentPage = pageCheck(currentPage)
            reusedPage = currentPage
        case _tableView3:
            
            nextPage = pageCheck(nextPage)
            reusedPage = nextPage
        default:
            reusedPage = 0
        }
    }
    
    func handInPaper() {
        setScoreLblValue(self.getScoreSum(questions))
        self.navigationController?.popViewControllerAnimated(true)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightItem = UIBarButtonItem(title: "交卷", style: UIBarButtonItemStyle.Done, target: self, action:"handInPaper")
        self.navigationItem.rightBarButtonItem = rightItem
       let q1 = Question(title: "下面是常数的是：", option: ["let a = 15","var b = 16","var c = 55","var d = 13"], answer: "let a = 15")
        let q2 = Question(title: "可选类型的声明正确的是：", option: ["String!","Int!","Int?","Int*"], answer: "Int?")
        let q3 = Question(title: "下面哪个元组是(Int,Character,String)类型", option: ["(3,\"A\",\"apple\")","(3,\"orange\",\"apple\")","(3,\"ABC\",\"超人\")","(\"text\",\"A\",\"apple\")"], answer: "(3,\"A\",\"apple\")")
        let q4 = Question(title: "下面数组的声明正确的是：", option: ["Array[Int]","[Int]","Array(Int)","(Character)"], answer: "[Int]")
      
        
        let q5 = Question(title: "已知数组[1,3,5,7,9]，它的count属性值是：", option: ["5","4","6","2"], answer: "5")
        let q6 = Question(title: "声明一个数组变量名为familyNames = [\"kong\",\"li\",\"liu\",\"gao\"],以下表达式错误的是：", option:
    ["familyNames[0] = \"qian\"","familyNames[1] = \"fu\"","familyNames[2] = \"qing\"","familyNames[4] = \"zhao\""],
            answer: "familyNames[4] = \"zhao\"")
        
        
    let q7 = Question(title: "已知：var firstStr = \"Hello\" \n var secondStr = \"There\"，以下表达式错误的是：", option: ["firstStr + secondStr","\"Hello\" + \"There\"","\\(firstStr)\\(secondStr)","firstStr.append(secondStr)"], answer: "firstStr.append(secondStr)")
        let q8 = Question(title: "以下哪一个是隐式解析可选类型", option: ["let a:String!","let b:Int?","let c:Double = 55","var d:[Character]?"], answer: "let a:String!")
        let q9 = Question(title: "1+2+...99+100的值是多少（用程序编写求出结果）", option: ["4950","5050","5100","5200"], answer: "5050")
        let q10 = Question(title: "计算7!的值就是1x2x3...x7用程序编写求出结果）", option: ["5040","5030","5020","5050"], answer: "5040")
        
        questions = [q1,q2,q3,q4,q5,q6,q7,q8,q9,q10]
        
        let width = view.bounds.size.width
        let height =  view.bounds.size.height
        
       _scrollView = UIScrollView(frame: view.bounds)
       _scrollView.pagingEnabled = true
      
       _scrollView.contentSize = CGSizeMake(width * 3, height)
        
        _tableView1 = UITableView(frame: view.frame, style: UITableViewStyle.Plain)
        _tableView2 = UITableView(frame: view.frame, style: UITableViewStyle.Plain)
        _tableView3 = UITableView(frame: view.frame, style: UITableViewStyle.Plain)
        
        _tableView1!.frame = CGRectMake(0, 0, width, height)
        _tableView2!.frame = CGRectMake(width, 0, width, height)
        _tableView3!.frame = CGRectMake(2 * width ,0, width, height)
        
        _scrollView.delegate = self
        _tableView1.delegate = self
        _tableView1.dataSource = self
        
        _tableView2.delegate = self
        _tableView2.dataSource = self
        
        _tableView3.delegate = self
        _tableView3.dataSource = self

        _scrollView.addSubview(_tableView1)
        _scrollView.addSubview(_tableView2)
        _scrollView.addSubview(_tableView3)
        
        view.addSubview(_scrollView)

        
        
        _scrollView.bounces = false
        _scrollView.alwaysBounceVertical = false
        
        self.edgesForExtendedLayout = UIRectEdge.None
        
        _scrollView.contentOffset = CGPointMake(width, 0)
        
        currentPage = 0
        prePage = -1
        nextPage = 1
        
    }

    func scrollViewDidScroll(scrollView: UIScrollView) {
        if (scrollView == _scrollView) {
        
        let contentOffsetX = scrollView.contentOffset.x
        print(contentOffsetX)
       
        let width = scrollView.frame.size.width
        
        
        switch contentOffsetX {
        case 2 * width:
            
        ++currentPage
        ++prePage
        ++nextPage
             self.reloadAllTableViews()
            _scrollView.contentOffset = CGPointMake(width, 0)
          
        case 0:
           --currentPage
           --prePage
           --nextPage
             self.reloadAllTableViews()
            _scrollView.contentOffset = CGPointMake(width, 0)
            
        default:
            break
        }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
     let quesition = questions[reusedPage]
      if (section == 1) {
          return  quesition.option.count
        }
       return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        self.initReusedPage(tableView)
        let question = questions[reusedPage]
        
        var cell = tableView.dequeueReusableCellWithIdentifier("Cell")
        if (cell == nil) {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.font = UIFont.systemFontOfSize(22)
        }
        if indexPath.section == 1 {
           
            if let userAnswer = question.userAnswer{
                if userAnswer == question.option[indexPath.row] {
                    cell?.accessoryType = UITableViewCellAccessoryType.Checkmark
                } else {
                    cell?.accessoryType = UITableViewCellAccessoryType.None
                }
            } else {
              cell?.accessoryType = UITableViewCellAccessoryType.None
            }
            
           let abcd = self.indexToABCD(indexPath.row)
            
            cell?.textLabel?.text = "\(abcd):\(question.option[indexPath.row])"
            
             return cell!
    }
   
        cell?.textLabel?.text = "\(reusedPage + 1)、\(question.title)"
        
        return cell!
        
   
}
    
func reloadAllTableViews() {
        _tableView1.reloadData()
        _tableView2.reloadData()
        _tableView3.reloadData()
    }
    
func indexToABCD(index:Int) ->String! {
        switch index {
        case 0:
            return "A"
        case 1:
            return "B"
        case 2:
            return "C"
        case 3:
            return "D"
        default:
            break
        }
        
    return nil
 }
   
    func getScoreSum(questions:[Question]) -> Int {
       var totalScore = 0
        for q in questions {
          totalScore += q.score
            
        }
        return totalScore
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 66
    }
    
func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        let quesition = questions[currentPage]
    
    quesition.userAnswer = quesition.option[indexPath.row]
    
    //self.indexToABCD(indexPath.row)
    
    if quesition.userAnswer == quesition.answer {
      quesition.score = 10
    } else {
        quesition.score = 0
    }
        
        self.reloadAllTableViews()
    }
}

