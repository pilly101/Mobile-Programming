//
//  ObjectsListViewController.swift
//  Painting Studio
//
//  Created by u0669056 on 2/17/17.
//  Copyright © 2017 u0669056. All rights reserved.
//

import UIKit

//THE CONTROLLER!!
class ObjectsListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, PaintingDataModelDelegate
{
    //THE VIEW!!!
    private var listView: UICollectionView{
        return view as! UICollectionView
    }
    
    var numOfCells = 25;
    //datamodel
    
    //THE MODEL!!!
    private var paintingDataModel: PaintingDataModel = PaintingDataModel()
    
    
    
    override func loadView() {
        let collectionLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        view = UICollectionView(frame: CGRect.zero, collectionViewLayout: collectionLayout)
        view.backgroundColor = UIColor.darkGray
        
    }
    
    override func viewDidLoad() {
        

        paintingDataModel.delegate = self
        
        listView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NSStringFromClass(UICollectionViewCell.self))
        
        let rightButtonItem = UIBarButtonItem.init(barButtonSystemItem: .add, target: self, action: #selector(addNewPainting))
        
        
        self.navigationItem.rightBarButtonItem = rightButtonItem
    
        
        listView.dataSource = self
        listView.delegate = self
    }
    override func viewWillAppear(_ animated: Bool) {
        listView.reloadData();
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return paintingDataModel.numPaintings
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //Get data element from indexPath
        let painting: Painting = paintingDataModel.paintingWithIndex(paintingIndex: indexPath.item)
        
        
        
        
        //Convert to a cell
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: NSStringFromClass(UICollectionViewCell.self), for: indexPath)
        //cell.backgroundColor = UIColor.lightGray
        
        //set cell sizes and row and columns, subclass UICollectionview cell in another class and do layout there!!
        
        
        
        //let label: UILabel = cell.contentView.subviews.count == 0 ? UILabel() : cell.contentView.subviews[0] as! UILabel
        //adddrawing view here!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        let theView: DrawingView = DrawingView()
        //painting.frame = cell.bounds
        theView.painting = painting
        theView.painting.backgroundColor = UIColor.lightGray
        //label.frame = cell.bounds
        theView.frame = cell.bounds
        theView.layer.cornerRadius = cell.bounds.height / 2.0
        theView.center = CGPoint(x: cell.bounds.width / 2.0, y: cell.bounds.height / 2.0)
        //theView.painting.backgroundColor = UIColor.red
        //theView.backgroundColor = UIColor.blue
        //theView.painting.backgroundColor = UIColor.white
        //        label.textColor = UIColor.white
        //TODO: create an image view, or instantiation view of painting view and load it with info from painting to represent painting.
        //label.text = "\(theView.painting.lines.count)"
        //label.adjustsFontSizeToFitWidth = true;
        
        cell.contentView.isUserInteractionEnabled = false;

        NSLog("Lines: " + "\(theView.painting.lines.count)")
        cell.contentView.addSubview(theView)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        //Get Data element from index
        //let painting: Painting = paintingDataModel.paintingWithIndex(paintingIndex: indexPath.item)
        
        
        let paintingIndex: Int = indexPath.item
    
        
        //Build a view controller and give it the data needs
        let objectViewController: ObjectViewController = ObjectViewController()
        
        //objectViewController.title = "\(painting.strokes.count)"
        
        objectViewController.paintingDataModel = paintingDataModel
        objectViewController.paintingIndex = paintingIndex
        
        //Where they can pull up the painting
        
        
        
        //objectViewController.labelView.text = "The painting has \(painting.strokes.count) strokes"
        
        //painting(painting, toObjectView: objectViewController.paintView)
        
        navigationController?.pushViewController(objectViewController, animated: true)
        //self.navigationItem.rightBarButtonItem = rightButtonItem
        
    }
    
//    private func paintingFromObjectView(paintView: ObjectView) -> Painting{
//        
//    }
//    private func painting(painting: Painting, toObjectView paintView: ObjectView)
//    {
//        
//    }
    func collection(collection: PaintingDataModel, strokeAddedToPainting paintingIndex: Int)
    {
        listView.reloadData()
    }
    func addNewPainting()
    {
        NSLog("Button HIT!")
        paintingDataModel.addNewPainting(painting: Painting())
        listView.reloadData()
    }
    

}
