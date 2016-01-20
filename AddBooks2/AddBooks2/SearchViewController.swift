//
//  SearchViewController.swift
//  AddBooks2
//
//  Created by Gandhi Mena Salas on 18/01/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit



class SearchViewController: UIViewController {
    
//********* Outlets
    

    @IBOutlet weak var searchISBN: UITextField!
    @IBOutlet weak var bookTitle: UILabel!
    @IBOutlet weak var bookAuthor: UILabel!
    @IBOutlet weak var portadaLibro: UIImageView!
    
    @IBOutlet weak var formTitle: UILabel!
    @IBOutlet weak var authorTitle: UILabel!
    
    @IBOutlet weak var addBookFound: UIBarButtonItem!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        formTitle.text = ""
        authorTitle.text = ""
        addBookFound.title = ""
        // Do any additional setup after loading the view.
        
    }

    
//***********Event: Did end on exit
    
    @IBAction func searchISBNButton(sender: UITextField) {
        
        buscarLibro()
        
        formTitle.text = "Title:"
        authorTitle.text = "Author(s):"
        
        
    }

    
    
//**********Funcion buscarLibro
    
    func buscarLibro(){
        
        //ISBN
        let ISBN:String = searchISBN.text!
        let urls:String = "https://openlibrary.org/api/books?jscmd=data&format=json&bibkeys=ISBN:\(ISBN)"
        let url = NSURL(string: urls)!
        let datos = NSData(contentsOfURL: url)
        
        if datos != nil {
            
            addBookFound.title = "Add"
            
            do{
                
                let json = try NSJSONSerialization.JSONObjectWithData(datos!, options: NSJSONReadingOptions.MutableLeaves)
                
                
                //TITULO
                let diccionario1 = json as! NSDictionary
                let diccionario2 = diccionario1["ISBN:\(ISBN)"] as! NSDictionary
                bookTitle.text = diccionario2["title"] as! NSString as String
                
                
                //PORTADA
                
                if diccionario2["cover"] != nil{
                    
                    let diccionario3 = diccionario2["cover"] as! NSDictionary
                    let img_urls = diccionario3["large"] as! String //convertimos el link de la imagen en String
                    let img_url = NSURL(string: img_urls) // la convertimos a url
                    let img_data = NSData(contentsOfURL: img_url!) //obtenemos el contenido de esa url (la imagen)
                    let imagen = UIImage(data: img_data!) // la imagen la convertimos en UIImage
                
                    if imagen != nil {
                    
                        portadaLibro.image = imagen //ahora esa imagen se la asignamos al UIImageView(portadaLibro)
                    
                    }
                    
                //******Portada para la lista de libros
                //urlPortada = img_data
                
                }
                
                
    
                //AUTORES
                let diccionario4 = diccionario2["authors"] as! NSArray
                let diccionario5 = diccionario4.valueForKey("name")
                let diccionario6 = diccionario5[0] as! String as String
                bookAuthor.text = diccionario6

                
                
            }
                
            catch {}
            
        }else{
            
            let alert = UIAlertController(title: "Sin Conexión a Internet", message: "Verifica tu conexión a internet", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
    }

    
    
//*****************Funcino añadir titulo
    
    @IBAction func addBookFound(sender: UIBarButtonItem) {
    
      Libros.append(bookTitle.text!)
        
        detalleTitulo = bookTitle.text!
        detalleAuthor = bookAuthor.text!
        detallePortada = portadaLibro.image
       
        searchISBN.text = ""

        NSUserDefaults.standardUserDefaults().setObject(Libros, forKey: "Libros")
        anadirLibroAlert()
        
    }
    
//************ function Alert
    func anadirLibroAlert(){
    
        let alerta = UIAlertController(title: "Confirmado", message: "Tu libro se ha añadido a tu lista con éxito", preferredStyle: .ActionSheet)
        /*
        let cancelAction = UIAlertAction(title: "Cancelar", style: .Cancel){
            (action:UIAlertAction!) in
            
            print("pulsaste cancelar")
        }
        */
        let OkAction = UIAlertAction(title: "OK", style: .Default){
            (action:UIAlertAction!) in
            
            //print("pulsaste Ok")
        }
        
        alerta.addAction(OkAction)
        
        self.presentViewController(alerta, animated: true, completion: nil)
    }
    
    
    
//*********************Toggle Keboard
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        self.view.endEditing(true)
        
    }
    
    func textFieldShouldReturn(textField: UITextField!)-> Bool{
        textField.resignFirstResponder()
        
        return true
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
