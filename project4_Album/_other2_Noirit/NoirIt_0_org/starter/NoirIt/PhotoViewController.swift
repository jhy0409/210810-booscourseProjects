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
import PhotosUI

class PhotoViewController: UIViewController {
  @IBOutlet weak var imageView: UIImageView!

  @IBOutlet weak var toolbar: UIToolbar!

  @IBOutlet weak var favoriteButton: UIBarButtonItem!
  @IBAction func favoriteTapped(_ sender: Any) { toggleFavorite() }

  @IBOutlet weak var saveButton: UIBarButtonItem!
  @IBAction func saveTapped(_ sender: Any) { saveImage() }

  @IBOutlet weak var undoButton: UIBarButtonItem!
  @IBAction func undoTapped(_ sender: Any) { undo() }

  @IBAction func applyFilterTapped(_ sender: Any) { applyFilter() }

  var asset: PHAsset

  required init?(coder: NSCoder) {
    fatalError("init(coder:) not implemented")
  }

  init?(asset: PHAsset, coder: NSCoder) {
    self.asset = asset
    super.init(coder: coder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    getPhoto()
    updateFavoriteButton()
    updateUndoButton()
    saveButton.isEnabled = false
  }

  func updateFavoriteButton() {}

  func updateUndoButton() {}

  func toggleFavorite() {}

  func applyFilter() {}

  func saveImage() {}

  func undo() {}

  func getPhoto() {
    imageView.fetchImageAsset(asset, targetSize: view.bounds.size, completionHandler: nil)
  }
}
