require 'rails_helper'

describe PetFeeder do
  before(:each) do
    @user = User.create(email: "email@example.com", time_zone: 'UTC', password: 'password')
    @pet_feeder = @user.pet_feeders.create(name: 'Feeder 1', url: 'http://www.example.com', last_feeding: 1.hour.ago)
  end

  context 'validations' do
    it 'is invalid without url' do
      pet_feeder = @user.pet_feeders.new(url: '', name: 'Feeder')
      expect(pet_feeder).to be_invalid
    end

    it 'is invalid without name' do
      pet_feeder = @user.pet_feeders.new(url: 'http://www.example.com', name: '')
      expect(pet_feeder).to be_invalid
    end

    it 'must have a real url' do
      pet_feeder = @user.pet_feeders.new(url: 'http://wwwexamplecom', name: '')
      expect(pet_feeder).to be_invalid
    end

    it 'must have a unique name' do
      pet_feeder = @user.pet_feeders.new(url: 'http://www.example.com', name: @pet_feeder.name)
      expect(pet_feeder).to be_invalid
    end
  end

  context 'associations' do
    it 'belongs to a user' do
      expect(@pet_feeder.user).to eq(@user)
    end

    it 'has feed times' do
      expect(@pet_feeder).to respond_to(:feed_times)
    end
  end

  context 'methods' do
    it 'can update the feed time' do
      before_time = @pet_feeder.last_feeding
      @pet_feeder.update_last_feeding
      expect(@pet_feeder.last_feeding).not_to eq(before_time)
    end

    it 'can find the next feeding' do
      time_1 = @pet_feeder.feed_times.create(time: 1.hour.from_now)
      time_2 = @pet_feeder.feed_times.create(time: 3.hours.from_now)

      expect(@pet_feeder.next_feeding).to eq(time_1)
    end
  end
end
