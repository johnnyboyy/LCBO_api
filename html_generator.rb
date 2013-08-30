require 'json'
require 'open-uri'
require './html_view'


class HtmlGenerator
attr_accessor :products, :attributes, :names, :pictures, :price_in_cents, :primary_category

	def initialize
		raw_response = open("http://lcboapi.com/products").read
		#Parse JSON formatted text into a Ruby Hash 
		parsed_response = JSON.parse(raw_response)
		#Return the actual result data from the response, ignoring meta data 

		@products = parsed_response["result"]
		@attributes = @products.first.keys

		@html = HtmlView.new


		@names = attribute_by_id("name").values
		@pictures = attribute_by_id("image_url").values
		@pictures.each_with_index do |url, index|
			if url == ""
				@pictures[index] = "http://placekitten.com/150/150"
			end
		end
		@price_in_cents = attribute_by_id("price_in_cents").values
		@primary_category = attribute_by_id("primary_category").values
		@amount = attribute_by_id("total_package_units").values
	end

	def index 
		@html.generate_index_view(@names,
								 @pictures,
								 @price_in_cents,
								 @primary_category,
								 @amount
								 )
	end

	def attribute_by_id(attribute)
		if @attributes.include?(attribute)
			attribute_and_id = {}

			@products.each do |items|
				attribute_and_id[items["id"]] = items[attribute].to_s
			end
			return attribute_and_id
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