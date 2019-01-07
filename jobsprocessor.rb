require_relative 'jobsparser'
require_relative 'dependencycounter'
require_relative 'jobssorter'
class JobsProcessor
  def initialize(dependencies = {})
    @parser = dependencies[:parser] || JobsParser.new
    @counter = dependencies[:counter] || DependencyCounter.new
    @sorter = dependencies[:sorter] || JobsSorter.new
  end

  def process(input)
    parsed_input = @parser.parse(input)
    counts = @counter.count(parsed_input)	
    @sorter.sort(parsed_input,counts) 
  end
end

