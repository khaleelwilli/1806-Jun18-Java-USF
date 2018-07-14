package com.revature;

import com.revature.models.Alpha;
import com.revature.models.Beta;

public class OopDriver {

	public static void main(String[] args) {
		
		Alpha alpha = new Alpha();
		System.out.println(alpha.myPublicInt);
		
		Beta beta = new Beta();
		System.out.println(beta.myPublicInt);
		System.out.println(beta.shadowGetter());
		
		//covariance
		Alpha obj = new Beta();
		System.out.println(obj.myPublicInt);
		
		
		
	}
	
}