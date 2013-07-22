BitPivot::Application.routes.draw do

  get '/', to: 'home#view'
  get 'blog/:year-:month-:day:title', to: 'blog#view'

end
