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
      teams = Array(Team).from_json(File.read(SEED_DIRECTORY + file))
      draws = Sim.new(teams).calc

      puts "Calcing TSM vs Rouge %"
      total_draws = draws.size
      tsm = teams.find { |t| t.name == "Team SoloMid" }.as(Team)
      # rouge = teams.find { |t| t.name == "Fnatic" }.as(Team)
      rouge = teams.find { |t| t.name == "Rouge" }.as(Team)
      tsm_rouge_draws = draws.select do |draw|
        draw.any? do |group|
          group.includes?(tsm) && group.includes?(rouge)
        end
      end

      File.write(OUTPUT_DIRECTORY + "draws.json", draws.to_pretty_json)
      File.write(OUTPUT_DIRECTORY + "tsm_rouge_draws.json", tsm_rouge_draws.to_pretty_json)
      # tsm_rouge_count = 15

      puts "#{tsm_rouge_draws.size} / #{total_draws} (#{perc(tsm_rouge_draws.size, total_draws)})"
    end
  end

  def self.perc(part : Int32, total : Int32) : String
    sprintf("%.3f%%", 100 * (part / total.to_f))
  end
end
