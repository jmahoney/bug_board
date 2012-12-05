SCHEDULER.every '300s' do
  
  project_counts = Hash.new( {value: 0} )
  
  PROJECT_IDS.split(",").each do |project_id|
  
    project = RedmineWeary::Project.create(project_id)
    
    urgent = RedmineWeary::Issue.count(:tracker_id => BUG_TRACKER, :project_id => project.id, 
                                       :priority_id => URGENT_PRIORITY)
    high = RedmineWeary::Issue.count(:tracker_id => BUG_TRACKER, :project_id => project.id, 
                                     :priority_id => HIGH_PRIORITY)
    
    project_counts[project.name] = {:label => project.name, :value => "#{urgent} | #{high}"}
  end
  
  send_event('projects', { items: project_counts.values })
  
  
end