#!/opt/homebrew/opt/ruby/bin/ruby
# https://gist.github.com/safplatform/792314da6b54346594432f30d5868f36

if ARGF.filename == "-"
  puts "Usage: tax.rb [file]"
  puts "File should be a text document where each line is in"
  puts "the following format:"
  puts "  <quantity> [imported] <description> at <price>"
  exit
end

def str_to_money(str)
  parts = str.split(".")
  (100 * Integer(parts[0])) + Integer(parts[1])
end

def money_to_str(int)
  padding = (int % 10 == 0) ? "0" : ""

  (int / 100.0).to_s + padding
end

def calc_tax(price:, rate:)
  base = Integer(price * rate.to_f)
  round = base % 5

  base + (round == 0 ? 0 : 5 - round)
end

def calc_sales_tax(amount)
  calc_tax(price: amount, rate: 0.1)
end

def calc_import_tax(amount)
  calc_tax(price: amount, rate: 0.05)
end

def is_exempt?(line)
  %w[book chocolate pill].any? { |e| line.include?(e) }
end

line_parse = /^(\d+) (imported )?(.+) at (\d+\.\d{2})$/

input = ARGF.readlines

items = input.map do |input_line|
  matches = input_line.match(line_parse)
  next unless matches

  quantity = Integer(matches[1])
  imported = !matches[2].nil?
  exempt = is_exempt?(matches[3])
  base_price = str_to_money(matches[4])
  
  tax = (exempt ? 0 : calc_sales_tax(base_price)) + (imported ? calc_import_tax(base_price) : 0)

  {
    description: "#{quantity} #{matches[2]}#{matches[3]}",
    tax: tax * quantity,
    total: (base_price + tax) * quantity,
  }
end.compact

totals = items.reduce({tax: 0, total: 0}) do |working, line_item|
  working[:tax] += line_item[:tax]
  working[:total] += line_item[:total]
  working
end

items.each do |line_item|
  puts "#{line_item[:description]}: #{money_to_str(line_item[:total])}"
end
puts "Sales Taxes: #{money_to_str(totals[:tax])}"
puts "Total: #{money_to_str(totals[:total])}"
