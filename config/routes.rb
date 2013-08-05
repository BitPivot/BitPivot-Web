BitPivot::Application.routes.draw do

  get '/', to: 'home#index'

  get 'blog', to: 'blog#index', page: 1                 # get most recent blog posts
  get 'blog/page/:page', to: 'blog#index'               # pages > 1 get earlier blog posts, 5 posts per page
  get 'blog/posts/:file_name', to: 'blog#view_post'     # get particular post
  get 'blog/authors/:author', to: 'blog#author'         # get posts by author
  get 'blog/categories/:category', to: 'blog#category'  # get posts by category
  get 'blog/:year', to: 'blog#year'                     # get year of posts
  get 'blog/:year/:month', to: 'blog#month'             # get month of posts
  get 'blog/:year/:month/:day', to: 'blog#day'          # get day of posts

  match '/blog/create_comment', to: 'blog#create_comment', via: 'post'

  get 'admin', to: 'admin#index'
  get 'admin/logout', to: 'admin#logout'
  get 'admin/blog/approve_comment/:id', to: 'admin#approve_comment'
  get 'admin/blog/delete_comment/:id', to: 'admin#delete_comment'

  match '/admin/login', to: 'admin#login', via: 'post'

end