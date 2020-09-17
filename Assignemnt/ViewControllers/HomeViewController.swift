//
//  HomeViewController.swift
//  Assignemnt
//
//  Created by Adees Farakh on 17.09.20.
//  Copyright © 2020 AdiAtizaz. All rights reserved.
//

import UIKit
import NVActivityIndicatorView



class HomeViewController: UIViewController, NVActivityIndicatorViewable {
    
    @IBOutlet var txtSearch: UITextField!
    @IBOutlet var collectionView: UICollectionView!
    var delegate  = HomeController()
    var bookList = Array<Book>()
    var copyBookList = Array<Book>()
    var bookToBeSent = Book.init(nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureData()
        // Do any additional setup after loading the view.
    }
    
    func configureData(){
        self.startAnimating(type: .ballScaleMultiple, color: .systemRed)
        self.delegate.handleVolumesRequest(delegate: self)
    }
    
    func getBooks(resultDictionary: Dictionary<String,Any>){
        if let books = resultDictionary["items"] as? Array<Dictionary<String,Any>>{
            self.bookList.removeAll()
            self.copyBookList.removeAll()
            for case let book in books{
                self.bookList.append(Book.init(book))
            }
            DispatchQueue.main.async {
                self.copyBookList = self.bookList
                self.collectionView.reloadData()
            }
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? BookDetailViewController{
            vc.book = self.bookToBeSent
        }
    }
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let imageHeight =  CGFloat(200)
        let margins = CGFloat(50)
        return CGSize.init(width: self.collectionView.frame.width, height: CGFloat(0).estimatedHeightOfLabel(text: bookList[indexPath.item].desc, width: view.frame.width - 40) + margins + imageHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bookList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: String(describing: HomeCollectionViewCell.self),
            for: indexPath) as? HomeCollectionViewCell else {
                preconditionFailure("Invalid cell type")
        }
        cell.populateData(book: bookList[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.bookToBeSent = bookList[indexPath.item]
        self.performSegue(withIdentifier: String(describing: BookDetailViewController.self), sender: self)
    }
    
}
extension HomeViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        self.searchBooks(textField: textField)
        return true
    }
    
    func searchBooks(textField : UITextField){
        if textField.text!.count > 0 {
            let filteredBooks = copyBookList.filter { word in
                let isMatchingTitle : String = word.desc.lowercased()
                 
                let rangeForTitle = isMatchingTitle.lowercased().range(of:textField.text!.lowercased(), options: .caseInsensitive, range: nil,   locale: nil)
                    return (rangeForTitle != nil)
                 
            
            }
            self.bookList = filteredBooks
        }else{
            self.bookList = self.copyBookList
        }
        self.collectionView.reloadData()
    }
    
}
extension HomeViewController: NetworkOperationHandler {
    
    func onSuccess(data: Data, response: URLResponse, tag: Int) {
        do {
            
            
            let resultDictionary = try JSONSerialization.jsonObject(with: data, options: [])
            print("home api: ", resultDictionary)
            
            if(tag == ServiceTag.books.rawValue) {
                
                let resultDictionary = try JSONSerialization.jsonObject(with: data, options: [])
                print("home api: ", resultDictionary)
                if let response = resultDictionary as? Dictionary<String, Any>{
                    getBooks(resultDictionary: response)
                }
                
                self.stopAnimating()
            }
            
            
            
            
        } catch {
            showOnFailure(message: NSLocalizedString("SOMETHING_WRONG_ERROR_PROMPT", comment: ""))
        }
    }
    
    
    
    func onFailure(data: Data, tag: Int) {
        do {
            let jsonDecoder = JSONDecoder()
            let networkResponse = try jsonDecoder.decode(NetworkError.self, from: data)
            if let message = networkResponse.message {
                showOnFailure(message: message)
            } else {
                showOnFailure(message: NSLocalizedString("SOMETHING_WRONG_ERROR_PROMPT", comment: ""))
            }
        } catch {
            showOnFailure(message: NSLocalizedString("SOMETHING_WRONG_ERROR_PROMPT", comment: ""))
        }
    }
    
    func showOnFailure(message: String) {
        DispatchQueue.main.async {
            self.stopAnimating()
            
            
        }
    }
    
}
