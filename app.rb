get '/progressjs', :agent => /(.*)/ do
    erb :"/extensions/progressjs/views/example", :layout => :'/views/layouts/public'
end

get '/progressjs/', :agent => /(.*)/ do
    erb :"/extensions/progressjs/views/example", :layout => :'/views/layouts/public'
end

get '/progressjs/superhero_secret.json' do
    erb :"/extensions/progressjs/views/superhero_secret"
end
post '/progressjs/superhero_secret.json' do
    erb :"/extensions/progressjs/views/superhero_secret"
end

=begin
get '/progressjs', :agent => /(.*)/ do
    redirect '/developers/progressjs'
end

get '/progressjs/', :agent => /(.*)/ do
    redirect '/developers/progressjs'
end

get '/developers/progressjs', :agent => /(.*)/ do
    erb :"/extensions/progressjs/views/example", :layout => :'/views/layouts/public'
end

get '/developers/progressjs/', :agent => /(.*)/ do
    erb :"/extensions/progressjs/views/example", :layout => :'/views/layouts/public'
end
=end