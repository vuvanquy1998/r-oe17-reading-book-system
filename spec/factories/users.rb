FactoryBot.define do
  factory :user do
    name {"admin123"}
    email {"admin123@gmail.com"}
    password {"foobar"}
    password_confirmation {"foobar"}
  end
end
