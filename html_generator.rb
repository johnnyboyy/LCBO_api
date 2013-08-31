require 'json'
require 'open-uri'
require './html_view'


class HtmlGenerator
attr_accessor :products, :attributes

	def initialize
		@products = []
		10.times do |n|
			raw_response = open("http://lcboapi.com/products?page=#{n + 1}&per_page=100&order=id.asc").read
			#Parse JSON formatted text into a Ruby Hash 
			parsed_response = JSON.parse(raw_response)
			#Return the actual result data from the response, ignoring meta data 

			parsed_response["result"].each do |prods|
				@products << prods
			end
		end
		@attributes = @products.first.keys

		@html = HtmlView.new

	end

	def get_pictures
		pictures = attribute_by_name("image_thumb_url")
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
		@html.generate_index_view(attribute_by_name("name"),
								 replace_empty_pictures(get_pictures),
								 attribute_by_name("price_in_cents"),
								 attribute_by_name("primary_category"),
								 attribute_by_name("total_package_units"),
								 attribute_by_name("id")
								 )
	end

	def attribute_by_name(attribute)
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
		@products.each_with_index do |item, index|
			if item["id"].to_s == product_id.to_s
				prod = @products[index]
				@html.generate_show_view(prod["name"].to_s,
								 prod["image_url"],
								 prod["price_in_cents"].to_s,
								 prod["primary_category"].to_s,
								 prod["package"].to_s,
								 prod["id"].to_s,
								 prod["producer_name"].to_s,
								 prod["has_clearance_sale"].to_s,
								)
				return true
			end
		end
		return false
	end 

	def refresh
		initialize
	end


end