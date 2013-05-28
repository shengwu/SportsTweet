# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 15.minutes do
  runner "Tweet.destroy_all(created_at: 1.year.ago..1.hour.ago)"
  runner "Photo.destroy_all(created_at: 1.year.ago..5.hours.ago)"
  # rake "my:rake:task"
  # command "/usr/bin/my_great_command"
end

every 5.minutes do
	command "ruby /home/rc/SportsTweet/util/update_photos.rb"
end

#whenever --update-crontab store
#crontab -l
