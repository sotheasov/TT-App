/*
This SDK is licensed under the MIT license (MIT)
Copyright (c) 2015- Applied Technologies Internet SAS (registration number B 403 261 258 - Trade and Companies Register of Bordeaux – France)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/





//
//  Event.swift
//  Tracker
//

import Foundation

public class Event: NSObject {
    
    var _data = [String : Any]()
    var data : [String : Any] {
        get {
            return self._data
        }
        set {
            self._data = newValue
        }
    }
    
    @objc public var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func getAdditionalEvents() -> [Event] {
        return [Event]()
    }
}

public class Events: BusinessObject {
    
    var eventLists: [Event] = [Event]()
    
    /**
     Add an event
     - parameter name: event type label
     - parameter data: event data content
     - returns: a new Event
     */
    @objc public func add(name: String, data: [String : Any]) -> Event {
        let ev = Event(name: name)
        ev._data = data
        return add(event: ev)
    }
    
    /**
     Add an event
     - parameter event: event instance
     - returns: the event instance added
     */
    @objc public func add(event: Event) -> Event {
        self.eventLists.append(event)
        self.tracker.businessObjects[id] = self
        return event
    }
    
    /**
     Send all stored events
     */
    @objc public func send() {
        self.tracker.dispatcher.dispatch([self])
    }
    
    override func setParams() {
        var eventsArr = [[String : Any]]()
        
        for e in self.eventLists {
            
            if e.data.count != 0 {
                eventsArr.append(["name" : e.name, "data" : Tool.toObject(src: e.data)])
            }
            
            let additionalEvents = e.getAdditionalEvents()
            
            for ev in additionalEvents {
                eventsArr.append(["name" : ev.name, "data" : Tool.toObject(src: ev.data)])
            }

        }
        self.eventLists.removeAll()
        
        let optEncode = ParamOption()
        optEncode.encode = true
        _ = self.tracker.setParam("events", value: Tool.JSONStringify(eventsArr, prettyPrinted: false), options: optEncode)
                        .setParam("col", value: "2")
        
        let pageContext = getPageContext()
        if pageContext.count != 0 {
            _ = self.tracker.setParam("context", value: Tool.JSONStringify([["data": pageContext]], prettyPrinted: false), options: optEncode)
        }
    }
    
    private func getPageContext() -> [String: Any] {
        var pageContext = [String: Any]()
        
        /// Page
        if let s = TechnicalContext.screenName {
            var pageObj = [String: Any]()
            let splt = s.components(separatedBy: "::")
            pageObj["$"] = splt[splt.count - 1]
            for (i,c) in splt.dropLast().enumerated() {
                pageObj["chapter" + String(i+1)] = c
            }
            pageContext["page"] = pageObj
        }
        
        /// Level 2
        if TechnicalContext.level2 > -1 {
            pageContext["site"] = ["level2_id": TechnicalContext.level2]
        }
        
        return pageContext
    }
}
