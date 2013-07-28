BitPivot::Application.routes.draw do

  get '/', to: 'home#view'
  get 'blog', to: 'blog#view', page: 1
  get 'blog/:page', to: 'blog#view'
  get 'blog/:year-:month-:day:title', to: 'blog#show'

end
