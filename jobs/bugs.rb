current_open_count = 0
current_urgent_count = 0
current_untriaged_count = 0
SCHEDULER.every '10s' do
  
  
  last_open_count = current_open_count
  current_open_count = RedmineWeary::Issue.count(:tracker_id => BUG_TRACKER,
                                                     :status_id => OPEN_STATUS)
  
  last_urgent_count = current_urgent_count
  current_urgent_count = RedmineWeary::Issue.count(:tracker_id => BUG_TRACKER, :priority_id => URGENT_PRIORITY)
                                                           
  last_untriaged_count = current_untriaged_count
  
  
  options = {:tracker_id => BUG_TRACKER, :status_id => NEW_STATUS, :priority_id => URGENT_PRIORITY}
  untriaged_field = "cf_#{TRIAGED_FIELD}".to_sym
  options[untriaged_field] = "1"
  current_untriaged_count = RedmineWeary::Issue.count(options)                
  
                                                       
  send_event('open-bugs', { current: current_open_count, last: last_open_count })
  send_event('urgent-bugs', { current: current_urgent_count, last: last_urgent_count })
  send_event('untriaged-bugs', { current: current_untriaged_count, last: last_untriaged_count })
  
end