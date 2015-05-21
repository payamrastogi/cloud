package com.cloudproject.main;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.Scanner;

public class TwitterData {
	public static void main(String[] args) throws FileNotFoundException {
		File input = new File(
				"/Users/payamrastogi/s3/");
		File[] files = input.listFiles();
		for (File file : files) {
			File outputFile = new File("/Users/payamrastogi/output/"+file.getName());
			PrintWriter writer = new PrintWriter(outputFile);
			Scanner fileScanner = new Scanner(file);
			StringBuffer sb = new StringBuffer();
			while (fileScanner.hasNextLine()) {
				String line = fileScanner.nextLine();
				if(line.contains("2015-04")||line.contains("2015-05")){
				    if(sb.length()!=0){
				    	writer.println(sb.toString().trim().replaceAll("\n"," "));
				    	sb.setLength(0);
				    }
				}
				sb.append(line);
			}
			writer.flush();
			writer.close();
			fileScanner.close();
		}
	}
}