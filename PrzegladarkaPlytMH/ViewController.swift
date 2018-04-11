//
//  ViewController.swift
//  PrzegladarkaPlytMH
//
//  Created by Użytkownik Gość on 12.10.2017.
//  Copyright © 2017 Użytkownik Gość. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var album: [[String:Any]] = []
    var count: Int = 0
    
    @IBOutlet weak var ktoryRekord: UILabel!
    @IBOutlet weak var wykonawcaText: UITextField!
    @IBOutlet weak var tytulText: UITextField!
    @IBOutlet weak var gatunekText: UITextField!
    @IBOutlet weak var rokText: UITextField!
    @IBOutlet weak var sciezkiText: UITextField!
    
    @IBOutlet weak var poprzedni: UIButton!
    @IBOutlet weak var nastepny: UIButton!
    @IBOutlet weak var zapisz: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://isebi.net/albums.php")
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            do {
                let utwory = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] ?? []
               // print(utwory[2]["album"])
                //Loop through array and set object in dictionary
                self.album = utwory
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        while (album.count == 0){
            
        }
        displayUtwor()
        wykonawcaText.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func displayUtwor() {
        if (count==0){
            poprzedni.isEnabled = false
        } else {
            poprzedni.isEnabled = true
        }
        if (count==(album.count-1)){
            nastepny.isEnabled = false
        } else {
            nastepny.isEnabled = true
        }
        zapisz.isEnabled = false
        ktoryRekord.text = "Rekord "+String(count+1)+" z "+String(album.count)
        wykonawcaText.text = album[count]["artist"] as? String
        tytulText.text = album[count]["album"] as? String
        gatunekText.text = album[count]["genre"] as? String
        rokText.text = String(describing: album[count]["year"]!)
        sciezkiText.text = String(describing: album[count]["tracks"]!)
    }
    
  
    @IBAction func wykonawcaText(_ sender: Any) {
        zapisz.isEnabled = true
    }
    
    @IBAction func tytulText(_ sender: Any) {
        zapisz.isEnabled = true
    }
    
    @IBAction func gatunekText(_ sender: Any) {
        zapisz.isEnabled = true
    }
    
    @IBAction func rokText(_ sender: Any) {
        zapisz.isEnabled = true
    }
    
    @IBAction func sciezkiText(_ sender: Any) {
        zapisz.isEnabled = true
    }
    
    @IBAction func poprzedniButton(_ sender: Any) {
        count = count - 1
        displayUtwor()
    }
    
    @IBAction func nastepnyButton(_ sender: Any) {
        count = count + 1
        displayUtwor()
    }
    
    @IBAction func zapiszButton(_ sender: UIButton) {
        var nowyRekord: [String:Any] = [:]
        nowyRekord["artist"] = wykonawcaText.text
        nowyRekord["album"] = tytulText.text
        nowyRekord["genre"] = gatunekText.text
        nowyRekord["year"] = rokText.text
        nowyRekord["tracks"] = sciezkiText.text
        if (count<album.count){
            album[count] = nowyRekord
        } else {
            album.append(nowyRekord)
            count = album.count - 1
        }
        displayUtwor()
    }
    
    @IBAction func nowyRekordButtton(_ sender: Any) {
        ktoryRekord.text = "Nowy Rekord"
        wykonawcaText.text = ""
        tytulText.text = ""
        gatunekText.text = ""
        rokText.text = ""
        sciezkiText.text = ""
        count = album.count
    }
    
    @IBAction func usunButton(_ sender: Any) {
        if (count > 0) {
            album.remove(at: count)
            count=count-1
            displayUtwor()
        } else if (count == 0 && album.count==1) {
            album.remove(at: count)
            nowyRekordButtton(self)
        } else if (album.count==0){
            nowyRekordButtton(self)
        } else {
            album.remove(at: count)
            displayUtwor()
        }
    }
}

