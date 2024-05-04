//
//  DatabaseHandler.swift
//  Xpenso
//
//  Created by Arkaprava Ghosh on 05/05/24.
//

import Foundation

class DatabaseHelper {

    static func getSQLiteURL() -> URL? {
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

    static func createOrUseExistingSQLiteFile() {
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
                print("SQLite file created successfully at:")
                print(sqliteURL.absoluteString)
            } else {
                print("Failed to create SQLite file.")
            }
        } else {
            // SQLite file already exists, just use it
            print("Using existing SQLite file at:")
            print(sqliteURL)
        }
    }

    // Call the function to create or use the existing SQLite file

}
