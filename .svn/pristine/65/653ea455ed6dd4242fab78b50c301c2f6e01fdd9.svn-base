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
        
        pieChartView.data = data()
        pieChartView.highlightValues(nil)
    }
    
    func data() -> PieChartData {
        
        let yVals = [BarChartDataEntry(x: 4666, y: 0),
                     BarChartDataEntry(x: 5000, y: 1),
                     BarChartDataEntry(x: 7666, y: 2),
                     BarChartDataEntry(x: 9666, y: 3)]
        
        
        let dataSet = PieChartDataSet(values: yVals, label: nil)
        dataSet.drawValuesEnabled = false
        dataSet.colors = [red.backgroundColor!,yellow.backgroundColor!,green.backgroundColor!,blue.backgroundColor!]
        dataSet.sliceSpace = 0
        dataSet.selectionShift = 8
        

        let data = PieChartData(dataSets: [dataSet])
        
        return data
    }
    
}
