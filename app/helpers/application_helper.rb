module ApplicationHelper

  def time_selections
    [
      ['12:00AM', '12:00AM'],
      ['1:00AM', '1:00AM'],
      ['2:00AM', '2:00AM'],
      ['3:00AM', '3:00AM'],
      ['4:00AM', '4:00AM'],
      ['5:00AM', '5:00AM'],
      ['6:00AM', '6:00AM'],
      ['7:00AM', '7:00AM'],
      ['8:00AM', '8:00AM'],
      ['9:00AM', '9:00AM'],
      ['10:00AM', '10:00AM'],
      ['11:00AM', '11:00AM'],
      ['12:00PM', '12:00PM'],
      ['1:00PM', '1:00PM'],
      ['2:00PM', '2:00PM'],
      ['3:00PM', '3:00PM'],
      ['4:00PM', '4:00PM'],
      ['5:00PM', '5:00PM'],
      ['6:00PM', '6:00PM'],
      ['7:00PM', '7:00PM'],
      ['8:00PM', '8:00PM'],
      ['9:00PM', '9:00PM'],
      ['10:00PM', '10:00PM'],
      ['11:00PM', '11:00PM']
    ]
  end

  def last_feeding(pet_feeder)
    if pet_feeder.last_feeding.nil?
      "None"
    else
      time_tag pet_feeder.last_feeding.in_time_zone(current_user.time_zone), format: '%-l:%M%p'
    end
  end

  def next_feeding(pet_feeder)
    if pet_feeder.next_feeding.nil?
      "No schuduled feed times"
    else
      time_tag pet_feeder.next_feeding.time.in_time_zone(current_user.time_zone), format: '%-l:%M%p'
    end
  end
end
