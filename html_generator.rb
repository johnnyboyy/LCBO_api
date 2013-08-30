require 'json'
require 'open-uri'
require './html_view'


class HtmlGenerator
attr_accessor :products, :attributes

	def initialize
		raw_response = open("http://lcboapi.com/products").read
		#Parse JSON formatted text into a Ruby Hash 
		parsed_response = JSON.parse(raw_response)
		#Return the actual result data from the response, ignoring meta data 

		@products = parsed_response["result"]
		@attributes = @products.first.keys

		@html = HtmlView.new

	end
	
	def get_pictures
		pictures = attribute_by_id("image_url")
	end


	def replace_empty_pictures(image_url_array)
		image_url_array.each_with_index do |url, index|
			if url == ""
				image_url_array[index] = "http://placekitten.com/150/150"
			end
		end
		image_url_array
	end

	def index 
		@html.generate_index_view(attribute_by_id("name"),
								 replace_empty_pictures(get_pictures),
								 attribute_by_id("price_in_cents"),
								 attribute_by_id("primary_category"),
								 attribute_by_id("total_package_units")
								 )
	end

	def attribute_by_id(attribute)
		if @attributes.include?(attribute)
			attribute_list = []

			@products.each do |items|
				attribute_list << items[attribute].to_s
			end
			return attribute_list
		else
			raise "No attribute with that name."
		end
	end

	def show(product_id)
		@products.each do |products|
			results = products.select { |k, v| k == product_id }
			if results.empty?
				return "No products matched the id: #{product_id}"
			else
				return results.values
			end
		end
	end 

	def refresh
		initialize
	end


end