//
//  dbManager.swift
//  IslamicMindMaps
//
//  Created by Faraz Ahmed on 19/04/2020.
//  Copyright © 2020 Faraz Ahmed. All rights reserved.
//

import Foundation
import SQLite

protocol dbManagerDelegate {
    func didUpdateData(chapterArray: [Chapter])
    
}


struct dbManager {
    
    
    var delegate:dbManagerDelegate?
    var chaptersArray:[Chapter]=[]
    
    mutating func dataFetch(){
        
        let id = Expression<Int64>("id")
        let romanName = Expression<String>("romanname")
        let arabicName = Expression<String>("arabicname")
        let totalVerses = Expression<Int64>("totalverses")
      
        if let databaseFilePath = Bundle.main.path(forResource: K.DB.name, ofType: K.DB.filetype){
            
            let db = try! Connection(databaseFilePath)
            let chapters = Table("chapter")
            
            for chapter in try! db.prepare(chapters) {
                let myChapter=Chapter(id:chapter[id],romanName:chapter[romanName],arabicName: chapter[arabicName],totalVerses:chapter[totalVerses])
                chaptersArray.append(myChapter)
                
            }
            self.delegate?.didUpdateData(chapterArray: chaptersArray)
        }
        else { print("Error finding DataBase")}
        
        }
    
    
}