BitPivot::Application.routes.draw do

  get 'blog/:year-:month-:day-:title', to: 'blog#show_post'

end
