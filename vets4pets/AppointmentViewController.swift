//
//  AppointmentViewController.swift
//  IA
//
//  Created by Snigdha Tiwari  on 12/06/23.
//

import UIKit
import CalendarKit
import EventKit
import EventKitUI

final class AppointmentViewController: DayViewController, EKEventEditViewDelegate {
    
    private var eventStore = EKEventStore() //singleton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Calendar"

        requestAccessToCalendar() //asks for calendar permission
   
        subscribeToNotifications()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setToolbarHidden(true, animated: false)
    }
    
    private func requestAccessToCalendar() {
     
        eventStore.requestAccess(to: .event) { [weak self] granted, error in  //checks if access has been granted through completion handler
            
            DispatchQueue.main.async { //performed on background thread
                guard let self else { return }
                self.initializeStore()
                self.subscribeToNotifications()
                self.reloadData()
            }
        }
    }
    
    private func subscribeToNotifications() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(storeChanged(_:)),
                                               name: .EKEventStoreChanged,
                                               object: eventStore)
    }
    
    private func initializeStore() {
        eventStore = EKEventStore()
    }
    
    @objc private func storeChanged(_ notification: Notification) {
        reloadData()
    }
    
    // MARK: - DayViewDataSource
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] { //date provided in method is midnight of the day interested in
        
        let startDate = date //creating range of midnight of day interested, till midnight of the next day
        var oneDayComponents = DateComponents()
        oneDayComponents.day = 1
        let endDate = calendar.date(byAdding: oneDayComponents, to: startDate)!
        
        
        
        let predicate = eventStore.predicateForEvents(withStart: startDate, // Start of the current day
                                                      end: endDate, // Start of the next day
                                                      calendars: nil) // Search in all calendars
        
        let eventKitEvents = eventStore.events(matching: predicate) //fetches events using the predicate
        let calendarKitEvents = eventKitEvents.map(EKWrapper.init) //converts eventkit events to calendarkit events
        
        return calendarKitEvents
    }
    
    // MARK: - DayViewDelegate
    
    // MARK: Event Selection
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let ckEvent = eventView.descriptor as? EKWrapper else {
            return
        }
        presentDetailViewForEvent(ckEvent.ekEvent)
    }
    
    private func presentDetailViewForEvent(_ ekEvent: EKEvent) {
        let eventController = EKEventViewController()
        eventController.event = ekEvent
        eventController.allowsCalendarPreview = true
        eventController.allowsEditing = true
        navigationController?.pushViewController(eventController,
                                                 animated: true)
    }
    
    // MARK: Event Editing
    
    override func dayView(dayView: DayView, didLongPressTimelineAt date: Date) {
        // Cancel editing current event and start creating a new one
        endEventEditing()
        let newEKWrapper = createNewEvent(at: date)
        create(event: newEKWrapper, animated: true)
    }
    
    private func createNewEvent(at date: Date) -> EKWrapper {
        let newEKEvent = EKEvent(eventStore: eventStore)
        newEKEvent.calendar = eventStore.defaultCalendarForNewEvents
        
        var components = DateComponents()
        components.hour = 1
        let endDate = calendar.date(byAdding: components, to: date)
        
        newEKEvent.startDate = date
        newEKEvent.endDate = endDate
        newEKEvent.title = "New event"

        let newEKWrapper = EKWrapper(eventKitEvent: newEKEvent)
        newEKWrapper.editedEvent = newEKWrapper
        return newEKWrapper
    }
    
    override func dayViewDidLongPressEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? EKWrapper else {
            return
        }
        endEventEditing()
        beginEditing(event: descriptor,
                     animated: true)
    }
    
    override func dayView(dayView: DayView, didUpdate event: EventDescriptor) {
        guard let editingEvent = event as? EKWrapper else { return }
        if let originalEvent = event.editedEvent {
            editingEvent.commitEditing()
            
            if originalEvent === editingEvent {
                // If editing event is the same as the original one, it has just been created.
                // Showing editing view controller
                presentEditingViewForEvent(editingEvent.ekEvent)
            }
            else {
                // If editing event is different from the original,
                // then it's pointing to the event already in the `eventStore`
                // Let's save changes to oriignal event to the `eventStore`
                try! eventStore.save(editingEvent.ekEvent,
                                     span: .thisEvent)
            }
        }
        reloadData()
    }
    
    
    private func presentEditingViewForEvent(_ ekEvent: EKEvent) {
        let eventEditViewController = EKEventEditViewController()
        eventEditViewController.event = ekEvent
        eventEditViewController.eventStore = eventStore
        eventEditViewController.editViewDelegate = self
        present(eventEditViewController, animated: true, completion: nil)
    }
    
    override func dayView(dayView: DayView, didTapTimelineAt date: Date) {
        endEventEditing()
    }
    
    override func dayViewDidBeginDragging(dayView: DayView) {
        endEventEditing()
    }
    
    // MARK: - EKEventEditViewDelegate
    
    func eventEditViewController(_ controller: EKEventEditViewController, didCompleteWith action: EKEventEditViewAction) {
        endEventEditing()
        reloadData()
        controller.dismiss(animated: true, completion: nil)
    }
}

