require_relative '../../db/config'
require 'sqlite3'

class Legislator < ActiveRecord::Base

  # validate :lemme_get_yo_numba
  
  # def lemme_get_yo_numba
  #   errors.add(:phone, "yo digits aint rite") if
  #   phone.gsub(/\D/, "").length < 10
  # end   

end
