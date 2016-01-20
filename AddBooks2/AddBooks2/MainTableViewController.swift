//
//  MainTableViewController.swift
//  AddBooks2
//
//  Created by Gandhi Mena Salas on 17/01/16.
//  Copyright © 2016 Trenx. All rights reserved.
//

import UIKit


//*********************** variables globales


var Libros = [String]()
//var urlPortada:NSData!

//***********************

class MainTableViewController: UITableViewController {
    
    
//**********Outlets
    @IBOutlet var toDoListTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        if  NSUserDefaults.standardUserDefaults().objectForKey("Libros") != nil {
            
            Libros = NSUserDefaults.standardUserDefaults().objectForKey("Libros") as! [String]
        
        }
    }

    

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {

        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return Libros.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = Libros[indexPath.row]
        
        /*
        if  urlPortada != nil {
            
            cell.imageView?.image = UIImage(data: urlPortada)

            
        }
        */
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let libroSeleccionadoId = indexPath.row
        
        self.performSegueWithIdentifier("showDetails", sender: libroSeleccionadoId)
        
    }
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showDetails"{
            
            let libroSeleccinado = sender as! Int
        
            //let DetailsView: DetailsViewController = segue.destinationViewController as! DetailsViewController
            
            
        }
        
        
    }
    
    
    
    
    override func viewDidAppear(animated: Bool) {
        
        toDoListTable.reloadData()
        
    }
    
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //si al hacer swipe a la izquierda, luego presiono Delete se va a eliminar esa linea
        if editingStyle == .Delete {
          
            Libros.removeAtIndex(indexPath.row)
            
            NSUserDefaults.standardUserDefaults().setObject(Libros, forKey: "Libros")
            
            toDoListTable.reloadData()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation

    


}
