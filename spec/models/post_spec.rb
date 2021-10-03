require 'rails_helper'

RSpec.describe Post, type: :model do
  it { is_expected.to validate_length_of(:title).is_at_least(5) }
  it { is_expected.to validate_presence_of(:thumbnail) }
  it { is_expected.to belong_to :user } 
end