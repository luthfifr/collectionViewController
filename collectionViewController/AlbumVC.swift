//
//  AlbumVC.swift
//  collectionViewController
//
//  Created by Luthfi Fathur Rahman on 6/7/17.
//  Copyright © 2017 Luthfi Fathur Rahman. All rights reserved.
//

import UIKit

private let reuseIdentifier = "AlbumCell"

class AlbumVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var sections = [[String]]()
    let fileManager = FileManager.default
    let path = Bundle.main.resourcePath! + "/aset"
    let path2 = Bundle.main.resourcePath! + "/aset2"
    var paths = [String]()
    var pathFiles = [String]()
    var albums = [String]()
    var folderNames = [String]()
    
    let sectionInsets = UIEdgeInsets(top: 25.0, left: 10.0, bottom: 25.0, right: 10.0)
    let itemsPerRow: CGFloat = 6

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Albums"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        folderNames = ["aset", "aset2"]
        paths = [path, path2]
        
        albums = ["Miscellaneous 1", "Miscellaneous 2"]
        
        for i in 0 ..< paths.count {
            self.pathFiles = try! self.fileManager.contentsOfDirectory(atPath: self.paths[i])
            self.sections.append(self.pathFiles)
            self.pathFiles.removeAll()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueAlbum" {
            let destVC = segue.destination as! CollectionViewController
            
            let theSender = sender as! UIButton
            destVC.path = self.paths[theSender.tag]
            destVC.judul = self.albums[theSender.tag]
            destVC.folderName = self.folderNames[theSender.tag]
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! headerInAlbumVC
        
        view.tag = indexPath.section
        view.label_header.text = albums[indexPath.section]
        view.label_header.sizeToFit()
        view.label_header.tag = indexPath.section
        view.nextButton.tag = indexPath.section
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumCell
        
        cell.backgroundColor = UIColor.black
        
        cell.imageView.image = UIImage(named: "\(String(describing: self.folderNames[indexPath.section]))/\(sections[indexPath.section][indexPath.item])")
        cell.imageView.contentMode = .scaleAspectFill
        
        return cell
    }
    
    // MARK: UICollectionViewDelegateFlowLayout
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

}
