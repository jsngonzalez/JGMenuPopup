//
//  ViewController.swift
//  menuiPad
//
//  Created by Jeisson González on 27/11/17.
//  Copyright © 2017 wigilabs. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func mostrarOpciones(_ sender: Any) {
        
        let options=["una","dos","tres","cuatro","cinco"]
        
        
        JGMenuPopupViewController().openPopup(parent:self.navigationController!, title: "Sature brand", items:options, selected: "seis", callback: { value in
            print("titulo en el callback:"+value)
        })
    }
    
}

