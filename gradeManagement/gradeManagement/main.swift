//
//  main.swift
//  gradeManagement
//
//  Created by StudentAM on 1/26/24.
//

import Foundation

import CSV

do{
    //input stream to get data from the grades.csv file
    let stream = InputStream(fileAtPath: "/Users/studentam/Desktop/grades.csv")
    
    //creating a variable to grab the data from stream variable
    let csv = try CSVReader(stream: stream!)
    
    //as long as there is a row, the while loop will grab the data from the stream
    while let row = csv.next(){
        print(row)
    }
}
catch{
    print("There was an error trrying to read the file!")
}



