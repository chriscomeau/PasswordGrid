//
//  ComplicationController.swift
//  passwordmatrix_watch Extension
//
//  Created by Chris Comeau on 2018-09-21.
//

import ClockKit


class ComplicationController: NSObject, CLKComplicationDataSource {
    
    // MARK: - Timeline Configuration
    
    func getSupportedTimeTravelDirections(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimeTravelDirections) -> Void) {
        handler([.forward, .backward])
    }
    
    func getTimelineStartDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getTimelineEndDate(for complication: CLKComplication, withHandler handler: @escaping (Date?) -> Void) {
        handler(nil)
    }
    
    func getPrivacyBehavior(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationPrivacyBehavior) -> Void) {
        handler(.showOnLockScreen)
    }
    
    // MARK: - Timeline Population
    
    func getTimelineEntries(for complication: CLKComplication, before date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries prior to the given date
        handler(nil)
    }
    
    func getTimelineEntries(for complication: CLKComplication, after date: Date, limit: Int, withHandler handler: @escaping ([CLKComplicationTimelineEntry]?) -> Void) {
        // Call the handler with the timeline entries after to the given date
        handler(nil)
    }
    
    func getCurrentTimelineEntry(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTimelineEntry?) -> Void) {
        if let template = getTemplate(for: complication) {
            let timelineEntry = CLKComplicationTimelineEntry(date: Date(), complicationTemplate: template)
            handler(timelineEntry)
        }
        else {
            handler(nil)
        }
    }
    
    func getNextRequestedUpdateDate(handler: @escaping (Date?) -> Void) {
        let date = Date.init(timeIntervalSinceNow: 60*60) //1h
        handler(date)
    }
    
    // MARK: - Placeholder Templates
    
    func getTemplate(for complication: CLKComplication)-> CLKComplicationTemplate? {
        //let color = UIColor.orange
        let color = Colors.globalTintColor
        let image = UIImage(named: "placeholder1")
        
        if complication.family == .modularSmall {
            let template = CLKComplicationTemplateModularSmallSimpleImage()
            template.imageProvider = CLKImageProvider(onePieceImage: image!)
            template.imageProvider.tintColor = color
            template.tintColor = color
            return template
        }
        else if complication.family == .circularSmall {
            let template = CLKComplicationTemplateCircularSmallSimpleImage()
            template.imageProvider = CLKImageProvider(onePieceImage: image!)
            template.imageProvider.tintColor = color
            template.tintColor = color
            return template
        }
            
        else if complication.family == .utilitarianSmall {
            let template = CLKComplicationTemplateUtilitarianSmallSquare()
            template.imageProvider = CLKImageProvider(onePieceImage: image!)
            template.imageProvider.tintColor = color
            template.tintColor = color
            return template
        }
        //2018-09-25 15:16:25.731321-0400 passwordmatrix_watch Extension[55607:1573923] *** Terminating app due to uncaught exception 'NSInvalidArgumentException', reason: 'getLocalizableSampleTemplateForComplication:withHandler: -- template class (CLKComplicationTemplateGraphicCornerCircularImage) is incompatible with complication family CLKComplicationFamilyGraphicCircular'

        
//        else if complication.family == .graphicCircular {
//            let image2 = UIImage(named: "placeholder2")
//            let template = CLKComplicationTemplateGraphicCornerCircularImage()
//            template.imageProvider = CLKFullColorImageProvider(fullColorImage: image2!)
//            //template.imageProvider.tintColor = color
//            template.tintColor = color
//            return template
//        }
        
        return nil
    }
    
    func getLocalizableSampleTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        let template = getTemplate(for: complication)
        handler(template)
    }
    
    func getPlaceholderTemplate(for complication: CLKComplication, withHandler handler: @escaping (CLKComplicationTemplate?) -> Void) {
        //deprecated?
        let template = getTemplate(for: complication)
        handler(template)
    }
    
}
