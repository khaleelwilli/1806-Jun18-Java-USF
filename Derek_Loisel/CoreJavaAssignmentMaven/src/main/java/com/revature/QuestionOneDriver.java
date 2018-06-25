package com.revature;

public class QuestionOneDriver {

	// Q1. Perform a bubble sort on the following integer array:  1,0,5,6,3,2,3,7,9,8,4
	
	public static void main(String[] args) {
		
		//create the array to sort
		int[] myNumArray = new int[] {1, 0, 5, 6, 3, 2, 3, 7, 9, 8, 4};
		
		//run the sorting method on the array
		myNumArray = (bubbleSort(myNumArray));
		
		//print the sorted array
		for (int num : myNumArray)
		{
			System.out.println(num);
		}
	}
		
	public static int[] bubbleSort(int[] numArray) {
		
	    int temp;

	    //loop through the length of the numArray
	    for (int i = 0; i < numArray.length; i++) {
	    	//loop through the numArray one iteration ahead to compare it with the previous index
	        for (int j = 1; j < (numArray.length); j++) {
	        	//check if the previous index is greater than the current
	            if (numArray[j - 1] > numArray[j]) {
	            	//if previous iteration is greater, you want to swap the values.  Set a temp var to hold that value
	                temp = numArray[j - 1];
	                //set the previous index's value equal to the current index's value
	                numArray[j - 1] = numArray[j];
	                //set the current index's value equal to the temp vars value
	                numArray[j] = temp;
	            }

	        }
	    }
	    
	    return numArray;
	}
	
	
}
