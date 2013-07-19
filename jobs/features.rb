current_open_count = 0
current_urgent_count = 0
current_high_count = 0

SCHEDULER.every '5m' do
  
  
  last_open_count = current_open_count
  current_open_count = RedmineWeary::Issue.count(:tracker_id => FEATURE_TRACKER,
                                                 :status_id => OPEN_STATUS)
  current_open_count += RedmineWeary::Issue.count(:tracker_id => CR_TRACKER,
                                                :status_id => OPEN_STATUS)
  
  
  last_urgent_count = current_urgent_count
  current_urgent_count = RedmineWeary::Issue.count(:tracker_id => FEATURE_TRACKER, 
                                                   :priority_id => URGENT_PRIORITY)
  current_urgent_count = RedmineWeary::Issue.count(:tracker_id => CR_TRACKER, 
                                                  :priority_id => URGENT_PRIORITY)

                                                           
  last_high_count = current_high_count
  current_high_count = RedmineWeary::Issue.count(:tracker_id => FEATURE_TRACKER, 
                                                   :priority_id => HIGH_PRIORITY)
  current_high_count += RedmineWeary::Issue.count(:tracker_id => CR_TRACKER, 
                                                  :priority_id => HIGH_PRIORITY)  
                                                       
  send_event('open-features', { current: current_open_count, last: last_open_count })
  send_event('urgent-features', { current: current_urgent_count, last: last_urgent_count })
  send_event('high-features', { current: current_high_count, last: last_high_count })
end