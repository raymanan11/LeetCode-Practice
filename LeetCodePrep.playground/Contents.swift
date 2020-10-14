class Solution {
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int: Int]()
        var arr: [Int] = []
        
        // add all of the numbers in a dictionary
        for (index, num) in nums.enumerated() {
            dict[num] = index
        }
        
        // go through whole array and because trget - num gets the second number that when added with num gets the target,
        // check if that number is in the dictionary and if it is and is not the same array index return that array of indexes
        for (index, num) in nums.enumerated() {
            let indexTwo = target - num
            if let indexTwoFound = dict[indexTwo] {
                if index == indexTwoFound {
                    continue
                }
                arr.append(index)
                arr.append(indexTwoFound)
                break
            }
        }
        return arr
    }
    
//    func maxProfit(_ prices: [Int]) -> Int {
//        var maxProfit = 0;
//        for i in 0..<prices.count - 1 {
//            for j in i + 1..<prices.count {
//                let profit = prices[j] - prices[i]
//                if profit > maxProfit {
//                    maxProfit = profit
//                }
//            }
//        }
//        return maxProfit;
//    }
    
    func maxProfit(_ prices: [Int]) -> Int {
        if prices.isEmpty {
            return 0
        }
        
        var maxProfit = 0;
        var smallestStockPrice = prices[0]
        
        for price in prices {
            if price < smallestStockPrice {
                smallestStockPrice = price
            }
            else if price - smallestStockPrice > maxProfit {
                maxProfit = price - smallestStockPrice
            }
        }
        return maxProfit
    }
    
    func containsDuplicate(_ nums: [Int]) -> Bool {
        
        if nums.isEmpty { return false }
        
        var dict = [Int:Bool]()
        for num in nums {
            // if you check the dictionary and the num exists it the dictionary, that means it has already been added meaning duplicate
            if dict[num] != nil {
                return true
            }
            // if it's not in the dictionary then you add it
            else {
                dict[num] = false
            }
        }
        return false
    }

}

var solution = Solution()
var arr = [1,2,3,1]
solution.containsDuplicate(arr)

