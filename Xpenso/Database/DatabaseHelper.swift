//
//  DatabaseHelper.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation
import SQLite

class DatabaseHelper {
    
    static let shared = DatabaseHelper()
    var database : Connection?
    private init() {}

    
    private func getSQLiteURL() -> URL? {
        // Get the Application Support directory URL
        let fileManager = FileManager.default
        do {
            let appSupportDir = try fileManager.url(for: .applicationSupportDirectory,
                                                     in: .userDomainMask,
                                                     appropriateFor: nil,
                                                     create: true)
            
            // Append the SQLite filename to the Application Support directory URL
            let sqliteFilename = "Xpenso.sqlite"
            let sqliteURL = appSupportDir.appendingPathComponent(sqliteFilename)
            
            return sqliteURL
            
        } catch {
            print("Error: \(error)")
            return nil
        }
    }

    func createOrUseExistingSQLiteFile() {
        guard let sqliteURL = getSQLiteURL() else {
            print("Failed to get SQLite file URL.")
            return
        }
        
        let fileManager = FileManager.default
        
        // Check if SQLite file already exists
        if !fileManager.fileExists(atPath: sqliteURL.path) {
            // Create an empty SQLite file if it doesn't exist
            let success = fileManager.createFile(atPath: sqliteURL.path, contents: nil, attributes: nil)
            
            
            
        
            
            if success {
                print("SQLite file created successfully at: \(sqliteURL.absoluteString.removingPercentEncoding ?? "")")
                
                connectToDatabase(urlString: sqliteURL.absoluteString)
                createTables()
                
            } else {
                print("Failed to create SQLite file.")
            }
        } else {
            print("Using existing SQLite file at: \(sqliteURL.absoluteString.removingPercentEncoding ?? "")")
            connectToDatabase(urlString: sqliteURL.absoluteString)
            //add migration cheeck if any
        }
    }
    
    func connectToDatabase(urlString: String) {
        do {
            database = try Connection(urlString)
            Logger.log(.info, "Database Connection Succeeded")
        }
        catch {
            Logger.log(.fault, "Database Connection Failed")
        }
    }

    func createTables() {
        createUsersTable()
    }
    
    private func createUsersTable() {
        

        do {
            guard let database else {
                Logger.log(.info, "Database Connection found to be nil.")
                return
            }
            try database.run(ExpenseDB.users.create { t in
                t.column(ExpenseDB.id, primaryKey: true)
                t.column(ExpenseDB.amount)
                t.column(ExpenseDB.description)
                t.column(ExpenseDB.date)
                t.column(ExpenseDB.category)
            })
            

        }
        catch {
            Logger.log(.error, "Error Creating Users Table")
        }
    }
    
    func getDatabaseInstance() -> Connection?{
        return database
    }
}
