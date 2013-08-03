require_relative '../../db/config'
require 'sqlite3'

class Legislator < ActiveRecord::Base

  # validate :lemme_get_yo_numba
  
  # def lemme_get_yo_numba
  #   errors.add(:phone, "yo digits aint rite") if
  #   phone.gsub(/\D/, "").length < 10
  # end   
  def self.find_state_legislators(state)
    by_state = self.select(:title, :firstname, :lastname, :party).where(:state => state)
    by_state.order('title desc', 'lastname')
  end

  def self.find_gender_distribution(gender)
    senate_count = self.where(:title => "Sen", :in_office =>"1").count
    house_count = self.where(:title => "Rep", :in_office => "1").count
    gender_count_senate = self.where(:gender => gender, :in_office => "1", :title => "Sen").count
    gender_count_house = self.where(:gender => gender, :in_office => "1", :title => "Rep").count
    gender_percent_senate = (gender_count_senate / senate_count.to_f) * 100
    gender_percent_house = (gender_count_house / house_count.to_f) * 100

   puts "#{gender} Senators: #{gender_count_senate} (#{gender_percent_senate.to_i}%)"
   puts "#{gender} Representatives: #{gender_count_house} (#{gender_percent_house.to_i}%)"
  end

  def self.total_representatives
    senate_count = self.where(:title => "Sen").count
    house_count = self.where(:title => "Rep").count
    puts "Senators: #{senate_count}"
    puts "Representatives: #{house_count}"
  end


  def self.state_by_legislators_count
    total_in_office = self.select(:id, :state).where(:in_office => "1")
    grouped_by_state = total_in_office.group(:state).count
    by_count = grouped_by_state.sort_by { |state, count| count }.reverse
    by_count.each do |state_count|
      if state_count[1] > 2
        puts "#{state_count[0]}: Senators: 2, #{state_count[1] - 2} Reperesentative(s)"
      else 
        puts "#{state_count[0]}: #{state_count[1]} Representative(s)"
      end
    end
  end
  
  def self.destroy_all_inactive
    self.where(:in_office => "0").destroy_all
  end

end

Legislator.state_by_legislators_count
Legislator.destroy_all_inactive
Legislator.total_representatives
