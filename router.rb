require_relative'html_generator'

if ARGV.empty?
	puts"Usage: rubyrouter.rb[action]"
else
	action=ARGV[0]
	generator=HtmlGenerator.new

	if action=="index"
		generator.index
	elsif action=="show"
		if ARGV[1].downcase == "ids"
			p generator.attribute_by_name("id")
		elsif generator.show(ARGV[1]) == false
			p "No product found with ID: #{ARGV[1]}"
		else
			p "Html generated for product ID: #{ARGV[1]}"
		end
	else
		puts"Unknown action #{action}. Use index or show."
	end
end