//
//  ViewController.swift
//  TStudySwift01
//
//  Created by ways on 2018/1/4.
//  Copyright © 2018年 tikeyc. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    public static let screenWidth = UIScreen.main.bounds.width
    
    public static let screenHeight = UIScreen.main.bounds.height
    
    
    enum TestEnumType : String {
        case TestEnumType1 = "1"
        case TestEnumType2 = "2"
        case TestEnumType3 = "3"
    }
    
    
    lazy var tableView: UITableView = { [unowned self] in
        let tableView : UITableView = UITableView.init(frame: CGRect.init(x: 0, y: 0, width: ViewController.screenWidth, height: ViewController.screenHeight), style: UITableViewStyle.plain)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var listType: TestEnumType {
        get {
            return .TestEnumType1
        }
        set {
            self.listType = newValue
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //https://github.com/DiveinEdu/divein_swift
        
        self.view.backgroundColor = UIColor.orange

        initProperty()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //TODO: - 测试代码
    func test() -> Void {
        //FIXME: 警告，相当于OC的#warming
        let count:Int = 300_000
        print(count)
        
        let couple = (2,"2")
        print(couple)
        
        switch couple {
        case (2,let y):
            print("y = \(y)")
            fallthrough//继续执行下一个case
        default:
            print(couple)
        }
        
        breekTag : for _ in 1...4 {
            //1 2 3 4
            for _ in 1...4 {
                for _ in 1...4 {
                    break breekTag//跳出全部for循环，与Java一样的功能
                }
            }
        }
        
        for _ in 1..<4 {
            //1 2 3
        }
        let array = ["1","2","3","4"]
        for (index,value) in array.enumerated() {
            print("\(index):" + value)
        }
        
        var a: String?
        print(a ?? "a = nil")
        a = "空合运算符"//约等于三目运算符的效果
        print(a ?? "a = nil")
        
        /*闭包表达式语法
         
         闭包表达式语法有如下的一般形式：
         
         { (parameters) -> returnType in
         statements
         }
         */
        //闭包，相当于block
        let _ = {(s1:String, s2: String) -> Bool in
            return s1 > s2
        }
        //单行 省略return
        let _ = {(s1:String, s2: String) -> Bool in s1 > s2}
    
        //下标
        class Test {

            let defaultValue = 2
            
            subscript(index: Int) ->Int {
                return defaultValue*index
            }
        }
        let test = Test()
        print(test[1])
        
    }

    
    func initProperty() -> Void {
        
        self.view.addSubview(tableView)
    }
    
    //MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier")
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "cellIdentifier")
        }
        
        cell?.textLabel?.text = "cell \(indexPath.row)"
        
        return cell!
    }
    
    //MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        
        let login = LoginViewController()
        self.present(login, animated: true) {
            print("completion")
        }
        
        
    }
    
    //MARK: - UIScrollViewDelegate

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}









