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
    public var itemsPopup:[String]?
    public var selectedPopup=""
    @IBOutlet var viewContent: UIView!
    @IBOutlet var viewContentMenu: UIView!
    
    
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
            self.finalCallback("listo!!!")
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print(titlePopup)
        print(itemsPopup!)
        
        initView()
        
        viewContent.layer.opacity=0
        UIView.animate(withDuration: 0.5) {
            self.viewContent.layer.opacity=1
        }
        
    }
    
    func initView(){
        print("numero de items:\(itemsPopup!.count)")
        
        let myNewView:UIView=UIView(frame: CGRect(x: 36, y: 177, width: 240, height: 361))
        myNewView.backgroundColor = .blue
        for item in itemsPopup! {
            print("pintando")
            let btn:UIButton=UIButton(frame: CGRect(x: 35, y: 30, width: 179, height: 46))
            btn.titleLabel?.text=item
            btn.titleLabel?.textColor = .white
            btn.backgroundColor = .clear
            btn.titleLabel?.font=UIFont.boldSystemFont(ofSize: 25)
            myNewView.addSubview(btn)
        }
        viewContentMenu.addSubview(myNewView)
        
        
        
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
