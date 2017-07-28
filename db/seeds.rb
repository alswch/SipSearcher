# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# User: fname:string lname:string email:string username:string password:string img_src:string created_at:timestamp updated_at:timestamp
User.destroy_all
User.create([
    { fname:"Michael", lname:"Perez", email:"mike@gmail.com", username:"FreshOceans", password:"gass123" },
    { fname:"Monique", lname:"Bolosan", email:"mbolo@gmail.com", username:"Olympia", password:"bass123" },
    { fname:"Natasha", lname:"Perez", email:"nyu@gmail.com", username:"NYU", password:"lass123" },
    { fname:"Alexander", lname:"Chung", email:"alex@gmail.com", username:"alex", password:"pass123" },
    { fname:"Matt", lname:"Wojtkun", email:"matt@gmail.com", username:"matt", password:"pass123" },
    { fname:"Mike", lname:"Seff", email:"seff@gmail.com", username:"seff", password:"pass123" }
])

# Neighborhood: neighborhood_name:string created_at:timestamp updated_at:timestamp
Neighborhood.destroy_all
Neighborhood.create([
    { neighborhood_name:"U-Street Corridor" },
    { neighborhood_name:"Petworth" },
    { neighborhood_name:"11th Street" },
    { neighborhood_name:"Downtown"},
    { neighborhood_name:"Bloomingdale"},
    { neighborhood_name:"Columbia Heights"}
    # { neighborhood_name:"Georgetown" },
    # { neighborhood_name:"Adams Morgan" },
    # { neighborhood_name:"Foggybottom"},
    # { neighborhood_name:"Kalorama Triangle"},
])

# Bar: neighborhood_id:integer, name:string, address:string, latitude:float, longitude:float, phone_number:string, start_day:string, end_day:string, start_hour:string, end_hour:string beer_price:float, wine_price:float, cocktails_price:float, created_at:timestamp updated_at:timestamp
Bar.destroy_all
Bar.create([
    { neighborhood_id:1, name:"Blackjack", address:"1612 14th St NW, Washington, DC 20009", latitude:38.911631, longitude:-77.032324, phone_number:"(202) 986-5225", start_day:"Mon", end_day:"Fri", start_hour:"5:00pm", end_hour:"7:00pm", beer_price:0, wine_price:0, cocktails_price:0 },
    { neighborhood_id:2, name:"Stoney's", address:"1433 P St NW, Washington, DC 20005", latitude:38.909861, longitude:-77.033286, phone_number:"(202) 234-1818", start_day:"Mon", end_day:"Fri", start_hour:"5:00pm", end_hour:"7:00pm", beer_price:0, wine_price:0, cocktails_price:0 },
    { neighborhood_id:3, name:"Urabana", address:"Kimpton Hotel Palomar Washington DC", latitude:38.909869, longitude:-77.047399, phone_number:"(202) 956-6650", start_day:"Mon", end_day:"Fri", start_hour:"5:00pm", end_hour:"7:00pm", beer_price:0, wine_price:0, cocktails_price:0 },
    { neighborhood_id:4, name:"Jack Rose Dining Saloon", address:"2007 18th St NW, Washington, DC 20009", latitude:38.917396, longitude:-77.041292, phone_number:"(202) 588-7388", start_day:"Mon", end_day:"Fri", start_hour:"5:00pm", end_hour:"7:00pm", beer_price:0, wine_price:0, cocktails_price:0 },
    { neighborhood_id:5, name:"Jackpot", address:"726 7th St NW, Washington, DC 20001", latitude:38.899323, longitude:-77.022223, phone_number:" (202) 628-5225", start_day:"Mon", end_day:"Fri", start_hour:"5:00pm", end_hour:"7:00pm", beer_price:0, wine_price:0, cocktails_price:0 },
    { neighborhood_id:6, name:"Roofers Union", address:"2446 18th St NW, Washington, DC 20009", latitude:38.921852, longitude:-77.042668, phone_number:"(202) 232-7663", start_day:"Mon", end_day:"Fri", start_hour:"5:00pm", end_hour:"7:00pm", beer_price:0, wine_price:0, cocktails_price:0 },
    { neighborhood_id:1, name:"City Tap House of DC", address:"901 9th St NW, Washington, DC 20001", latitude:38.901003, longitude:-77.023834, phone_number:"(202) 733-5333", start_day:"Mon", end_day:"Fri", start_hour:"5:00pm", end_hour:"7:00pm", beer_price:0, wine_price:0, cocktails_price:0 }
])

# Photos: user_id:integer, bar_id:integer, caption:string, content_type:string, created_at:timestamp updated_at:timestamp
# Photos.destroy_all
# Photos.create([
#     { user_id:1, bar_id:1, },
# ])


# Report user_id:integer beer_price:integer wine_price:integer cocktails_price:integer rating:integer comment:text created_at:timestamp updated_at:timestamp
Report.destroy_all
Report.create([
    { user_id:2, beer_price:5, wine_price:6, cocktails_price:5, rating:5, comment:"Vestibulum tincidunt malesuada tellus." },
    { user_id:3, beer_price:4, wine_price:5, cocktails_price:4, rating:4, comment:"Morbi in dui quis est" },
    { user_id:3, beer_price:4, wine_price:5, cocktails_price:6, rating:3, comment:"Sed aliquet risus a tortor." },
    { user_id:4, beer_price:7, wine_price:8, cocktails_price:9, rating:5, comment:"Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos." },
    # { user_id:1, beer_price:3, wine_price:4, cocktails_price:4, rating:1, comment:"Fusce ac turpis quis ligula lacinia aliquet." },
    { user_id:2, beer_price:5, wine_price:6, cocktails_price:6, rating:2, comment:"In vel mi sit amet augue congue elementum." },
    { user_id:3, beer_price:6, wine_price:6, cocktails_price:5, rating:3, comment:"Sed cursus ante dapibus diam." },
    { user_id:4, beer_price:8, wine_price:9, cocktails_price:5, rating:4, comment:"Ut orci risus, accumsan porttitor, cursus quis, aliquet eget, justo." },
    { user_id:1, beer_price:3, wine_price:4, cocktails_price:6, rating:5, comment:"Integer id quam." },
    { user_id:2, beer_price:1, wine_price:3, cocktails_price:2, rating:4, comment:"Proin sodales libero eget ante. Nulla quam. Aenean laoreet. Vestibulum nisi lectus, commodo awe." },
    { user_id:5, beer_price:3, wine_price:3, cocktails_price:2, rating:4, comment:"The site is Gothane, a table-top 3,051ft (930m)-high mountain in the western state of Maharashtra, lashed by squally winds and ringed." },
    { user_id:5, beer_price:5, wine_price:2, cocktails_price:4, rating:3, comment:"TIn Malaysia, more than 50% of those surveyed said they used WhatsApp for news at least once a week." }
])

#Tag: category_name:string
Tag.destroy_all
Tag.create([
    { category_name:"Dive-Bar" },
    { category_name:"Fancy" },
    { category_name:"Irish" },
    { category_name:"Outdoor" },
    { category_name:"Lounge" },
    { category_name:"Speakeasy" }
])

# BarReport: bar_id:integer, report_id:integer, created_at:timestamp updated_at:timestamp
BarReport.destroy_all
BarReport.create([
    { bar_id:1, report_id:1 },
    { bar_id:2, report_id:2 },
    { bar_id:3, report_id:3 },
    { bar_id:4, report_id:4 },
    { bar_id:5, report_id:5 },
    { bar_id:6, report_id:6 },
    { bar_id:7, report_id:7 },
    { bar_id:4, report_id:8 },
    { bar_id:2, report_id:9 },
    { bar_id:2, report_id:10 },
    { bar_id:3, report_id:11 },
    { bar_id:1, report_id:12 }
])

# BarTag: bar_id:integer, tag_id:integer, created_at:timestamp updated_at:timestamp
BarTag.destroy_all
BarTag.create([
    { bar_id:1, tag_id:1 },
    { bar_id:2, tag_id:3 },
    { bar_id:3, tag_id:2 },
    { bar_id:4, tag_id:4 },
    { bar_id:5, tag_id:5 },
    { bar_id:6, tag_id:6 },
    { bar_id:7, tag_id:1 }
])
