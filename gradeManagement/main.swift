//
//  main.swift
//  gradeManagement
//
//  Created by StudentAM on 1/26/24.
//

import Foundation

import CSV

var studentNamesAndGrades : [[String]] = []

do{
    //input stream to get data from the grades.csv file
    let stream = InputStream(fileAtPath: "/Users/studentam/Desktop/grades.csv")
    
    //creating a variable to grab the data from stream variable
    let csv = try CSVReader(stream: stream!)
    
    //as long as there is a row, the while loop will grab the data from the stream
    while let row = csv.next(){
        //append the data from grades.csv to 2d array
        studentNamesAndGrades.append(row)
    }
}
catch{
    print("There was an error trrying to read the file!")
}

//create variables
var allGrades : Int = 0
var avarageGrade : Double = 0.0
var lowestGrade : Int = 0
var highestGrade : Int = 0
var displayMenu = true

while displayMenu{
    print("1. Display grade of a single student \n"
        + "2. Display all grades for a student \n"
        + "3. Display all grades for ALL students \n"
        + "4. Find the average grade of the class \n"
        + "5. Find the average grade of an assignment \n"
        + "6. Find the lowest grade in the class \n"
        + "7. Find the highest grade of the class \n"
        + "8. Filter students by grade range \n"
        + "9. Quit")
    
    if let userInput = readLine(){
        switch userInput{
        case "1":
            gradeOfOneStudent()

        case "2":
            allGradesOfOneStudent()
            
        case "3":
            allGradesOfAllStudents()
            
        case "4":
            averageGradeOfClass()
            
        case "5":
            averageOfAnAssignment()
            
        case "6":
            lowestGradeOfClass()
            
        case "7":
            highestGradeOfClass()
            
        case "8":
            filterByRange()
            
        case "9":
            print("Have a great rest of your day!")
            displayMenu = false
            
        default:
            print("Enter a appropriate option!")
            displayMenu = true
        }
    }
}

func gradeOfOneStudent(){
    print("Which student would you like to choose?")
    
    if var studentChosen = readLine(){
        
        for i in studentNamesAndGrades.indices{
            for j in 1..<studentNamesAndGrades.count{
                if studentChosen == studentNamesAndGrades[i][0]{
                    studentNamesAndGrades[i]
                }
            }
        }
    }
}

func allGradesOfOneStudent(){
    
}

func allGradesOfAllStudents(){
    
}

func averageGradeOfClass(){
    
}

func averageOfAnAssignment(){
    
}

func lowestGradeOfClass(){
    
}

func highestGradeOfClass(){
    
}

func filterByRange(){
    
}


