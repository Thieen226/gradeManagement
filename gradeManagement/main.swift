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
var totalGrades : Double = 0
var averageGrade : Double = 0.0
var studentNames : [String] = []
var allGrades : [String] = []
var numOfAssignment : Double = 0.0
var displayMenu = true
var namesAndAverage = [String:Double]()

//when displayMenu is true, keeps showing the menu options
while displayMenu{
    print("Welcome to the Grade Manager! \n"
        + "What would you like to do? (Enter the number): \n"
        + "1. Display grade of a single student \n"
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
            displayStudentGrades(showAverage: true)

        case "2":
            displayStudentGrades(showAverage: false)
            
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
            
            //when the user choose option 9, stop showing menu options
            displayMenu = false
            
        default:
            print("Enter a appropriate option!")
            displayMenu = true
        }
    }
}

//making a function with parameter showAverage to separate case 1 and 2
func displayStudentGrades(showAverage: Bool){
    print("Which student would you like to choose?")
    
    if let studentChosen = readLine(){
        
        //use for loop to access names of students inside the 2d array
        for names in studentNamesAndGrades.indices{
            
            //check if the student's name input match the student's name in the 2d array
            //make sure if the user enter lower case names, they are still able to get the correct names
            if studentChosen.lowercased() == studentNamesAndGrades[names][0].lowercased(){
                
                //reset variables for each student
                totalGrades = 0
                numOfAssignment = 0
                allGrades = []
                
                //use for loop to access the student's grades
                for grades in 1..<studentNamesAndGrades[names].count{
                    
                    //create a variable that stores all the grades of the student
                    if let studentGrades = Double(studentNamesAndGrades[names][grades]){
                        //add each grade together
                        totalGrades += studentGrades
                        
                        //this variable keeps track the num of assignemnts
                        //when the for loop goes through each grade, then add 1 to the variable
                        numOfAssignment += 1
                        
                        //append all the grades into the array
                        allGrades.append(studentNamesAndGrades[names][grades])
                    }
                }
                averageGrade = totalGrades/numOfAssignment
                
                //create a variable to store all the grades of a student
                //then convert the array into a string and separate each grade with ,
                let showAllGrades = allGrades.joined(separator: ", ")
                
                if showAverage{
                    print("\(studentChosen)'s grade in the class is \(averageGrade)")
                }
                else{
                    print("\(studentChosen.capitalized)'s grades in this class are: \n"
                          + "\(showAllGrades)")
                }
                return
            }
        }
        print("Student not found!")
    }
}


func allGradesOfAllStudents(){
    //use for loop to access each name and grade
    for names in studentNamesAndGrades.indices{
        let allNames = studentNamesAndGrades[names][0]
        //store the names and grades in a sentence
        let allGrades = studentNamesAndGrades[names][1...].joined(separator: ", ")
        print("\(allNames) grades are: \(allGrades)")
    }
}

func averageGradeOfClass(){
    //reset variable for each student
    totalGrades = 0
    //create variable to keep track num of assn
    //since when I print the totalNumOfAssignments, it's missing 1 assignment so I set it at 1.0
    var totalNumOfAssignments : Double = 1.0
    //use for loop to access the names
    //use second for loop to access the grades
    for names in studentNamesAndGrades.indices{
        for grades in 1..<studentNamesAndGrades[names].count{
            //create a variable to store all the grades
            if let studentGrades = Int(studentNamesAndGrades[names][grades]){
                //add all the grades together
                totalGrades += Double(studentGrades)
                totalNumOfAssignments += 1
            }
        }
    }
    //create a variable to count all the students in the class
    let averageClassGrade = totalGrades/totalNumOfAssignments
    print("The class average is: " + String(format: "%.2f", averageClassGrade))
}

func averageOfAnAssignment(){
    print("Which assignment would you like to get the average of (1-10)")
    if let userInput = readLine(), let assignmentNumber = Int(userInput), assignmentNumber > 0, assignmentNumber < 11{
        totalGrades = 0
        numOfAssignment = 0
        averageGrade = 0
        for grades in studentNamesAndGrades.indices{
            let assignmentIndex = studentNamesAndGrades[grades][assignmentNumber]
            totalGrades += Double(assignmentIndex)!
            numOfAssignment += 1
        }
        let averageAssignment = totalGrades/numOfAssignment
        print("The average for assignment #\(userInput) is " + String(format: "%.2f", (averageAssignment)))
    }
    else{
        print("Please enter a correct assignment number!")
    }
}

func calculateAverage() -> [String:Double]{
    for names in studentNamesAndGrades.indices{
        totalGrades = 0
        numOfAssignment = 0
        averageGrade = 0.0
        for grade in 1..<studentNamesAndGrades[names].count{
            if let studentGrades = Double(studentNamesAndGrades[names][grade]){
                totalGrades += studentGrades
                numOfAssignment += 1
                averageGrade = totalGrades/Double(numOfAssignment)
            }
        }
        namesAndAverage[studentNamesAndGrades[names][0]] = averageGrade
    }
    return namesAndAverage
}


func lowestGradeOfClass(){
    let ave = calculateAverage()
   if let studentsWithLowest = ave.min(by: {$0.value < $1.value}){
        print("\(studentsWithLowest.key) is the student with the lowest grade: \(studentsWithLowest.value)")
    }
}

func highestGradeOfClass(){
    let ave = calculateAverage()
    if let studentsWithLowest = ave.max(by: {$0.value < $1.value}){
        print("\(studentsWithLowest.key) is the student with the highest grade: \(studentsWithLowest.value)")
    }
}

func filterByRange(){
    let ave = calculateAverage()
    print("Enter the low range you would like to use: ")
    if let lowRangeInput = readLine(), let lowRange = Double(lowRangeInput){
        
        print("Enter the high range you would like to use: ")
        if let highRangeInput = readLine(), let highRange = Double(highRangeInput){
            
            let studentGradesRange = ave.filter({$0.value > lowRange && $0.value < highRange})
            for students in studentGradesRange{
                print("\(students.key): \(students.value)")
            }
        }
        else{
            print("Enter a number!")
        }
    }
    else{
        print("Enter a number!")
    }

}


