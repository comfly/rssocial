class FeederController < ApplicationController
  
  def start
    feeder_runner = FeederHelper::FeederRunner.new
    feeder_runner.run do
      redirect_to action: 'fail'
    end
    
    @entries_count = Feed.find(1).entries.count
    
  end
  
  def fail
    render text: 'Failed'
  end
  
end
