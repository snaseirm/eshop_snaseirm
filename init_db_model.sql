CREATE DATABASE bivaa_example_eshop CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci;

use bivaa_example_eshop;

create table if not exists `user` (
	`id` int(11) auto_increment not null,
	`name` varchar(255) not null,
    `email` varchar(255) not null,
    `password` varchar(255) not null,
    `is_active` bit(1) not null,
    `is_admin` bit(1) not null,
    primary key (`id`)
) engine=InnoDB charset utf8mb4;

create table if not exists `customer` (
	`id` int(11) auto_increment not null,
	`name` varchar(255) not null,
    `email` varchar(255) not null,
    `is_bussiness_customer` bit(1) not null,
    `is_active` bit(1) not null,
    primary key (`id`)
) engine=InnoDB charset utf8mb4;

create table if not exists `tax_rate` (
	`id` int(11) auto_increment not null,
    `code` varchar(128) not null,
	`name` varchar(255) not null,
    `rate` double not null,
    primary key (`id`)
) engine=InnoDB charset utf8mb4;

create table if not exists `brand` (
	`id` int(11) auto_increment not null,
    `code` varchar(128) not null,
	`name` varchar(255) not null,
    `default_tax_rate_id` int(11) not null,
    primary key (`id`),
    constraint fk_brand_tax_rate foreign key (default_tax_rate_id) references tax_rate(id)
) engine=InnoDB charset utf8mb4;

create table if not exists `stock_item_dimension` (
	`id` int(11) auto_increment not null,
    `weight` double not null,
    `height` double not null,
    `width` double not null,
    `depth` double not null,
    primary key (`id`)
) engine=InnoDB charset utf8mb4;

create table if not exists `stock_item` (
	`id` int(11) auto_increment not null,
    `code` varchar(128) not null,
	`name` varchar(255) not null,
    `sell_price` double not null,
    `stock_item_dimension_id` int(11) not null,
    primary key (`id`),
    constraint fk_stock_item_stock_item_dimension foreign key (stock_item_dimension_id) references stock_item_dimension(id)
) engine=InnoDB charset utf8mb4;

create table if not exists `sales_order` (
	`id` int(11) auto_increment not null,
    `customer_id` int(11) not null,
    `brand_id` int(11) not null,
    `type` varchar(128) not null, -- c# enum value
    `total_price` double not null,
    `total_net` double not null,
    `total_vat` double not null,
    primary key(`id`),
    constraint fk_sales_order_customer foreign key (customer_id) references customer(id),
    constraint fk_sales_order_brand foreign key (brand_id) references brand(id)
) engine=InnoDB charset utf8mb4;

create table if not exists `sales_order_item` (
	`id` int(11) auto_increment not null,
    `sales_order_id` int(11) not null,
    `stock_item_id` int(11) not null,
    `total_price` double not null,
    `total_gross` double not null,
    `total_net` double not null,
    `total_tax` double not null,
    `quantity` double not null,
    primary key (`id`),
    constraint fk_sales_order_item_sales_order foreign key (sales_order_id) references sales_order(id),
    constraint fk_sales_order_item_stock_item foreign key (stock_item_id) references stock_item(id)
) engine=InnoDB charset utf8mb4;

create table if not exists `discount_code` (
	`id` int(11) auto_increment not null,
    `code` varchar(128) not null,
	`name` varchar(255) not null,
    `discount_percentage` double not null,
    `discount_amount` double not null,
    primary key (`id`)
) engine=InnoDB charset utf8mb4;

create table if not exists `sales_order_discount_code` (
	`sales_order_id` int(11) not null,
    `discount_code_id` int(11) not null,
    primary key (`sales_order_id`, `discount_code_id`),
    constraint fk_sales_order_discount_code_sales_order foreign key (sales_order_id) references sales_order(id),
    constraint fk_sales_order_discount_code_discount_code foreign key (discount_code_id) references discount_code(id)
) engine=InnoDB charset utf8mb4;

-- indexes
create index ix_sales_order_type on sales_order(type);
create index ix_sales_order_customer_name on customer(name(128));
create index ix_sales_order_customer_is_active on customer(is_active);
create index ix_sales_order_customer_email_is_active on customer(email(128), is_active);

-- more to be added

/*

mysqldump --default-character-set=utf8mb4 -u root -pPWD bivaa_example_000 >bivaa_example_000.sql
mysql --default-character-set=utf8mb4 -u root -pPWD <bivaa_example_000.sql

*/