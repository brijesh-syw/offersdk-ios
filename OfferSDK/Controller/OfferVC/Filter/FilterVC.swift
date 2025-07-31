//
//  FilterVC.swift
//  OfferSDK
//
//  Created by Rashiya, Brijesh (Contractor) on 11/07/24.
//

import UIKit

class FilterVC: UIViewController {
    
    //MARK: - Variables
    var arrData : [CellModel] = []
    
    //MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnApply: UIButton!
    
    //MARK: - VIew's Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FilterCell", bundle: getCurrentBundle(self)), forCellReuseIdentifier: "FilterCell")

        getSetupData()
    }
    
    func getSetupData() {
        arrData.append(CellModel.getModel(text: "Available Offers", type: CellType.FilterAvailable, isSelected: false))
        arrData.append(CellModel.getModel(text: "Redeemed Offers", type: CellType.FilterAvailable, isSelected: false))
        arrData.append(CellModel.getModel(text: "Expired Offers", type: CellType.FilterAvailable, isSelected: false))
        
        tableView.reloadData()
        
    }

    //MARK: - IBActions
    @IBAction func btnClose_Click(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func btnApply_Clicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: {
            //
            print("Filter Apply")
        })
    }
    
    @IBAction func btnCancel_Clicked(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}

extension FilterVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        arrData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell") as? FilterCell
        cell?.setData(model: arrData[indexPath.row])
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        arrData[indexPath.row].isSelected = !arrData[indexPath.row].isSelected
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
}
