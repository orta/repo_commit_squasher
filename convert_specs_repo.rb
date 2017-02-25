# This is a one-off script for migrating to the new CocoaPods Specs infrastructre.

[
  "git clone https://github.com/CocoaPods/Specs.git",
  "cd Specs",

  # Create a new branch of master
  "git checkout --orphan new_master",
  "git add .",
  "git commit -m 'Start of new squashing commit process'",
  # Delete old master
  "git branch -D master",
  # Replace master
  "git checkout -b master",

  # Create a new branch of predates_sharding_branch
  "git checkout predates_sharding_branch",
  "git checkout --orphan new_predates_sharding_branch",
  "git add .",
  "git commit -m 'Create a single commit version of predates_sharding_branch'",
  # Delete old branch
  "git branch -D predates_sharding_branch",
  # Replace with new one
  "git checkout -b predates_sharding_branch",
  # Replace the tag with the new commit
  "git tag -d v0.32.1",
  "git tag v0.32.1",

  # Replace the tag "20161019"
  "git checkout 20161019",
  "git checkout --orphan new_20161019",
  "git add .",
  "git commit -m 'Create a single commit version of 20161019'",
  "git tag -d 20161019",
  "git tag 20161019",

  # OK, that's master switched to be one commit, and predates_sharding_branch also.
  # All of the commits that make up the old master need to be removed
  "git gc --prune=now --aggressive",

].each do |line| 
  unless system(line)
    puts "> Failed"
    puts line
    exit
  end
end

# That's a reduced version of the repo, ship it back

puts "OK, that's all of them, now it's on you to make the pushes:\n"

puts "git push origin predates_sharding_branch:predates_sharding_branch -f"
puts "git push origin master:master -f"
puts "git push --tags -f"
