//
//  MyAccountHeader.swift
//  E-commerce
//
//  Created by YE on 2017/8/3.
//  Copyright © 2017年 Eter. All rights reserved.
//

import UIKit
import Charts
class MyAccountHeader: UIView
{

    var account: MyAccountModel? {
        didSet { updateUI() }
    }
    
    @IBOutlet var red: UIView!
    @IBOutlet var yellow: UIView!
    @IBOutlet var green: UIView!
    @IBOutlet var blue: UIView!
    
    @IBOutlet var displayAllMoney: UILabel!
    @IBOutlet var displayCurrentMonth: UILabel!
    @IBOutlet var displayNotSettleAccount: UILabel!
    @IBOutlet var displayLastMonth: UILabel!
    @IBOutlet var displayLastMonthNotSettleAccount: UILabel!
    @IBOutlet var pieChartView: PieChartView!
    
    fileprivate func updateUI() {
        
        if account == nil { return }
        
        if Thread.isMainThread {
            
            displayAllMoney.text = "\(account!.total_amount)元"
            displayCurrentMonth.text = account?.total_monthly_income
            displayNotSettleAccount.text = account?.unsettled_monthly_income
            displayLastMonth.text = account?.last_month_settlement
            displayLastMonthNotSettleAccount.text = account?.last_monthly_unsettled
            pieChartView.data = data()

        }
        else {
            DispatchQueue.main.async {
                self.displayAllMoney.text = "\(self.account!.total_amount)元"
                self.displayCurrentMonth.text = self.account?.total_monthly_income
                self.displayNotSettleAccount.text = self.account?.unsettled_monthly_income
                self.displayLastMonth.text = self.account?.last_month_settlement
                self.displayLastMonthNotSettleAccount.text = self.account?.last_monthly_unsettled
                self.pieChartView.data = self.data()

            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        pieChartView.legend.enabled = false
        
        pieChartView.backgroundColor = UIColor.white
        pieChartView.usePercentValuesEnabled = true
        pieChartView.drawSlicesUnderHoleEnabled = false
        pieChartView.holeRadiusPercent = 0.5
        pieChartView.transparentCircleRadiusPercent = 0.52
        pieChartView.chartDescription?.enabled = false
        
        pieChartView.drawCenterTextEnabled = false

        pieChartView.drawHoleEnabled = true
        pieChartView.rotationAngle = 0
        pieChartView.rotationEnabled = true
        pieChartView.highlightPerTapEnabled = true
        
        let l = pieChartView.legend
        l.horizontalAlignment = .right
        l.verticalAlignment = .top
        l.orientation = .vertical
        l.drawInside = true
        l.xEntrySpace = 7
        l.yEntrySpace = 0
        l.yOffset = 0
        
        pieChartView.highlightValues(nil)
    }
    
    func data() -> PieChartData {
        
        let yVals = [BarChartDataEntry(x: 0, y: account!.total_monthly_income.toDouble() == nil ? 0 : account!.total_monthly_income.toDouble()!),
                     BarChartDataEntry(x: 1, y: account!.unsettled_monthly_income.toDouble()!),
                     BarChartDataEntry(x: 2, y: account!.last_month_settlement.toDouble()!),
                     BarChartDataEntry(x: 3, y: account!.last_monthly_unsettled.toDouble()!)]
        
        let dataSet = PieChartDataSet(values: yVals, label: nil)
        dataSet.drawValuesEnabled = false
        dataSet.colors = [red.backgroundColor!,yellow.backgroundColor!,green.backgroundColor!,blue.backgroundColor!]
        dataSet.sliceSpace = 0
        dataSet.selectionShift = 8
        

        let data = PieChartData(dataSets: [dataSet])
        
        return data
    }
    
}
