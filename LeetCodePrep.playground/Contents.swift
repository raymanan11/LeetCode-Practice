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
    
//    Given an integer array nums, find the contiguous subarray (containing at least one number) which has the largest sum and return its sum.

//    Follow up: If you have figured out the O(n) solution, try coding another solution using the divide and conquer approach, which is more subtle.

//    Input: nums = [-2,1,-3,4,-1,2,1,-5,4]
//    Output: 6
//    Explanation: [4,-1,2,1] has the largest sum = 6.
    
//    Input: nums = [-2147483647]
//    Output: -2147483647
    
    func maxSubArray(_ nums: [Int]) -> Int {
        // set the max end to be the first element in array by default
        var max_end = nums[0]
        // set the max so far as the first element in array by default
        var max_so_far = nums[0]
        for index in 1..<nums.count {
            print("hi")
            // compares the current index against current index + max_end because it'll keep track of the largest one of the two
            max_end = max(nums[index], nums[index] + max_end)
            // this will keep track of the addition by checking the max between the current max or the max_end that was just connected
            max_so_far = max(max_so_far, max_end)
        }
        return max_so_far
    }
    
//    Given an integer array nums, find the contiguous subarray within an array (containing at least one number) which has the largest product.
    
//    Input: [2, 3, -2, 4]
//    Output: 6
//    Explanation: [2,3] has the largest product 6.
//
//    Input: [-2, 0, -1]
//    Output: 0
//    Explanation: The result cannot be 2, because [-2,-1] is not a subarray.
    // if nums[i] * max_end < 0 and nums[i + 1] < 0
    // max_end = nums[i] * max_end
//    Input: [-2, 3, -4]
//    Output: 24
    
//    Input: [3, -1, 4]
//    Output: 4
    
//    Input: [0, 2]
//    Output: 2
    
    func maxProduct(_ nums: [Int]) -> Int {
        var maximum = Int.min
        var product = 1
        let numsLength = nums.count
        
        for i in 0..<numsLength {
            product = product * nums[i]
            maximum = max(product, maximum)
            // if product becomes 0 for example array [10, 0,-1,6,-2] it will set product back to 1 after 0 iteration
            // so that product won't keep becoming 0 because product = product(0) * nums[i]
            if nums[i] == 0 {
                product = 1
            }
        }
        
        // reset the product to look from right side if there are an odd number of negative numbers
        // i.e. [-2, 5,3] first iteration (left to right) max will be -2 but next iteration max will be 15 because 3 * 5
        product = 1
        for num in nums.reversed() {
            product = product * num
            maximum = max(product, maximum)
            if num == 0 {
                product = 1
            }
        }
        
        return maximum
    }

}

var solution = Solution()
var arr = [-2, 5, 3, 4]
solution.maxProduct(arr)


