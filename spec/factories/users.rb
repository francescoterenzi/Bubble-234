FactoryBot.define do
  factory :user do
    id                    "1"
    first_name            "Pippo"
    last_name             "De Pippis"
    username              "pippodepippis"
    email                 "pippo@test.it"
    password              "password"
    password_confirmation "password"
    admin                 "false"
  end
end
