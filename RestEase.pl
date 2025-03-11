% Define restaurant details
restaurant(bangaliana_bhoj,bengali,5,budget).
restaurant(olive_garden,italian,4.7,high_end).
restaurant(sakura,japanese,4.7,high_end).
restaurant(taco_bell,mexican,4.0,budget).
restaurant(turkey_bliss,turkish,4.3,budget).
restaurant(burger_king,fast_food,3.8,budget).
restaurant(turkish_salt,turkish,5,mid_range).


%Define menu items with price
menu(bangaliana_bhoj,loyta_shutki_bhorta,50).
menu(bangaliana_bhoj,elish_bhaja,150).
menu(olive_garden,pasta,80).
menu(sakura,shushi,120).
menu(sakura,ramen,90).
menu(turkey_bliss,baklava,200).
menu(turkish_salt,kebab,70).
menu(taco_bell,taco,110).
menu(taco_bell,burrito,170).

%Define halal food availability at restaurants
halal_food(bangaliana_bhoj).
halal_food(turkey_bliss).
halal_food(turkish_salt).


%Delivery availability
offers_delivery(pizza_hut).
offers_delivery(burger_king).
offers_delivery(olive_garden).
offers_delivery(bangaliana_bhoj).


%Define seafood options at restaurant
seafood_option(sakura,sushi).
seafood_option(sakura,ramen).
seafood_option(pizza_hut,shrimp_pizza).
seafood_option(olive_garden,seafood_pasta).

%Defind working hours(opening hour,closing hour)
working_hours(bangaliana_bhoj,10,22).
working_hours(sakura,11,23).
working_hours(taco_bell,9,22).
working_hours(olive_garden,12,23).
working_hours(turkey_bliss,10,22).



%Defining Seating Capacity
seating_capacity(bangaliana_bhoj,60).
seating_capacity(olive_garden,120).
seating_capacity(sakura,100).
seating_capacity(taco_bell,50).
seating_capacity(turkish_salt,90).


% Rule to check if a restaurant is good for a large group
good_for_large_group(Restaurant):-
    seating_capacity(Restaurant,Capacity),
    Capacity>=60.

%Rule to find most expensive item in a restaurant
most_expensive_item(Restaurant,Item,Price):-
    menu(Restaurant,Item,Price),
    \+ (menu(Restaurant,_, OtherPrice), OtherPrice > Price).


% Find restaurants serving a particular cuisine
serves_cuisine(Restaurant,Cuisine):-
    restaurant(Restaurant,Cuisine,_,_).


%Find restaurants  within budget
restaurant_within_budget(Restaurant,Budget):-
    restaurant(Restaurant,_,_,Budget).

%Finding rating of a particular restaurant
restaurant_rating(Restaurant,Rating):-
    restaurant(Restaurant,_,Rating,_).



%Finding restaurants with rating between 4.0 and 5.0
restaurant_between_rating(Restaurant,Min,Max):-
    restaurant(Restaurant,_,Rating,_),
    Rating >= Min,
    Rating =< Max.


%Finding the menu of a particular restaurant
items(Restaurant,Items):-
    menu(Restaurant,Items,_).


%Finding particular restaurant name that has halal food

has_halal_food(Restaurant):-
    halal_food(Restaurant).


%Rule to find the best high-rated budget restaurant
best_budget_restaurant(Restaurant):-
    restaurant(Restaurant,_,Rating,budget),
    \+ (restaurant(other,_, OtherRating,budget), OtherRating > Rating).


%Rule to find if a restaurand has seafood dishes
has_seafood(Restaurant):-
    seafood_option(Restaurant,_).


%Rule to find specific seafood dishes
seafood_dish(Restaurant,Dish):-
    seafood_option(Restaurant,Dish).


%Rule to find restaurant that offer both delivery and halal food.

halal_delivery_restaurant(Restaurant):-
    halal_food(Restaurant),
    offers_delivery(Restaurant).


%Rule to find restaurants that are open at  a given time

is_open(Restaurant,Time):-
    working_hours(Restaurant,Open,Close),
    Time >= Open,
    Time =< Close.


%Recursion

%Base case:Empty menu means total price is 0.
total_menu_price([],0).


%Recursive case:Add the price of the first item to the total price.
total_menu_price([(_,Price) | Rest],Total):-
    total_menu_price(Rest,Subtotal),
    Total is Price + Subtotal.



%Base case:If the list is empty,the dish is not found.
has_dish(_,[]):-fail.

%If the dish matches the first item in the list,return true.
has_dish(Dish,[(Dish,_) | _]).

%Recursively check the rest of the menu.
has_dish(Dish,[_|Rest]):-
    has_dish(Dish,Rest).


%List_Based Rules

%Base case:Empty menu has count 0.
count_dishes([],0).

%Recursive case:Increase count for each item in the list.
count_dishes([_ | Rest],Count):-
    count_dishes(Rest,SubCount),
    Count is SubCount +1.
