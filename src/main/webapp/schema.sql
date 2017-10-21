--COMP4920 Projct Meal Planner schema

create domain ShortString as varchar(16);
create domain MediumString as varchar(64);
create domain LongString as varchar(256);
create domain VeryLongString as varchar(65536);
create domain EmailString as varchar(64) check (value like '%@%');
create domain LongName as varchar(128);

create domain genderType as char(1)
	check (value in (
		'M',
		'F'	
	));


create domain MealType as varchar(10)
	check (value in (
		'Breakfast',
		'Lunch',
		'Dinner'
	));

-- Users: users using meal Planner

create table Users (
	username	LongName not null,   
	password	MediumString not null, -- password should not longer than 16 characters
	email       EmailString,
	gender		genderType,
	photourl	LongString,
	is_active  Boolean,
	start     MediumString,
	primary key (username)
);


create table Food (
	id			MediumString not null,
	name  		LongString not null,
	calorie		integer not null,
	sugar       integer,
	protein		integer,
	category	LongString not null,
	primary key (id)
);

create table Recipes (
	id			MediumString not null,
	name 		LongString not null,
	ingredients VeryLongString;
	url			VeryLongString,
	image_url	VeryLongString,
	cook_time	MediumString,
	prep_time	MediumString,
	time_stamp	MediumString,
	primary key (id)
)

create table Plans (
  username 	LongName references Users(username),
  plan_date	Date not null,
  type 		MealType not null,
  --foodID	    MediumString references Food(id),
  recipe_id 	MediumString not null,
  --recipe_name LongString,
  primary key (username,plan_date,type,recipe_id)
);




create table ActivationCodes(
	username LongName references Users(username),
	activateCode LongString
);

create table LikeRecipe(
  username LongName REFERENCES Users(username) NOT NULL ,
  recipe_id LongString NOT NULL,
  recipe_name LongString NOT NULL,
  PRIMARY KEY (username, recipe_id)
);

