# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment, :class => 'Comments' do
    message "MyText"
    user ""
    post nil
  end
end
