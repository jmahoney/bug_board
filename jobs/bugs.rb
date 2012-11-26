current_open_bug_count = 0
current_new_urgent_bug_count = 0
SCHEDULER.every '10s' do
  
  
  last_open_bug_count = current_open_bug_count
  current_open_bug_count = RedmineWeary::Issue.count(:tracker_id => BUG_TRACKER,
                                                     :status_id => OPEN_STATUS)
  
  last_new_urgent_bug_count = current_new_urgent_bug_count
  current_new_urgent_bug_count = RedmineWeary::Issue.count(:tracker_id => BUG_TRACKER,
                                                           :status_id => NEW_STATUS,
                                                           :priority_id => URGENT_PRIORITY)
  
                                                       
  send_event('open-bugs', { current: current_open_bug_count, last: last_open_bug_count })
  send_event('new-urgent-bugs', { current: current_new_urgent_bug_count, last: last_new_urgent_bug_count })
  
end