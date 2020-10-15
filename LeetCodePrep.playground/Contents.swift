class Solution {
    
//    Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
//    You may assume that each input would have exactly one solution, and you may not use the same element twice.
//    You can return the answer in any order.
    
//    Input: nums = [2,7,11,15], target = 9
//    Output: [0,1]
    
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

//    Say you have an array for which the ith element is the price of a given stock on day i.
//    If you were only permitted to complete at most one transaction (i.e., buy one and sell one share of the stock), design an algorithm to find the maximum profit.
    
//    Input: [7,1,5,3,6,4]
//    Output: 5
//    Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
//                 Not 7-1 = 6, as selling price needs to be larger than buying price.
    
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
    
//    Given an array of integers, find if the array contains any duplicates.
//    Your function should return true if any value appears at least twice in the array, and it should return false if every element is distinct.
    
//    Input: [1,2,3,1]
//    Output: true
    
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
    
//    Given an array nums of n integers where n > 1,  return an array output such that output[i] is equal to the product of all the elements of nums except nums[i].
    
//    Input:  [4,5,1,8,2]
//    Output: [80,64,320,40,160]
    
    func productExceptSelf(_ nums: [Int]) -> [Int] {
            
        var leftSideTotalMultiplacation = [Int]()
        var rightSideTotalMultiplication = [Int]()
        var resultsArr = [Int]()
        
        for index in 0..<nums.count {
            rightSideTotalMultiplication.append(0)
        }
        
        leftSideTotalMultiplacation.append(1)
        for index in 1..<nums.count {
            leftSideTotalMultiplacation.append(nums[index - 1] * leftSideTotalMultiplacation[index - 1])
        }

        rightSideTotalMultiplication[nums.count - 1] = 1
        for index in stride(from: nums.count - 2, through: 0, by: -1) {
            rightSideTotalMultiplication[index] = nums[index + 1] * rightSideTotalMultiplication[index + 1]
        }

        for index in 0..<nums.count {
            resultsArr.append(leftSideTotalMultiplacation[index] * rightSideTotalMultiplication[index])
        }
        return resultsArr
        
    }

}

var solution = Solution()
var arr = [4,5,1,8,2]
solution.productExceptSelf(arr)


