//
//  ViewController.swift
//  TestM
//
//  Created by GS on 03/08/20.
//  Copyright © 2020 Gaurishankar Vibhute. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    var picsummodel: [PicsumModel] = []
    let presenter = PicsumPresenter();
    
    var baseUrl = "https://picsum.photos/300/300?image="
    
    weak var collectionView: UICollectionView!

      

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        loadData()
         self.collectionView.dataSource = self
               self.collectionView.delegate = self
               self.collectionView.register(Cell.self, forCellWithReuseIdentifier: Cell.identifier)
               self.collectionView.alwaysBounceVertical = true
               self.collectionView.backgroundColor = .white
    }
    
    func loadData(){
        presenter.makeapicall {
            result in
            self.picsummodel = result
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
            
        }
    }

    
    override func loadView() {
        super.loadView()

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
//        collectionView.insetsLayoutMarginsFromSafeArea = true
        
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            self.view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: collectionView.topAnchor),
            self.view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor),
            self.view.safeAreaLayoutGuide.leadingAnchor.constraint(equalTo: collectionView.leadingAnchor),
            self.view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: collectionView.trailingAnchor),
        ])
        self.collectionView = collectionView
       
    }
    
}


extension ViewController: UICollectionViewDataSource {

       func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int  {
        if picsummodel.count > 1 {
            return picsummodel.count
        }else{
            return 0
        }
       }

      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
           let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.identifier, for: indexPath) as! Cell

        print(picsummodel[indexPath.item].id)
        let tmp = baseUrl + String(picsummodel[indexPath.item].id)
        let imageUrl:NSURL = NSURL(string: tmp)!
         
        DispatchQueue.global(qos: .userInitiated).async {
             
            var imageData:NSData?
            if let imagedata = NSData(contentsOf: imageUrl as URL){
                    imageData = imagedata
                }else{
//                     print("invalide image")
                let tmpimg = UIImage(named: "loading.png")
                imageData = tmpimg?.pngData() as NSData?
                }
         
         
             DispatchQueue.main.async {
                 
                let image = UIImage(data: imageData! as Data)
                cell.imageView?.image = image
                cell.imageView!.contentMode = UIView.ContentMode.scaleAspectFit
                 
             }
         
       }
        cell.label!.text = picsummodel[indexPath.item].author

          return cell
    }
   }

   extension ViewController: UICollectionViewDelegate {

       func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            
       }
   }

   extension ViewController: UICollectionViewDelegateFlowLayout {

       func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width*0.45, height: 220)
        
       }

       func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           insetForSectionAt section: Int) -> UIEdgeInsets {
           return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) //.zero
       }

       func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }

       func collectionView(_ collectionView: UICollectionView,
                           layout collectionViewLayout: UICollectionViewLayout,
                           minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 10
       }
   }


