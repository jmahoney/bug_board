current_count = 0

SCHEDULER.every '10s' do
  last_count = current_count
  
  current_count = RedmineWeary::Issue.count
  
  send_event('bugs', { current: current_count, last: last_count })
  
end