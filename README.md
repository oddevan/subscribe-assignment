# Subscribe Engineer Test

Calculates sales and import taxes and displays total taxes as well as the grand total.

Sales tax is 10%. Books, food, and medical products are exempt. This script checks for
'chocolate' and 'pill'; other types may need to be added in the future.

All imported goods have a 5% import tax.

All taxes are rounded up to the next 0.05.

## Usage

	ruby ./tax.rb input1.txt

## Test output

	eph@Mac subscribe-assignment % ruby ./tax.rb input1.txt
	2 book: 24.98
	1 music CD: 16.49
	1 chocolate bar: 0.85
	Sales Taxes: 1.50
	Total: 42.32
	eph@Mac subscribe-assignment % ruby ./tax.rb input2.txt
	1 imported box of chocolates: 10.50
	1 imported bottle of perfume: 54.65
	Sales Taxes: 7.65
	Total: 65.15
	eph@Mac subscribe-assignment % ruby ./tax.rb input3.txt
	1 imported bottle of perfume: 32.19
	1 bottle of perfume: 20.89
	1 packet of headache pills: 9.75
	3 imported boxes of chocolates: 35.55
	Sales Taxes: 7.90
	Total: 98.38