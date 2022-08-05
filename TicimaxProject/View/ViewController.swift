//
//  ViewController.swift
//  TicimaxProject
//
//  Created by Hasan Basri Öztürk on 3.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController, UIScrollViewDelegate{
    
    var tableView = UITableView()
    private let bag = DisposeBag()
    private let jokeViewModel = JokeViewModel()
    var selectedItemURL = ""
    
    var viewModel: ViewModelProtocol! {
           didSet {
               viewModel.delegate = self
           }
       }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        
        tableView = UITableView(frame: self.view.bounds, style: UITableView.Style.plain)
        view.addSubview(tableView)
        bindTableView()
        
    }
    
    
    private func bindTableView() {
        tableView.register(JokesTableViewCell.self, forCellReuseIdentifier: JokesTableViewCell.identifier)
        
           
        jokeViewModel.items.bind(to: tableView.rx.items(cellIdentifier: JokesTableViewCell.identifier, cellType: JokesTableViewCell.self)) { (row,item,cell) in
               cell.item = item
           }.disposed(by: bag)
           
           tableView.rx.modelSelected(Meme.self).subscribe(onNext: { item in
               print("SelectedItem: \(item.name)")
               self.selectedItemURL = item.url
               
               self.performSegue(withIdentifier: "goDetail", sender: nil)
               
               
           }).disposed(by: bag)
           
           jokeViewModel.fetchMemes()
       }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
           super.viewWillAppear(animated)
           viewModel.load()
       }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goDetail" {
            let destinationVC = segue.destination as! DetailViewController
            
            destinationVC.selectedItemURL = selectedItemURL
            
        }
    }
    
}
extension ViewController : ViewModelDelegate{
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}















