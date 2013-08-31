class HtmlView
	def generate_index_view(name, pic, price, prime_cat, amount, id)
		File.open('index.html', 'w') do |f|

			f.puts <<-eos
<html>
<head>
<title>Products</title>
<link rel="stylesheet" type="text/css" media="screen" href="index.css"/>
<link href='http://fonts.googleapis.com/css?family=Chau+Philomene+One|Finger+Paint' rel='stylesheet' type='text/css'>
<body>
  <div class="section">
    <h1>LCBO Products</h1>

    <ol class="chartlist" style="margin-bottom: 80px">
			eos
			

			(name.length - 1).times do |counter|
				f.puts "<li>"
				c = "product_#{counter}"
				f.puts "<img src=\"#{pic[counter]}\">"
				f.puts "<h2 class=\"#{c}\" >#{name[counter]}</h2>"
				f.puts "<span class=\"product_id\">Product ID: #{id[counter]}</span>"
				f.puts "<span class=\"pakage_size\">Package size: #{amount[counter].to_s }</span>"
				f.puts "<div class=\"cat\" >Category: #{prime_cat[counter]}</div>"
				f.puts "<span class=\"price\" >Price: $" + price[counter][0..-3] + "." + price[counter][-2..-1] + "</span>"
				f.puts "</li>"
			end
			f.puts  <<-eos
	</ol>
	<div class="footer"></div>
</body>
</html>
			eos


		end
	end


	def generate_show_view(name, pic, price, prime_cat, amount, id, producer, on_sale)
		picture = ""
		if pic != nil
			picture = pic
		else
			picture = "http://placekitten.com/500/500"
		end
		File.open('show.html', 'w') do |f|

			f.puts <<-eos
<html>
<head>
<title>#{name}</title>
<link rel="stylesheet" type="text/css" media="screen" href="show.css"/>
</head>
  <div class="section">
    <h1>#{name}</h1>

			eos
			

			
				c = "product_#"
				if on_sale == true
					f.puts "<span class=\"sale\">ON SALE</span>"
				end
				f.puts "<img src=\"#{picture}\">"
				f.puts "<div class=\"cont\">"
				f.puts "<span class=\"product_id\">Product ID: #{id}</span>"
				f.puts "<span class=\"pakage_size\">Package size: #{amount.to_s }</span>"
				f.puts "<div class=\"cat\" >Category: #{prime_cat}</div>"
				f.puts "<span class=\"price\" >Price: $" + price[0..-3] + "." + price[-2..-1] + "</span>"
				f.puts "<span class=\"producer\">Producer: #{producer}</span>"
				f.puts "</div>"


			f.puts  <<-eos
	<div class="footer"></div>
</body>
</html>
			eos


		end
	end
end