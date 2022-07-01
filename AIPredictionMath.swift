func getConfidenceAccuracyCellData(prices: [Double], predictedPrices: [Double]) -> (Double, Double, Double) {

    var successesAt50 = 0.0
    var successesAt60 = 0.0
    var successesAt65 = 0.0
    
    var totalAt50 = 0.0
    var totalAt60 = 0.0
    var totalAt65 = 0.0
    
    var accuracyAt50Percent: Double = 0.0
    var accuracyAt60Percent: Double = 0.0
    var accuracyAt65Percent: Double = 0.0
    
    for (i,price) in prices.enumerated() {
        if prices.get(index: i+1) != nil {
            let confidence = 0.5*predictedPrices[i]/price
            if price > prices[i+1] && confidence <= 0.5 {
                successesAt50+=1
                if confidence <= 0.4 {
                  successesAt60+=1
                }
                if confidence <= 0.35 {
                  successesAt65+=1
                }
            }
            else if price < prices[i+1] && confidence >= 0.5 {
                successesAt50+=1
                if confidence >= 0.6 {
                  successesAt60+=1
                }
                if confidence >= 0.65 {
                  successesAt65+=1
                }
            }
            
            if confidence <= 0.4 || confidence >= 0.6 {
              totalAt60+=1
            }
            if confidence <= 0.35 || confidence >= 0.65 {
              totalAt65+=1
            }
            
            totalAt50+=1
        }
    }
    
    accuracyAt50Percent = Double(round(1000*successesAt50/totalAt50)/10)
    accuracyAt60Percent = Double(round(1000*successesAt60/totalAt60)/10)
    accuracyAt65Percent = Double(round(1000*successesAt65/totalAt65)/10)
    
    return (accuracyAt50Percent, accuracyAt60Percent, accuracyAt65Percent)
}
