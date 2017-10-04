--COMP4920 Projct Meal Planner schema

create domain MediumString as varchar(64);
create domain LongString as varchar(256);
create domain EmailString as varchar(64) check (value like '%@%');
create domain LongName as varchar(128);

create domain MealType as char(1)
	check (value in (
		'B', -- Breakfast
		'L', -- Lunch
		'D', -- Dinner
	));

-- Users: users using meal Planner

create table Users (
	username	LongName not null,   
	password	MediumString not null, -- password should not longer than 16 characters
	email       EmailString,
	primary key (username)
)

create table Plans (
    user 		LongName references Users(username),
    plan_date	date not null,
    type 		MealType,
    food	    LongString,	
)

