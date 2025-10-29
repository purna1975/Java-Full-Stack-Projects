package com.tap.encrypt_decrypt;

public class MyEncrypt {

	public static String encrypt(String str) {		
		StringBuffer sb=new StringBuffer();	
		for(int i=0;i<str.length();i++) {
				//char c=name.charAt(i);
				//int x=c;
				//x=x+2;
				//c=(char)x;
				//sb.append(c);				
				sb.append((char)(str.charAt(i)+2));
			}
			return sb.toString();
		}	
}