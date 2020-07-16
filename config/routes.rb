Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  get 'thumbs/:feedback/:course_id/:lesson_id/:lesson_type/:course/:user_id', to: 'feedback_request#thumbs'
  get 'slack/:message/:course_id/:lesson_id/:lesson_type/:course/:user_name/:user_id', to: 'feedback_request#slack'
end
