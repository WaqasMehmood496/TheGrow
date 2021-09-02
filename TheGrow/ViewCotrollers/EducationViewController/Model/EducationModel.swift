//
//  EducationModel.swift
//  TheGrow
//
//  Created by Adeel on 07/10/2020.
//  Copyright © 2020 Buzzware. All rights reserved.
//

import UIKit

class EducationModel: NSObject,NSCoding {
    
    var exercise_id = ""
    var title = ""
    var descriptions = ""
    var image_url = ""
    var duration = ""
    var type = ""
    var media_file = ""
    var inserted_date = ""
    
    
    override init(){
        exercise_id = ""
        title = ""
        descriptions = ""
        image_url = ""
        duration = ""
        type = ""
        media_file = ""
        inserted_date = ""
        
    }
    init(exercise_id: String, title: String, descriptions: String, duration: String, type: String, media_file: String, image_url: String, inserted_date: String) {
        self.exercise_id = exercise_id
        self.title = title
        self.descriptions = descriptions
        self.image_url = image_url
        self.duration = duration
        self.type = type
        self.media_file = media_file
        self.inserted_date = inserted_date
        
        
    }
    init(Data:ExerciseModel){
        exercise_id = Data.exercise_id
        title = Data.title
        descriptions = Data.descriptions
        image_url = Data.image_url
        duration = Data.duration
        type = Data.type
        media_file = Data.media_file
        inserted_date = Data.inserted_date
        
    }
    
    required convenience init(coder aDecoder: NSCoder)
    {
        let obj = ExerciseModel()
        obj.exercise_id = aDecoder.decodeObject(forKey: "exercise_id") as? String ?? ""
        obj.title = aDecoder.decodeObject(forKey: "title") as? String ?? ""
        obj.descriptions = aDecoder.decodeObject(forKey: "description") as? String ?? ""
        obj.image_url = aDecoder.decodeObject(forKey: "image_url") as? String ?? ""
        obj.duration = aDecoder.decodeObject(forKey: "duration") as? String ?? ""
        obj.type = aDecoder.decodeObject(forKey: "type") as? String ?? ""
        obj.media_file = aDecoder.decodeObject(forKey: "media_file") as? String ?? ""
        obj.inserted_date = aDecoder.decodeObject(forKey: "inserted_date") as? String ?? ""
        
        self.init(Data:obj)
    }
    func encode(with aCoder: NSCoder)
    {
        aCoder.encode(self.exercise_id, forKey: "exercise_id")
        aCoder.encode(self.title, forKey: "title")
        aCoder.encode(self.descriptions, forKey: "description")
        aCoder.encode(self.image_url, forKey: "image_url")
        aCoder.encode(self.duration, forKey: "duration")
        aCoder.encode(self.type, forKey: "type")
        aCoder.encode(self.media_file, forKey: "media_file")
        aCoder.encode(self.inserted_date, forKey: "user_type")
        
        
    }
}
