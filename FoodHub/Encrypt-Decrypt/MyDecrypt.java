package com.tap.encrypt_decrypt;

public class MyDecrypt {

	public static String decrypt(String name) {		
		StringBuffer sb=new StringBuffer();	
		for(int i=0;i<name.length();i++) {
				//char c=name.charAt(i);
				//int x=c;
				//x=x-2;
				//c=(char)x;
				//sb.append(c);				
				sb.append((char)(name.charAt(i)-2));
			}
			return sb.toString();
		}
}