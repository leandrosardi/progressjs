get '/progressjs', :agent => /(.*)/ do
    erb :"/extensions/progressjs/views/example", :layout => :'/views/layouts/public'
end

get '/progressjs/', :agent => /(.*)/ do
    erb :"/extensions/progressjs/views/example", :layout => :'/views/layouts/public'
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