--COMP4920 Projct Meal Planner schema

create domain ShortString as varchar(16);
create domain MediumString as varchar(64);
create domain LongString as varchar(256);
create domain EmailString as varchar(64) check (value like '%@%');
create domain LongName as varchar(128);

create domain genderType as char(1)
	check (value in (
		'M',
		'F'	
	));


create domain MealType as char(1)
	check (value in (
		'B', -- Breakfast
		'L', -- Lunch
		'D' -- Dinner
	));

-- Users: users using meal Planner

create table Users (
	username	LongName not null,   
	password	MediumString not null, -- password should not longer than 16 characters
	email       EmailString,
	gender		genderType,
	photourl	LongString,
	is_active  Boolean,
	primary key (username)
);

create table Plans (
    username 	LongName references Users(username),
    plan_date	date not null,
    type 		MealType not null,
    food	    LongString,
    primary key (username,plan_date,type)
);

create table food (
	name  		LongString not null,
	calorie		integer not null,
	sugar       integer,
	protein		integer,
	category	LongString not null,
	primary key (name)
)

