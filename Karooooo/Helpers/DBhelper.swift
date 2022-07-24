//
//  DBhelper.swift
//  Karooooo
//
//  Created by Sachin on 24/07/22.
//

import Foundation
import SQLite3

class DBHelper{
    
    init(){
        db = openDatabase()
        createTable()
    }

    let dbPath: String = "Karooooo.sqlite"
    var db:OpaquePointer?

    func openDatabase() -> OpaquePointer?{
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK{
            print("error opening database")
            return nil
        }else{
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS person(Id INTEGER PRIMARY KEY,username TEXT,password TEXT,country TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK{
            if sqlite3_step(createTableStatement) == SQLITE_DONE{
                print("person table created.")
            } else {
                print("person table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    func insert(id:Int, username:String, password:String, country:String){
        let persons = read()
        for p in persons{
            if p.id == id{
                return
            }
        }
        let insertStatementString = "INSERT INTO person (Id, username, password, country) VALUES (NULL, ?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_text(insertStatement, 1, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 2, (password as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (country as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    func read() -> [Person] {
        let queryStatementString = "SELECT * FROM person;"
        var queryStatement: OpaquePointer? = nil
        var psns : [Person] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id       = sqlite3_column_int(queryStatement, 0)
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let country  = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                
                psns.append(Person(id: Int(id), username: username, password: password, country: country))
                print("Query Result:")
                print("\(id) | \(username) | \(password) | \(country)")
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return psns
    }
    
//    func deleteByID(id:Int) {
//        let deleteStatementStirng = "DELETE FROM person WHERE Id = ?;"
//        var deleteStatement: OpaquePointer? = nil
//        if sqlite3_prepare_v2(db, deleteStatementStirng, -1, &deleteStatement, nil) == SQLITE_OK {
//            sqlite3_bind_int(deleteStatement, 1, Int32(id))
//            if sqlite3_step(deleteStatement) == SQLITE_DONE {
//                print("Successfully deleted row.")
//            } else {
//                print("Could not delete row.")
//            }
//        } else {
//            print("DELETE statement could not be prepared")
//        }
//        sqlite3_finalize(deleteStatement)
//    }
    
}
