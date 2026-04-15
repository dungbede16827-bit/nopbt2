-- các rủi ro
-- nhập -1000 hoặc 0 sai logic
-- một người dùng cso nhiều ví 
-- số dư bị âm
-- giao dịch không thuộc ví nào
create database wallets_transaction;

use wallets_transaction;
create table WALLETS (
wallet_id bigint auto_increment primary key ,
user_id bigint not null unique,
balance decimal(15,2) not null default 0 check (balance >= 0),
foreign key (user_id) references USERS(user_id)

);

create table TRANSATIONS (
transation_id bigint auto_increment primary key,
wallet_id bigint not null,
transation_type varchar(20) not null,
amount decimal(15,2) not null check(amount>0),
statuss varchar(20) not null default 'pending',
created_at timestamp default current_timestamp,

foreign key (wallet_id) references WALLETS(wallet_id),
check (transaction_type in ('DEPOSIT', 'WITHDRAW', 'PAYMENT')),

check (statuss in ('PENDING', 'SUCCESS', 'FAILED'))
);
