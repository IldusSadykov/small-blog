FactoryGirl.define do
  STREETS = %i(Pushkina Baumana Kremlyovskaya Nekrasova Butlerova).freeze

  sequence(:email) { Faker::Internet.email }
  sequence(:title) { |n| "#{Faker::Lorem.words} #{n}" }
  sequence(:street) { "#{STREETS.sample} #{rand(30)}" }
end
