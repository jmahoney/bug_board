# SCHEDULER.every '300s' do
#   developer_counts = Hash.new({value: 0})
#   
#   DEVELOPER_IDS.split(",").each do |developer_id|
#     urgent = RedmineWeary::Issue.count(:assigned_to_id => developer_id, priority_id => URGENT_PRIORITY,
#                                        :tracker_id => BUG_TRACKER)
#     high = RedmineWeary::Issue.count(:assigned_to_id => developer_id, priority_id => HIGH_PRIORITY,
#                                      :tracker_id => BUG_TRACKER)
#     
#   end
# end