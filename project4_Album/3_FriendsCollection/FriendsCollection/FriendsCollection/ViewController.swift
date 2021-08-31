//
//  ViewController.swift
//  FriendsCollection
//
//  Created by inooph on 2021/08/31.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource {
    var numberOfCell: Int = 10
    let cellIdentifier: String = "cell"
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.numberOfCell
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: self.cellIdentifier, for: indexPath)
        return cell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

