Rails.application.routes.draw do
  root "posts#index"

  get    "/posts",                to: "posts#index",  as: :posts
  get    "/posts/new",            to: "posts#new",    as: :new_post
  get    "/posts/:id",            to: "posts#show",   as: :post
  post   "/posts",                to: "posts#create"
  get    "/posts/:id/vote/:type", to: "posts#vote",   as: :vote
  get    "/posts/:id/:action",    to: "posts#edit",   as: :edit_post
  patch  "/posts/:id",            to: "posts#update"
end
