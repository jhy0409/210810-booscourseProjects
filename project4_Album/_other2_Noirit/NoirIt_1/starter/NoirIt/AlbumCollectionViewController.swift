/// Copyright (c) 2020 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import Photos

class AlbumCollectionViewController: UICollectionViewController {
  var sections: [AlbumCollectionSectionType] = [.all, .smartAlbums, .userCollections]

  override func viewDidLoad() {
    super.viewDidLoad()
    getPermissionIfNecessary { granted in
      guard granted else { return }
      self.fetchAssets()
      DispatchQueue.main.async {
        self.collectionView.reloadData()
      }
    }
  }

  @IBSegueAction func makePhotosCollectionViewController(_ coder: NSCoder) -> PhotosCollectionViewController? {
    return PhotosCollectionViewController(assets: PHFetchResult<PHAsset>(), title: "", coder: coder)
  }

  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      guard let headerView = collectionView.dequeueReusableSupplementaryView(
        ofKind: kind,
        withReuseIdentifier: AlbumCollectionReusableView.reuseIdentifier,
        for: indexPath) as? AlbumCollectionReusableView
        else {
        fatalError("Unable to dequeue AlbumCollectionReusableView")
      }
      headerView.title.text = sections[indexPath.section].description
      return headerView
    }
    return UICollectionReusableView()
  }

  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return sections.count
  }

  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(
      withReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier,
      for: indexPath) as? AlbumCollectionViewCell else {
      fatalError("Unable to dequeue AlbumCollectionViewCell")
    }
    return cell
  }

  func getPermissionIfNecessary(completionHandler: @escaping (Bool) -> Void) {
    completionHandler(false)
  }

  func fetchAssets() {}
}
