require "./draw"
require "./pool"
require "./team"

module Lol::Worlds
  class Sim
    @pool1 : Array(Team)
    @pool2 : Array(Team)

    def initialize(file_path : String)
      teams = Array(Team).from_json(File.read(SEED_DIRECTORY + file_path))
      pools = teams.group_by { |team| team.pool }
      @pool1 = pools[Pool::One]
      @pool2 = pools[Pool::Two]
    end

    def calc
      draws = sim_pool([Draw.new], @pool1)
      draws = sim_pool(draws, @pool2)
      puts "\n*************************\n\n"
      puts draws.to_pretty_json
      puts draws.size
    end

    def sim_pool1
      @pool1.each_permutation(4).first(1).map do |ordering|
        draw = Draw.new
        puts ordering.map(&.name)
        ordering.each_with_index do |team, i|
          draw[i] << team
        end
        draw
      end
    end

    def sim_pool(existing_draws : Array(Draw), pool : Array(Team))
      draws = [] of Draw
      puts "existing_draw: #{existing_draws.to_pretty_json}"
      existing_draws.map do |existing_draw|
        pool.each_permutation(4).first(2).map do |ordering|
          draw = existing_draw.clone
          puts "\n*****************\n\n"
          puts draw.to_json
          puts "draw order: #{ordering.map(&.name)}"
          ordering.each do |team|
            draw.add(team)
          end
          draw
        end.to_a
      end.flatten.to_a
    end
  end
end
# TOP, G2, TSM, DAMWON