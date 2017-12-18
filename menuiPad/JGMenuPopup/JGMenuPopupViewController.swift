//
//  JGMenuPopuViewController.swift
//  menuiPad
//
//  Created by Jeisson González on 27/11/17.
//  Copyright © 2017 wigilabs. All rights reserved.
//

import UIKit

class JGMenuPopupViewController: UIViewController,UIViewControllerTransitioningDelegate {
    
    
    public var finalCallback: (String) -> Void = {item in}
    public var titlePopup=""
    public var parentPopup: UIViewController?
    public var itemsPopup:[String]=[]
    public var selectedPopup=""
    @IBOutlet var viewContent: UIView!
    @IBOutlet var viewContentMenu: UIView!
    @IBOutlet var lblTitulo: UILabel!
    @IBOutlet var scrollView: UIScrollView!
    
    public func openPopup(parent:UINavigationController,title:String,items:[String],selected:String,callback:@escaping (String) -> Void){
        
        let storyboard = UIStoryboard(name: "JGMenuPopup", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "JGMenuPopup") as! JGMenuPopupViewController
        controller.finalCallback=callback;
        controller.titlePopup=title;
        controller.itemsPopup=items;
        controller.selectedPopup=selected;
        
        //controller.modalPresentationStyle = .overCurrentContext
        
        controller.modalPresentationStyle = .overCurrentContext
        controller.modalTransitionStyle = UIModalTransitionStyle.crossDissolve;
        controller.providesPresentationContextTransitionStyle = true;
        controller.definesPresentationContext = true;
        parent.present(controller, animated: true, completion: nil)
        
    }
    
    @IBAction func close(_ sender: Any) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.viewContent.layer.opacity=0;
        }) { (true) in
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(titlePopup)
        print(itemsPopup)
        
        initView()
        
        viewContent.layer.opacity=0
        UIView.animate(withDuration: 0.5) {
            self.viewContent.layer.opacity=1
        }
        
    }
    
    func initView(){
        print("numero de items:\(itemsPopup.count)")
        
        lblTitulo.text=titlePopup
        
        let heigthView=361
        let widthView=240
        let yView=0
        
        
        let halfView=Int(viewContentMenu.frame.size.width/2)
        
        let xView1=(Int(halfView/2) - Int(widthView/2))
        let xView2=(Int(viewContentMenu.frame.size.width/2) - Int(widthView/2))
        let xView3=(halfView + Int(widthView/2))
        
        let xContainers = [xView1,xView2,xView3]
        
        let numItems=Int(itemsPopup.count/3)
        //print("numero de items por contenedor: \(numItems)")
        
        
        //print("Numero de items: \(itemsPopup.count)")
        for index in 0...2 {
            //print("se pinta el contenedor: \(index)")
            
            let inicio = (index*numItems)
            var fin = ((index*numItems)+numItems)-1
            
            if index == 2{
                fin=itemsPopup.count-1
            }
            
            var array:[String]=[]
            for i in inicio...fin {
                array.append(itemsPopup[i])
            }
            
            setButtonsToView(frame: CGRect(x: xContainers[index], y: yView, width: widthView, height: heigthView), items: array);
            
            print("se pintan los items: \(array)")
        }
        
        var maxY=0
        let allLabels : [UIButton] = getSubviewsOf(view: scrollView)
        for item in allLabels {
            if Int(item.frame.origin.y) > maxY {
                maxY=Int(item.frame.origin.y)
            }
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height:CGFloat(maxY+100))
        
    }
    
    private func getSubviewsOf<T : UIView>(view:UIView) -> [T] {
        var subviews = [T]()
        
        for subview in view.subviews {
            subviews += getSubviewsOf(view: subview) as [T]
            
            if let subview = subview as? T {
                subviews.append(subview)
            }
        }
        
        return subviews
    }
    
    
    func setButtonsToView(frame:CGRect,items:[String]) {
        let view=UIView(frame: frame)
        let padding=5
        let heigthBtn=40
        let widthBtn=179
        let xBtn=(Int(view.frame.size.width/2) - Int(widthBtn/2))
        
        for (index, item)  in items.enumerated() {
            //print("pintando:\(item)")
            let btn=UIButton(frame: CGRect(x: xBtn, y: ((index)*heigthBtn)+(index*padding), width: widthBtn, height: heigthBtn))
            btn.setTitle(item, for: .normal)
            btn.titleLabel?.textColor = .white
            btn.backgroundColor = .clear
            btn.titleLabel?.lineBreakMode = .byTruncatingTail;
            
            if selectedPopup==item {
                btn.titleLabel?.font=UIFont.boldSystemFont(ofSize: 17)
                btn.layer.borderColor = UIColor(red: 29/255.0, green: 107/255.0, blue: 133/255.0, alpha: 1.0).cgColor
                btn.layer.borderWidth = 2
            }else{
                btn.titleLabel?.font=UIFont.systemFont(ofSize: 17)
            }
            
            
            btn.addTarget(self, action: #selector(selectItem(_:)), for: .touchUpInside)
            btn.tag=index
            view.addSubview(btn)
        }
        
        scrollView.addSubview(view)
        
    }
    
    @objc func selectItem(_ button: UIButton) {
        print("Button with tag: \(button.tag) clicked!")
        print("view parent with tag: \(button.superview?.tag ?? 0) ")
        
        UIView.animate(withDuration: 0.5, animations: {
            button.titleLabel?.font=UIFont.boldSystemFont(ofSize: 17)
            button.layer.borderColor = UIColor(red: 29/255.0, green: 107/255.0, blue: 133/255.0, alpha: 1.0).cgColor
            button.layer.borderWidth = 2
            
        }) { (true) in
            self.finalCallback(button.titleLabel?.text ?? "")
            self.dismiss(animated: true, completion: nil)
        }
        
        
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
