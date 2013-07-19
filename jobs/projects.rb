SCHEDULER.every '3m' do
  
  project_counts = Hash.new( {value: 0} )
  
  PROJECT_IDS.split(",").each do |project_id|
  
    project = RedmineWeary::Project.create(project_id)
    
    urgent_bugs = RedmineWeary::Issue.count(:tracker_id => BUG_TRACKER, :project_id => project.id, 
                                       :priority_id => URGENT_PRIORITY)
    high_bugs = RedmineWeary::Issue.count(:tracker_id => BUG_TRACKER, :project_id => project.id, 
                                     :priority_id => HIGH_PRIORITY)
    urgent_features = RedmineWeary::Issue.count(:tracker_id => FEATURE_TRACKER, :project_id => project.id, 
                                        :priority_id => URGENT_PRIORITY)
    high_features = RedmineWeary::Issue.count(:tracker_id => FEATURE_TRACKER, :project_id => project.id, 
                                      :priority_id => HIGH_PRIORITY)                                     
    urgent_features += RedmineWeary::Issue.count(:tracker_id => CR_TRACKER, :project_id => project.id, 
                                        :priority_id => URGENT_PRIORITY)
    high_features += RedmineWeary::Issue.count(:tracker_id => CR_TRACKER, :project_id => project.id, 
                                      :priority_id => HIGH_PRIORITY)                                     
    
    project_counts[project.name] = {:label => project.name, :value => "#{urgent_bugs} | #{high_bugs} | #{urgent_features} | #{high_features}"}
  end
  
  send_event('projects', { items: project_counts.values })
  
  
end