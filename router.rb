require_relative'html_generator'

if ARGV.empty?
	puts"Usage: rubyrouter.rb[action]"
else
	action=ARGV[0]
	generator=HtmlGenerator.new

	if action=="index"
		generator.index
	elsif action=="show"
		generator.show(ARGV[1])
	else
		puts"Unknown action #{action}. Use index or show."
	end
end