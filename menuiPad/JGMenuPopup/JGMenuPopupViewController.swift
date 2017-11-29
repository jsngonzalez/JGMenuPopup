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
        let yView=177
        
        if itemsPopup.count <= 7 {
            
            let xView=(Int(viewContentMenu.frame.size.width/2) - Int(widthView/2))
            
            setButtonsToView(frame: CGRect(x: xView, y: yView, width: widthView, height: heigthView), items: itemsPopup);
        }else if itemsPopup.count > 7  &&  itemsPopup.count <= 12 {
            
            let halfView=Int(viewContentMenu.frame.size.width/2)
            
            let xView1=(Int(halfView/2) - Int(widthView/2))
            let xView2=(halfView + Int(widthView/2))
            
            var array1:[String]=[]
            for index in 0...6 {
                array1.append(itemsPopup[index])
            }
            
            setButtonsToView(frame: CGRect(x: xView1, y: yView, width: widthView, height: heigthView), items: array1);
            
            var array2:[String]=[]
            for index in 7...(itemsPopup.count-1) {
                array2.append(itemsPopup[index])
            }
            setButtonsToView(frame: CGRect(x: xView2, y: yView, width: widthView, height: heigthView), items: array2);
            
        }else{//mas de 12
            
            let halfView=Int(viewContentMenu.frame.size.width/2)
            
            let xView1=(Int(halfView/2) - Int(widthView/2))
            let xView2=(Int(viewContentMenu.frame.size.width/2) - Int(widthView/2))
            let xView3=(halfView + Int(widthView/2))
            
            var array1:[String]=[]
            for index in 0...6 {
                array1.append(itemsPopup[index])
            }
            
            setButtonsToView(frame: CGRect(x: xView1, y: yView, width: widthView, height: heigthView), items: array1);
            
            var array2:[String]=[]
            for index in 7...13 {
                array2.append(itemsPopup[index])
            }
            setButtonsToView(frame: CGRect(x: xView2, y: yView, width: widthView, height: heigthView), items: array2);
            
            
            var array3:[String]=[]
            for index in 14...(itemsPopup.count-1) {
                array3.append(itemsPopup[index])
            }
            setButtonsToView(frame: CGRect(x: xView3, y: yView, width: widthView, height: heigthView), items: array3);
        }
        
        
    }
    
    func setButtonsToView(frame:CGRect,items:[String]) {
        let view=UIView(frame: frame)
        let padding=5
        let heigthBtn=40
        let widthBtn=179
        let xBtn=(Int(view.frame.size.width/2) - Int(widthBtn/2))
        
        for (index, item)  in items.enumerated() {
            print("pintando:\(item)")
            let btn=UIButton(frame: CGRect(x: xBtn, y: ((index)*heigthBtn)+(index*padding), width: widthBtn, height: heigthBtn))
            btn.setTitle(item, for: .normal)
            btn.titleLabel?.textColor = .white
            btn.backgroundColor = .clear
            
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
        
        viewContentMenu.addSubview(view)
        
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
