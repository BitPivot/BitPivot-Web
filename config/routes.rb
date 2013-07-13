BitPivot::Application.routes.draw do

  get '/', to: 'home#view'
  get 'mobile', to: 'mobile_splash_page#view'
  get 'blog/:year-:month-:day:title', to: 'blog#show_post'

end
