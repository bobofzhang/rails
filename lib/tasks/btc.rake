namespace :btc do
  desc 'Record stats about each market'
  task :snapshot => :environment do

    Market.all.each do |market|
      puts "#{market.name} polling"
      stats = market.data_poll
      puts stats.inspect
    end

    puts "Calculating best pair"
    pairs = Market.pair_spreads
    if pairs.size > 0
      best_pair = pairs.first
      Strategy.create_two_trades(best_pair)
    end
  end

  desc 'Best strategy for current conditions'
  task :strategy => :environment do
    actions = Strategy.satisfied_bids
    actions.each do |action|
      bid = action.first
      actions = action.last
      puts "bid #{bid.depth_run.market.name} $#{bid.price} x#{bid.quantity}"
      actions.each do |action|
        ask = action.first
        quantity = action.last
        puts "ask #{ask.depth_run.market.name} $#{ask.price} x#{ask.quantity} #{quantity}"
      end
    end
  end
end