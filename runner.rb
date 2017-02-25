token = ENV["GITHUB_API_TOKEN"]
username = ENV["GITHUB_API_TOKEN"]
repo = ENV["REPO_SLUG"]

repo_name = "temp_repo"

system "git clone https://#{username}:#{token}@github.com/#{repo}.git #{repo_name}"
unless Dir.exists repo_name
  puts "Cloning #{repo} did not work."
  # Send slack message
  exit
end

# Tell trunk to stop allowing new pods?
# Send slack message that it's happening

system "cd #{repo_name}"

# Based on
# http://stackoverflow.com/questions/13716658/how-to-delete-all-commit-history-in-github
# and http://stackoverflow.com/questions/7907372/how-to-hard-delete-an-orphan-commit-in-git#7907518

# Create a new master with no commits in the history
system "git checkout --orphan new_master"

# Add the current folder structure to git
now = Time.new.to_date
message = "Converged all commits for #{now.day}/#{now.month}/#{now.year}"
system "git add -A"
system "git commit -am '#{message}'"

# Delete the old master
system "git branch -D master"

# Kill now orphaned commits
system "git gc --prune=now --aggressive"

# Move new commit to master
system "git checkout -b master"

# Force replace the new commit
system "git push origin master -f"

# Tell trunk to allow new pods?
# Send slack message that it happened
