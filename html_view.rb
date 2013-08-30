class HtmlView
	def generate_index_view(name, pic, price, prime_cat, amount)
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
end