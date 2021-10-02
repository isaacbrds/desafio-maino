FactoryBot.define do
  factory :comment do 
    description {Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4)}
    post
    user 
  end
end
