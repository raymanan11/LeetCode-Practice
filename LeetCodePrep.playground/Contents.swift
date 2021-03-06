class Solution {
    
    //    Given an array of integers nums and an integer target, return indices of the two numbers such that they add up to target.
    //    You may assume that each input would have exactly one solution, and you may not use the same element twice.
    //    You can return the answer in any order.
    
    //    Input: nums = [2,7,11,15], target = 9
    //    Output: [0,1]
    
    //    Input: nums = [3,3], target = 6
    //    Output = [0,1]
    
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var dict = [Int:Int]()
        var resultArr = [Int]()
        
        // add all the numbers to a dictionary with numbers being key and index being value
        for (index, num) in nums.enumerated() {
            dict[num] = index
        }
        
        // for each number the other matching number would be target - number
        // so we check if that is is the dictionary and if it is then add those indexes into array
        // but if it's the same index just continue through array
        for (index, num) in nums.enumerated() {
            let otherNumber = target - num
            if let otherIndex = dict[otherNumber] {
                if index == otherIndex {
                    continue
                }
                resultArr.append(index)
                resultArr.append(otherIndex)
                break
            }
        }
        
        return resultArr
    }

    //    Say you have an array for which the ith element is the price of a given stock on day i.
    //    If you were only permitted to complete at most one transaction (i.e., buy one and sell one share of the stock), design an algorithm to find the maximum profit.
    
    //    Input: [7,1,5,3,6,4]
    //    Output: 5
    //    Explanation: Buy on day 2 (price = 1) and sell on day 5 (price = 6), profit = 6-1 = 5.
    //                 Not 7-1 = 6, as selling price needs to be larger than buying price.
    
    func maxProfit(_ prices: [Int]) -> Int {
        
        if prices.isEmpty { return 0 }
        
        var maxProfit = 0;
        
        var smallestPrice = prices[0]
        
        for price in prices {
            if price < smallestPrice {
                smallestPrice = price
            }
            else if price - smallestPrice > maxProfit {
                maxProfit = price - smallestPrice
            }
        }
        
        return maxProfit

    }
    
    //    Given an array of integers, find if the array contains any duplicates.
    //    Your function should return true if any value appears at least twice in the array, and it should return false if every element is distinct.
    
    //    Input: [1,2,3,1]
    //    Output: true
    
    func containsDuplicate(_ nums: [Int]) -> Bool {
        var dict = [Int:Int]()
        
        for (index, num) in nums.enumerated() {
            if dict[num] == nil {
                dict[num] = index
            }
            else {
                return true
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
 
    //    Input: [-2, 0, -1]
    //    Output: 0

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
    
    //    Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.
    //
    //    (i.e.,  [0,1,2,4,5,6,7] might become  [4,5,6,7,0,1,2]).
   
    //    Find the minimum element.

    //    Input: [3,4,5,1,2]
    //    Output: 1

    //    Input: [4,5,6,7,0,1,2]
    //    Output: 0
    
//    func findMin(_ nums: [Int]) -> Int {
//
//    }
    
    //    Given a sorted array nums, remove the duplicates in-place such that each element appears only once and returns the new length.
    //    Input: nums = [1,1,2]
    //    Output: 2, nums = [1,2]
    //    Explanation: Your function should return length = 2, with the first two elements of nums being 1 and 2 respectively. It doesn't matter what you leave beyond the returned length.
    
    //    Input: nums = [0,0,1,1,1,2,2,3,3,4]
    //    Output: 5, nums = [0,1,2,3,4]
    //    Explanation: Your function should returneeee length = 5, with the first five elements of nums being modified to 0, 1, 2, 3, and 4 respectively. It doesn't matter what values are set beyond the returned length.
    
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        
        if nums.isEmpty { return 0 }
        
        var i = 0
        
        for j in 1..<nums.count {
            // for second example, the first time it's not equal is when i = 0 and j = 2, nums[i] = 0 nums[j] = 1
            // you would then add 1 to i which makes i = 1 and put nums[j] into nums[i]
            if nums[i] != nums[j] {
                i+=1
                nums[i] = nums[j]
            }
        }
        
        return i + 1

    }
    
    //    Given an array, rotate the array to the right by k steps, where k is non-negative.

    //    Input: nums = [1,2,3,4,5,6,7], k = 3
    //    Output: [5,6,7,1,2,3,4]
    //    Explanation:
    //    rotate 1 steps to the right: [7,1,2,3,4,5,6]
    //    rotate 2 steps to the right: [6,7,1,2,3,4,5]
    //    rotate 3 steps to the right: [5,6,7,1,2,3,4]
    
    func rotate(_ nums: inout [Int], _ k: Int) {
        
        var dict = [Int:Int]()
        // add all of the indexes and numbers into the dictionary to keep track of original array position
        for (index, num) in nums.enumerated() {
            dict[index] = num
        }
        var numRot = k
        let numsLength = nums.count
        // dealing with rotations that are greater than the number of elements in the array
        // i.e. if the number of elements is 5 and asks for 7 rotations, its the same as 2 rotations
        // so no need to do extra rotations so just mod the numRot by count of elements to get actual rotations
        if k > nums.count {
            numRot = k % numsLength
        }
        for (index, _) in nums.enumerated() {
            // for the index, get number from original index
            if let num = dict[index] {
                let futureIndex = index + numRot
                nums[futureIndex % numsLength] = num
            }
        }
    }
    
    //    Given a non-empty array of integers nums, every element appears twice except for one. Find that single one.
    //
    //    Input: nums = [2,2,1]
    //    Output: 1

    //    Input: nums = [4,1,2,1,2]
    //    Output: 4
    
    func singleNumber(_ nums: [Int]) -> Int {
        
        var dict = [Int:Int]()
        
        for (index, num) in nums.enumerated() {
            if dict[num] == nil {
                dict[num] = index
            }
            else {
                dict.removeValue(forKey: num)
            }
        }
        
        return dict.first!.key
    }
    
    //    Given two arrays, write a function to compute their intersection.
    //
    //    Input: nums1 = [1,2,2,1], nums2 = [2,2]    Input: nums1 = [4,9,5], nums2 = [9,4,9,8,4]
    //    Output: [2,2]                              Output: [4,9]
    
//    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
//        var dict1 = [Int:Int]()
//        var dict2 = [Int:Int]()
//        var resultArr = [Int]()
//        for (index, num) in nums1.enumerated() {
//            dict1[num] = index
//        }
//
//        for (index, num) in nums2.enumerated() {
//            dict2[num] = index
//        }
//
//        if nums1.count > nums2.count {
//            for num in nums2 {
//                if dict1[num] != nil {
//
//                }
//            }
//        }
//        else {
//
//        }
//    }
    
    //    Given a non-empty array of digits representing a non-negative integer, increment one to the integer.
    //    The digits are stored such that the most significant digit is at the head of the list, and each element in the array contains a single digit.
    //    You may assume the integer does not contain any leading zero, except the number 0 itself.

    // [9,9,9]     [9]     [1,4,3,9]
    // [1,0,0,0]   [10]    [1,4,4,0]
    func plusOne(_ digits: [Int]) -> [Int] {
        var digitz = digits
        digitz[digits.count - 1] = digitz[digits.count - 1] + 1
    
        for index in stride(from: digitz.count - 1, through: 1, by: -1) {
            if digitz[index] == 10 {
                digitz[index] = 0
                digitz[index - 1] = digitz[index - 1] + 1
            }
        }
        
        if digitz[0] == 10 {
            digitz[0] = 0
            digitz.insert(1, at: 0)
        }
        
        
        return digitz
    }

    //    Suppose an array sorted in ascending order is rotated at some pivot unknown to you beforehand.
    //    (i.e.,  [0,1,2,4,5,6,7] might become  [4,5,6,7,0,1,2]).
    //    Find the minimum element.

    //    Input: [3,4,5,1,2]
    //    Output: 1
    
    func findMin(_ nums: [Int]) -> Int {
        var lowestValue = nums[0]
        
        for num in nums {
            if num < lowestValue {
                lowestValue = num
            }
        }
        return lowestValue
    }
    
    //  You are given an integer array nums sorted in ascending order, and an integer target.
    //  Suppose that nums is rotated at some pivot unknown to you beforehand (i.e., [0,1,2,4,5,6,7] might become [4,5,6,7,0,1,2]).
    //  If target is found in the array return its index, otherwise, return -1.

    //  Input: nums = [4,5,6,7,0,1,2], target = 0
    //  Output: 4

    //  Input: nums = [4,5,6,7,0,1,2], target = 3
    //  Output: -1

    func search(_ nums: [Int], _ target: Int) -> Int {
        var resultIndex = -1
        for (index, num) in nums.enumerated() {
            if num == target {
                resultIndex = index
                return resultIndex
            }
        }
        return resultIndex
    }
    
}

var solution = Solution()
var arr = [4,5,6,7,0,1,2]
var lowestValue = solution.search(arr, 3)
print(lowestValue)


