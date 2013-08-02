require 'csv'
require_relative '../app/models/legislator'

class SunlightLegislatorsImporter
 def self.import(filename)
    csv = CSV.new(File.open(filename), :headers => true)
    csv.each do |row|
      # row.each do |field, value|
        # TODO: begin
        Legislator.create(title: row["title"], firstname: row["firstname"], middlename: row["middlename"], lastname: row["lastname"],
                          party: row["party"], state: row["state"], in_office: row["in_office"], gender: row["gender"],
                          phone: row["phone"], fax: row["fax"], website: row["website"], webform: row["webform"],
                          twitter_id: row["twitter_id"], birthdate: row["birthdate"])
        # TODO: end
      # end
    end
  end
end

# IF YOU WANT TO HAVE THIS FILE RUN ON ITS OWN AND NOT BE IN THE RAKEFILE, UNCOMMENT THE BELOW
# AND RUN THIS FILE FROM THE COMMAND LINE WITH THE PROPER ARGUMENT.
# begin
#   raise ArgumentError, "you must supply a filename argument" unless ARGV.length == 1
#   SunlightLegislatorsImporter.import(ARGV[0])
# rescue ArgumentError => e
#   $stderr.puts "Usage: ruby sunlight_legislators_importer.rb <filename>"
# rescue NotImplementedError => e
#   $stderr.puts "You shouldn't be running this until you've modified it with your implementation!"
# end
