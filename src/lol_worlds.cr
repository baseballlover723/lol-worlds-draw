require "./lol/worlds/*"

module Lol::Worlds
  VERSION          = "0.1.0"
  SEED_DIRECTORY   = "files/"
  OUTPUT_DIRECTORY = "output/"

  def self.main(args)
    puts "in main"
    Dir.mkdir_p(OUTPUT_DIRECTORY) unless Dir.exists?(OUTPUT_DIRECTORY)

    seed_files = ["seeds.json"]
    seed_files.each do |file|
      draws = Sim.new(file).calc

      puts draws.inspect
    end
  end
end
