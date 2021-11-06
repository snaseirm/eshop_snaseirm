insert into tax_rate
(id, code, name, rate)
values
(0, 'TAX0', 'Zero Rate', 0.0),
(0, 'TAX20', '20% Tax', 20.0)
;

insert into brand 
(id, code, name, default_tax_rate_id)
values
(0, 'TEST', 'Test Brand', (select id from tax_rate where code = 'TAX20')),
(0, 'Samsung', 'Samsung', (select id from tax_rate where code = 'TAX20')),
(0, 'Apple', 'Apple', (select id from tax_rate where code = 'TAX20'))
;

insert into customer
(id, name, email, is_bussiness_customer, is_active)
values
(0, 'John Doe', 'johndoe@test.test', 0, 1),
(0, 'James Smith', 'jamessmith@test.test', 0, 1),
(0, 'Michael Williams', 'michaelwilliams@test.test', 0, 1),
(0, 'Maria Wilson', 'mariawolson@test.test', 0, 1),
(0, 'Margaret Martinez', 'margaretmartinez@test.test', 0, 1),
(0, 'Patricia Brown', 'patriciabrown@test.test', 0, 1)
;

insert into stock_item_dimension
(id, weight, height, width, depth)
value
(0, 15.0, 50.0, 90.0, 15.0);

insert into stock_item
(id, code, name, sell_price, stock_item_dimension_id)
value
(0, 'TELEVISION_001', 'Televizor 90x50x15', 500.0, (SELECT LAST_INSERT_ID()))
;

insert into stock_item_dimension
(id, weight, height, width, depth)
value
(0, 17.0, 50.0, 100.0, 15.0);

insert into stock_item
(id, code, name, sell_price, stock_item_dimension_id)
value
(0, 'TELEVISION_002', 'Televizor 100x50x15', 600.0, (SELECT LAST_INSERT_ID()))
;

insert into stock_item_dimension
(id, weight, height, width, depth)
value
(0, 20.0, 120.0, 90.0, 15.0);

insert into stock_item
(id, code, name, sell_price, stock_item_dimension_id)
value
(0, 'TELEVISION_003', 'Televizor 120x50x15', 700.0, (SELECT LAST_INSERT_ID()))
;

insert into sales_order
(id, customer_id, brand_id, type, total_price, total_net, total_vat)
values
(0, (select id from customer where name = 'John Doe'), (select id from brand where code = 'Samsung'), '', 1300.0, 1074.38, 225.62),
(0, (select id from customer where name = 'Patricia Brown'), (select id from brand where code = 'Samsung'), '', 1300.0, 1074.38, 225.62),
(0, (select id from customer where name = 'Maria Wilson'), (select id from brand where code = 'Apple'), '', 1300.0, 1074.38, 225.62)
;

insert into sales_order_item
(id, sales_order_id, stock_item_id, total_price, total_gross, total_net, total_tax, quantity)
values
(0, 1, (select id from stock_item where code = 'TELEVISION_002'), 600.0, 600.0, 495.87, 104.13, 1),
(0, 1, (select id from stock_item where code = 'TELEVISION_003'), 700.0, 700.0, 578.51, 121.49, 1),
(0, 2, (select id from stock_item where code = 'TELEVISION_002'), 600.0, 600.0, 495.87, 104.13, 1),
(0, 2, (select id from stock_item where code = 'TELEVISION_003'), 700.0, 700.0, 578.51, 121.49, 1),
(0, 3, (select id from stock_item where code = 'TELEVISION_002'), 600.0, 600.0, 495.87, 104.13, 1),
(0, 3, (select id from stock_item where code = 'TELEVISION_003'), 700.0, 700.0, 578.51, 121.49, 1)
;