require "./draw"
require "./pool"
require "./team"

module Lol::Worlds
  class Sim
    VERBOSE = false
    @pool1 : Array(Team)
    @pool2 : Array(Team)
    @pool3 : Array(Team)

    def initialize(teams : Array(Team))
      pools = teams.group_by { |team| team.pool }
      @pool1 = pools[Pool::One]
      @pool2 = pools[Pool::Two]
      @pool3 = pools[Pool::Three]
    end

    def calc
      draws = sim_pool([Draw.new], @pool1)
      draws = sim_pool(draws, @pool2)
      draws = sim_pool(draws, @pool3)
      puts "\n*************************\n\n" if VERBOSE
      puts draws.to_pretty_json if VERBOSE
      puts draws.size if VERBOSE
      draws
    end

    def sim_pool1
      @pool1.each_permutation(4).first(1).map do |ordering|
        draw = Draw.new
        puts ordering.map(&.name) if VERBOSE
        ordering.each_with_index do |team, i|
          draw[i] << team
        end
        draw
      end
    end

    def sim_pool(existing_draws : Array(Draw), pool : Array(Team))
      draws = [] of Draw
      puts "existing_draw: #{existing_draws.to_pretty_json}" if VERBOSE
      existing_draws.map do |existing_draw|
        pool.each_permutation(4).map do |ordering|
          draw = existing_draw.clone
          puts "\n*****************\n\n" if VERBOSE
          puts draw.to_json if VERBOSE
          puts "draw order: #{ordering.map(&.name)}" if VERBOSE
          ordering.each_with_index do |team, i|
            if !draw.add(team)
              draw.swap(ordering[i-1], team)
            end
          end
          draw
        end.to_a
      end.flatten.to_a
    end
  end
end
# TOP, G2, TSM, DAMWON