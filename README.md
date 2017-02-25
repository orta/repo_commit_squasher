### What is this?

It's an exploration into squashing the commits on the CocoaPods Specs repo.

The aim being to make a `pod setup` download only a few commits instead of over a hundred thousand. 

My approach has been to try replace all known branches with a new branch with only one commit, then to test the size of the `.git` repo. So far, I'm not sure I've got it all.

```sh
$ git clone git clone https://github.com/CocoaPods/Specs.git
$ cd Specs
$ du .git
0	.git/branches
80	.git/hooks
16	.git/info
16	.git/logs/refs/heads
0	.git/logs/refs/remotes/origin
0	.git/logs/refs/remotes
16	.git/logs/refs
24	.git/logs
8	.git/objects/6f
8	.git/objects/info
439848	.git/objects/pack
439864	.git/objects
8	.git/refs/heads
0	.git/refs/remotes/origin
0	.git/refs/remotes
0	.git/refs/tags
8	.git/refs
476528	.git
```

after is coming soon.

This repo contains 2 scripts, one for [running daily/weekly/monthly](runner.rb) and one for converting to the [new format](convert_specs_repo.rb).

