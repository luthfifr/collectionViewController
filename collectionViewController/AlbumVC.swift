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
    let path = "/Users/LuthfiFR/Documents/bahan_buku_ios101/collectionViewController/collectionViewController/aset" //Bundle.main.resourcePath! + "/collectionViewController/collectionViewController/aset"
    let path2 = "/Users/LuthfiFR/Documents/bahan_buku_ios101/collectionViewController/collectionViewController/aset2"
    var paths = [String]()
    var pathFiles = [String]()
    var albums = [String]()
    
    let sectionInsets = UIEdgeInsets(top: 25.0, left: 10.0, bottom: 25.0, right: 10.0)
    let itemsPerRow: CGFloat = 6

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Albums"
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        paths = [path, path2]
        
        albums = ["Miscellaneous 1", "Miscellaneous 2"]
        
        for i in 0 ..< paths.count {
            self.pathFiles = try! self.fileManager.contentsOfDirectory(atPath: self.paths[i])
            self.sections.append(self.pathFiles)
            self.pathFiles.removeAll()
        }
        
        for i in 0 ..< sections.count {
            for j in 0 ..< sections[i].count {
                print("sections[\(i)][\(j)] = \(sections[i][j])")
            }
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
        }
    }
    
    // MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header", for: indexPath) as! headerInAlbumVC
        
        view.tag = indexPath.section
        view.label_header.text = albums[indexPath.section]
        view.label_header.sizeToFit()
        view.nextButton.tag = indexPath.section
        
        return view
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sections[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlbumCell
        
        cell.backgroundColor = UIColor.black
        
        var oftype: String?
        
        if sections[indexPath.section][indexPath.item].contains("jpeg") {
            oftype = "jpeg"
        } else if sections[indexPath.section][indexPath.item].contains("jpg") {
            oftype = "jpg"
        }
        
        let fileName = sections[indexPath.section][indexPath.item].index(sections[indexPath.section][indexPath.item].endIndex, offsetBy: -((oftype?.characters.count)!+1))
        
        let imageBundle = Bundle.main.path(forResource: sections[indexPath.section][indexPath.item].substring(to: fileName), ofType: oftype!)
        
        cell.imageView.image = UIImage(contentsOfFile: imageBundle!)
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
