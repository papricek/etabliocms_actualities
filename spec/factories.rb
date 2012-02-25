require 'ffaker'

FactoryGirl.define do

  sequence :title do |n|
    Faker::Lorem.sentence(3)
  end

  sequence :email do |n|
    name = [Faker::Name.first_name, Faker::Name.last_name].map { |i| i.gsub(/\W/, '') }.join(".").downcase
    "#{name}#{n}@#{Faker::Internet.domain_name}"
  end

  factory :user, :class => 'EtabliocmsCore::User' do
    email
    password "123456"
    password_confirmation "123456"
  end

  factory :category, :class => 'EtabliocmsActualities::Category' do
    title
    text { Faker::Lorem.paragraphs.to_s }
    locale "cs"
  end

  factory :actuality, :class => 'EtabliocmsActualities::Actuality' do
    title
    perex { Faker::Lorem.paragraphs.to_s }
    text { Faker::Lorem.paragraphs.to_s }
    locale "cs"
    publish_date { 1.month.ago }
    unpublish_date { 1.month.from_now }
    category { FactoryGirl.create(:category) }
  end

end
