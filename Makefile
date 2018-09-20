test: .FORCE
	bundle exec rspec -fd --order random --color --fail-fast

.FORCE: