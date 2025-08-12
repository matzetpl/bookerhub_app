# spec/factories.rb
FactoryBot.define do
    factory :event do
      name { "Test Event" }
      association :organizer, factory: :user
      association :location, factory: :location
    end
  
    factory :category do
      name { "Test Category" }
    end
  
    factory :event_category do
      event
      category
    end
  
    factory :user do
      # Dodaj inne atrybuty użytkownika, które są wymagane
    end
  
    factory :location do
      # Dodaj tutaj atrybuty potrzebne dla lokalizacji
    end
end
  

  